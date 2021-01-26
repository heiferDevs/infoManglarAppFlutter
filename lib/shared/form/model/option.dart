
import '../../../infoManglar/infoForm/model/shared/file_form.dart';

import '../../../plugins/fileExport.dart';
import '../../../plugins/file_picker.dart';
import '../../../util/utility.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import './data.dart';

class Option {

  static const NO_VALUE = 'NO_VALUE';

  String id, label, type, placeholder, typeInput, pathImageVideo;
  bool isRequired = false, createdByUser = false, showValidate = false, isEditable = true, hideOption = false;
  List<Data> options;
  Function onClick;
  String optionsToAdd; // IS A JSON STRING, MOST BE DECODED
  List<Option> optionsToGroup;
  String showIfId, showIfSelected;
  Data value; // THE VALUE TO SAVE
  String textHelp;
  Set<int> selectedValues; // Used on multiple selection
  TextEditingController textController = TextEditingController();
  int minExtraOptions, maxExtraOptions, indexExtraOption;
  bool minExtraOptionsAdded = false;
  String url;
  FileExport fileExport;
  int idForm;
  String validate; // Used to validate the input

  OptionBackup optionBackup; // used to restore value in case of cancel

  Option({
    this.id,
    this.label,
    this.type,
    this.isRequired,
    this.placeholder,
    this.typeInput,
    this.pathImageVideo,
    this.textHelp,
    this.value,
    this.options,
    this.optionsToAdd,
    this.optionsToGroup,
    this.showIfId,
    this.url,
    this.showIfSelected,
    this.selectedValues,
    this.minExtraOptions,
    this.maxExtraOptions,
    this.fileExport,
    this.validate,
  });

  // FROM API
  factory Option.fromJson(optionApi){
    List<Data> options = [];
    List<Option> optionsToGroup = [];
    Data value;
    if (optionApi['options'] != null) {
      options = optionApi['options'].map<Data>( (o) => Data(id: o.toString(), state: o.toString()) ).toList();
      if(options.length == 0) options.add(new Data(state: 'NO_DATA', id: 'NO_DATA'));
      value = options[0];
    }
    if (optionApi['optionsToGroup'] != null) {
      optionsToGroup = optionApi['optionsToGroup']
          .map<Option>( (optionApi) => Option.fromJson(optionApi) )
          .toList();
    }
    return Option(
      id: optionApi['id'],
      label: optionApi['label'],
      type: optionApi['type'],
      isRequired: optionApi['isRequired'] != null && optionApi['isRequired'],
      placeholder: optionApi['placeholder'],
      typeInput: optionApi['typeInput'],
      pathImageVideo: optionApi['image'],
      value: value,
      textHelp: optionApi['textHelp'],
      validate: optionApi['validate'],
      showIfId: optionApi['showIfId'],
      showIfSelected: optionApi['showIfSelected'],
      options: options,
      optionsToAdd: json.encode(optionApi['optionsToAdd']),
      optionsToGroup: optionsToGroup,
      selectedValues: [1].toSet(), // By default
      minExtraOptions: optionApi['minExtraOptions'],
      maxExtraOptions: optionApi['maxExtraOptions'],
    );
  }

  dynamic getValue(){
    switch (type) {
      case 'selectMultiple':
        return selectedValues.fold('', (r, k) =>'$r ${options[k-1]}').trim();
      case 'toggle':
        return value == null ? false : value.id == 'true';
      case 'inputTextArea':
      case 'inputTextAreaWithHelp':
      case 'inputWithHelp':
      case 'input':
        return _getValueInput(typeInput, textController.text);
      case 'file':
      case 'fileGeoJson':
      case 'select':
      case 'gpsInput':
      case 'calendar':
        return value == null ? null : value.id;
      case 'groupInputs':
        return optionsToGroup.map( (o) => o.getValue() ?? '' ).toList().join(' ');
      case 'addOption':
        return null;
      default:
        throw 'ADD GET VALUE FOR TYPE $type';
    }
  }

  dynamic getValueNoNull(){
    return getValue() ?? NO_VALUE;
  }

  dynamic _getValueInput(String typeInput, String current) {
    switch (typeInput) {
      case 'number':
        return Utility.getInt(current);
      case 'decimal':
        return Utility.getDouble(current);
      default:
        return current == '' ? null : current;
    }
  }

  setValueInit(dynamic initValue){
    if (initValue == null) return;
    switch (type) {
      case 'input':
      case 'inputWithHelp':
      case 'inputTextArea':
      case 'inputTextAreaWithHelp':
        textController.text = initValue == null ? '' : initValue.toString(); // Only Strings
        break;
      case 'calendar':
      case 'toggle':
      case 'select':
      case 'gpsInput':
        value = Data(id: initValue.toString(), state: initValue.toString());
        break;
      case 'file':
      case 'fileGeoJson':
        FileForm fileForm = initValue;
        value = Data(id: fileForm.name, state: fileForm.name);
        typeInput = type == 'fileGeoJson' ? 'geojson' : FilePickerApp.getType(fileForm.name);
        url = fileForm.url;
        idForm = fileForm.id;
        break;
      default:
        throw 'Add set value init for type $type';
    }
  }

  dynamic getValueFromOptionsGroup(String idOption, List<Option> options){
    Option option = getOptionFromOptionsGroup(idOption);
    if ( option != null && Utility.isShowOption(option, options)) {
      return option.getValue();
    }
    return null;
  }

  Option getOptionFromOptionsGroup(String idOption){
    return optionsToGroup.firstWhere(
      (Option o) => o.id == idOption, orElse: () => null
    );
  }

  bool hasValue(){
    dynamic value = getValue();
    return value != null && value != '';
  }

  bool avoidValue(){
    return type == 'title' || type == 'subtitle' || type == 'addOption';
  }

  bool valid(){
    if (!isRequired) return true;
    return hasValue();
  }

  setValueByIdOption(String idValue, onUpdate){
    value = options.firstWhere((option) => option.id == idValue);
    onUpdate(idOptionChange: id);
  }

  setValue(String v, onUpdate){
    value = Data(id: v, state: v);
    onUpdate(idOptionChange: id);
  }

  setMultipleValues(values, Function onUpdate){
    selectedValues = values;
    onUpdate(idOptionChange: id);
  }

  setTextToController(String value, Function onUpdate){
    textController.text = value;
    onUpdate(idOptionChange: id);
  }

  getLabelIndex(){
    if(indexExtraOption == null) return label;
    return '$label $indexExtraOption';
  }

  doBackupValue(){
    optionBackup = OptionBackup.fromOption(this);
    doBackupOptionsToGroup();
  }

  restoreFromBackup(){
    if (!hasBackup()) return;
    optionBackup.restoreOption(this);
    restoreFromBackupOptionsToGroup();
  }

  hasBackup(){
    return optionBackup != null;
  }

  hasChange(){
    if (!hasBackup()) return false;
    bool hasChange = optionBackup.hasChanges(this);
    bool hasChangesOptionsToGroup = hasChangeOptionsToGroup();
    return hasChange || hasChangesOptionsToGroup;
  }

  hasChangeOptionsToGroup(){
    if (optionsToGroup == null) return false;
    bool hasChanges = optionsToGroup.where((Option o) => o.hasChange()).toList().length > 0;
    return hasChanges;
  }

  doBackupOptionsToGroup(){
    if (optionsToGroup == null) return;
    optionsToGroup.forEach( (Option o) => o.doBackupValue() );
  }

  restoreFromBackupOptionsToGroup(){
    if (optionsToGroup == null) return;
    optionsToGroup.forEach( (Option o) => o.restoreFromBackup() );
  }

}

class OptionBackup {

  String dataId;
  String dataState;
  String typeInput;
  String textController;
  String url;

  int idForm;

  OptionBackup({
    this.dataId,
    this.dataState,
    this.typeInput,
    this.textController,
    this.url,
    this.idForm,
  });

  factory OptionBackup.fromOption(Option option){
    return new OptionBackup(
      dataId: option.value == null ? null : option.value.id,
      dataState: option.value == null ? null : option.value.state,
      typeInput: option.typeInput,
      textController: option.textController.text,
      url: option.url,
      idForm: option.idForm,
    );
  }

  restoreOption(Option option){
    if (dataId != null && dataState != null) {
      option.value = new Data(id: dataId, state: dataState);
    }
    option.typeInput = typeInput;
    option.textController.text = textController;
    option.url = url;
    option.idForm = idForm;
  }

  hasChanges(Option option){
    OptionBackup currentBackUp = OptionBackup.fromOption(option);
    if (dataId != currentBackUp.dataId) return true;
    if (dataState != currentBackUp.dataState) return true;
    if (typeInput != currentBackUp.typeInput) return true;
    if (textController != currentBackUp.textController) return true;
    if (url != currentBackUp.url) return true;
    if (idForm != currentBackUp.idForm) return true;
    return false;
  }

}