import 'dart:convert';

import '../model/option.dart';
import '../../../util/utility.dart';

class FormConfig {

  String idReport;
  int idForm;

  String submitLabel;
  String title;
  String image;

  List<Option> options;

  bool loadLast;
  bool showListBeforeForm;
  bool saveOnlyOne;

  String jsonStr;

  bool enableSubmit;
  bool isFromOptionGroup;

  String error; // IF NOT HAVE ALL DATA REQUIRED

  Function onCancel;

  FormConfig({
    this.idReport,
    this.idForm,
    this.submitLabel,
    this.title,
    this.options,
    this.image,
    this.loadLast = false,
    this.showListBeforeForm = false,
    this.saveOnlyOne = false,
    this.jsonStr,
    this.enableSubmit = true,
    this.isFromOptionGroup = false,
    this.error,
    this.onCancel,
  });

  factory FormConfig.fromJson(Map<String, dynamic> parsedJson) {
    List<Option> options = parsedJson['options']
        .map<Option>( (optionApi) => Option.fromJson(optionApi) )
        .toList();
    return FormConfig(
      idReport: parsedJson['idReport'],
      submitLabel: parsedJson['submitLabel'],
      title: parsedJson['iconTitle'],
      image: parsedJson['image'],
      loadLast: parsedJson['loadLast'] ?? false,
      showListBeforeForm: parsedJson['showListBeforeForm'] ?? false,
      saveOnlyOne: parsedJson['saveOnlyOne'] ?? false,
      error: parsedJson['error'],
      options: options,
      jsonStr: jsonEncode(parsedJson),
    );
  }

  factory FormConfig.fromOptionGroup(Option optionGroup) {
    return FormConfig(
      idReport: optionGroup.id,
      title: optionGroup.label,
      options: optionGroup.optionsToGroup,
      enableSubmit: true,
      isFromOptionGroup: true,
    );
  }

  bool isShowOption(Option option){
    return Utility.isShowOption(option, options);
  }

  addOption(Option o, Function onUpdate, context){
    int current = getCurrentExtraOptions(o);
    if ( o.maxExtraOptions != null && current == o.maxExtraOptions ) {
      Utility.showToast(context, 'Máximo ${o.maxExtraOptions} ${o.label.toLowerCase()}');
      return;
    }
    int indexToInsert = options.indexOf(o) + current + 1;
    List<Option> optionsToAdd = json.decode(o.optionsToAdd)
        .map<Option>( (o) => Option.fromJson(o)).toList();
    optionsToAdd.reversed.forEach( (Option newO) {
      newO.createdByUser = true;
      newO.indexExtraOption = current + 1;
      options.insert(indexToInsert, newO);
    });
    onUpdate();
  }

  updateOptionGroup(Option option, Function updateOptionGroup){
    if (option.optionsToAdd == null) throw 'MOST HAVE OPTIONS TO ADD';
    Option optionAdded; // Used in case of nested options adds
    int current = getCurrentExtraOptions(option);
    int indexToInsert = options.indexOf(option) + current + 1;
    List<Option> optionsToAdd = json.decode(option.optionsToAdd)
        .map<Option>((o) => Option.fromJson(o)).toList();
    optionsToAdd.reversed.forEach( (Option newO) {
      updateOptionGroup(newO);
      newO.createdByUser = true;
      newO.indexExtraOption = current + 1;
      options.insert(indexToInsert, newO);
      optionAdded = newO;
    });
    return optionAdded;
  }

  removeOption(Option oToRemove, Function onUpdate, context){
    Utility.showConfirm(context, 'Confirmación', '¿Está seguro de eliminar ${oToRemove.getLabelIndex()}?', () {
      options.remove(oToRemove);
      _updateIndexExtraOption(oToRemove);
      onUpdate();
    });
  }

  _updateIndexExtraOption(Option oToRemove){
    options.where( (Option o) => o.id == oToRemove.id ).toList()
      .asMap().forEach( (int index, Option o) {
        o.indexExtraOption = index + 1;
      });
  }

  removeOptionsCreatedByUser(){
    options = options.where( (Option o) => !o.createdByUser ).toList();
  }

  configOptions(context, Function onUpdate) {
    _evaluateExtraOptions(onUpdate, context);
    _addOnClick(context, onUpdate);
  }

  _evaluateExtraOptions(Function onUpdate, context) {
    bool needsUpdate = false;
    for ( int i = 0; i < options.length; i++ ) {
      Option option = options.asMap()[i];
      if ( option.type == 'addOption' &&
          option.minExtraOptions != null &&
          !option.minExtraOptionsAdded ) {
        int currentOptions = getCurrentExtraOptions(option);
        int needed = option.minExtraOptions - currentOptions;
        if ( needed > 0 ) {
          for ( int n = 0; n < needed; n++ ) {
            addOption(option, () => {}, context);
          }
          i += needed;
          needsUpdate = true;
          option.minExtraOptionsAdded = true;
        }
      }
    }
    if (needsUpdate) {
      onUpdate();
    }
  }

  getCurrentExtraOptions(Option option){
    Map<String, dynamic> optionJson = json.decode(option.optionsToAdd).asMap()[0];
    String id = Option.fromJson(optionJson).id;
    return options.where( (Option o) => o.id == id ).toList().length;
  }

  _addOnClick(context, Function onUpdate){
    options.forEach( (Option o) {
      switch (o.type) {
        case 'addOption':
          o.onClick = () => addOption(o, onUpdate, context);
          break;
        case 'calendar':
        case 'toggle':
          o.onClick = (value) => o.setValue(value, onUpdate);
          break;
        case 'select':
          o.onClick = (value) => o.setValueByIdOption(value, onUpdate);
          break;
        case 'selectMultiple':
          o.onClick = (values) => o.setMultipleValues(values, onUpdate);
          break;
        case 'groupInputs':
          o.onClick = (Option oToRemove) => removeOption(oToRemove, onUpdate, context);
          break;
        case 'gpsInput':
        case 'file':
        case 'fileGeoJson':
          o.onClick = () => onUpdate();
          break;
      }
    });
  }

  Option getOption(String idOption){
    Option option = getOptions(idOption)
        .firstWhere( (Option o) => o.id == idOption, orElse: () => null );
    return option;
  }

  getOptions(String idOption){
    return options
      .where( (Option o) => isShowOption(o) && o.id == idOption ).toList();
  }

  dynamic getValue(String idOption){
    Option option = getOption(idOption);
    if ( option != null ) {
      return option.getValue();
    }
    return null;
  }

  doBackupOptions(){
    options.forEach( (Option o) => o.doBackupValue() );
  }

  hasChangeOptions(){
    bool hasNewOptions = options.where((Option o) => !o.hasBackup()).toList().length > 0;
    if (hasNewOptions) return true;
    bool hasChangeOptions = options.where((Option o) => o.hasChange()).toList().length > 0;
    return hasChangeOptions;
  }

}
