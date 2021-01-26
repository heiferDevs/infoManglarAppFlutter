
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';

import 'style.dart';

import '../infoManglar/drawer/model/drawer_config.dart';
import '../infoManglar/drawer/model/drawer_option.dart';
import '../infoManglar/infoForm/model/shared/file_form.dart';

import '../shared/form/model/option.dart';
import '../shared/formMenu/model/form_menu.dart';

import '../constants.dart';
import '../plugins/multi_select_dialog_item.dart';
import '../util/user.dart';

class Utility {

  static Future<dynamic> loadConfig(String path) async {
    String jsonString = await rootBundle.loadString(path);
    return json.decode(jsonString);
  }

  static Future<Map<String, dynamic>> loadConfigAsMap(String path) async {
    String jsonString = await rootBundle.loadString(path);
    return json.decode(jsonString);
  }

  static Future<Map<String, dynamic>> loadConfigForms(String role) async {
    String pathForms = User.getFormsConfigByRole(role);
    Map<String, dynamic> config = await Utility.loadConfigAsMap(pathForms);
    if (role != 'org') {
      return config;
    }
    // In case of org join with socio
    String pathFormsSocio = User.getFormsConfigByRole('socio');
    Map<String, dynamic> configSocio = await Utility.loadConfigAsMap(pathFormsSocio);
    config.addAll(configSocio);
    return config;
  }

  static String jsonToString(Map<String, dynamic> jsonObj) {
    return json.encode(jsonObj);
  }

  static Future<String> getLocalStorage(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<Null> setLocalStorage(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<Set<int>> getValueMultipleSelect(BuildContext context, List<String> options, String title, Set<int> selected ) async {

    final items = options.map<MultiSelectDialogItem<int>>((String option){
      var index = options.indexOf(option) + 1;
      return MultiSelectDialogItem(index, option);
    }).toList();

    final selectedValues = await showDialog<Set<int>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          title: title,
          items: items,
          initialSelectedValues: selected,
        );
      },
    );
    return selectedValues;
  }

  static navTo(context, Widget w){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => w),
    );
  }

  static navBack(context){
    Navigator.pop(context);
  }

  static Future<bool> showConfirm(context, String title, String content, Function onConfirm){
    // flutter defined function
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(title, style: StyleApp.getStyleTitle(18),),
          content: Text(content),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            FlatButton(
              child: Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop(true);
                onConfirm();
              },
            ),
          ],
        );
      },
    ) ?? false;
  }

  static Future<bool> showConfirmNoCancel(context, String title, String content, Function onConfirm){
    // flutter defined function
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(title, style: StyleApp.getStyleTitle(18),),
          content: Text(content),
          actions: <Widget>[
            FlatButton(
              child: Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop(true);
                onConfirm();
              },
            ),
          ],
        );
      },
    ) ?? false;
  }

  static showToast(BuildContext context, String message) {
    print('showToast $message');
    if ( Constants.isWeb ) {
        try {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(message),
          ));
        } catch (e) {}
        return;
    }
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1
    );
  }

  static bool _isShowingLoading = false;

  static showLoading(BuildContext context, {msg: 'Cargando..'}){
    if ( _isShowingLoading ) return;
    if ( MaterialLocalizations.of(context) == null ) {
      Utility.showToast(context, msg);
      return;
    }
    _isShowingLoading = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: 140,
            height: 138,
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30))
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(Constants.colorPrimary)),
                ),
                SizedBox(width: 20, height: 20,),
                Text(msg, style: TextStyle(fontSize: 14),),
              ],
            ),
          ),
        );
      },
    );
  }

  static dismissLoading(BuildContext context){
    if ( !_isShowingLoading ) return;
    _isShowingLoading = false;
    Navigator.pop(context);
  }

  static fixName(String name){
    if ( name == null) return name;
    return name.replaceAll(new RegExp(r"\s+\b|\b\s"), "");
  }

  static int getInt(value){
    if (value == null) return null;
    return int.tryParse(value.toString());
  }

  static double getDouble(value){
    if (value == null) return null;
    return double.tryParse(value.toString());
  }

  static filterNull(list){
    if (list == null) return null;
    return list.where( (o) => o != null && o != '' ).toList();
  }

  static List<FormMenu> getFormMenus(DrawerConfig drawerConfig){
    List<FormMenu> list = [];
    drawerConfig.options.forEach((DrawerOption drawerOption){
      if (drawerOption.formMenu != null) list.add(drawerOption.formMenu);
      drawerOption.subOptions.forEach((DrawerOption drawerSubOption){
        if (drawerSubOption.formMenu != null) list.add(drawerSubOption.formMenu);
      });
    });
    return list;
  }

  static bool isShowOption(Option o, List<Option> options){
    if ( o.hideOption ) return false;
    if ( o.showIfId == null ) return true;
    Option optionShow = options.firstWhere( (Option option){
      return option.id == o.showIfId;
    }, orElse: () => throw 'Add ${o.showIfId} in forms config json');
    if ( optionShow.value == null ) return false; // before if ( optionShow == null ) return true;
    return optionShow.value.state == o.showIfSelected && Utility.isShowOption(optionShow, options);
  }

  static Map<String, dynamic> removeNull(Map<String, dynamic> mapJson) {
    List<String> toRemove = [];
    mapJson.forEach( (String k, dynamic v) {
      if ( v == null || v == '' ) toRemove.add(k);
    });
    toRemove.forEach((k) => mapJson.remove(k));
    return mapJson;
  }

  static FileForm getFileForm( dynamic form, String idOption ) {
    if ( form == null || form.fileForms == null ) return null;
    List<FileForm> fileForms = form.fileForms;
    return fileForms.firstWhere((FileForm f) => f.idOption== idOption, orElse: () => null);
  }

  static bool isValidForm(List<Option> optionsToSave, context){
    List<Option> noValid = optionsToSave.where( (Option o) => !o.valid() ).toList();
    List<Option> hasErrors = optionsToSave.where( (Option o) => Utility.hasErrorInput(o) ).toList();
    if (noValid.length + hasErrors.length == 0) return true;

    List<String> labelsMissed = noValid.map<String>( (Option o) => o.label ).toList();
    String missed = labelsMissed.join(', ').replaceAll(':', '');
    String missedError = noValid.length != 0 ? 'Falta información: $missed' : '';

    List<String> labelsErrors = hasErrors.map<String>( (Option o) => Utility.getErrorInput(o) ).toList();
    if (noValid.length != 0) labelsErrors.add(missedError);
    String errors = labelsErrors.join(', ');

    Utility.showToast(context, '$errors');
    noValid.forEach((Option o) => o.showValidate = true );
    hasErrors.forEach((Option o) => o.showValidate = true );
    return false;
  }

  static Widget getCircularProgress() {
    return Center( child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Color(Constants.colorPrimary)),
    ),);
  }

  static String maxChars(String word, int maxChar){
    if (word == null || word == '') return word;
    if (word.length <= maxChar) return word;
    return word.substring(0, maxChar);
  }

  static Widget getErrorMessage(){
    String msg = 'No de pudo establecer conexión con el servidor';
    if (!User.hasInternetConnection){
      msg = 'No tiene conexión a internet';
    }
    return Container(
      height: 200,
      child: Center(
        child: Text(msg, style: StyleApp.getStyleSubTitle(13)),
      )
    );
  }

  static String getNameFile(Option option, String currentName) {
    String ext = currentName.substring(currentName.lastIndexOf('.')).toLowerCase();
    if (option.hasValue()) {
      String baseOld = option.getValue().substring(0, option.getValue().lastIndexOf('.'));
      return '$baseOld$ext';
    }
    String orgId = User.organizationManglarId;
    String nameFileBase = 'o$orgId${option.id}';
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    return '$nameFileBase$timestamp$ext';
  }

  static String getNameFileFromOptionId(String optionId, String currentName) {
    String ext = currentName.substring(currentName.lastIndexOf('.')).toLowerCase();
    String orgId = User.organizationManglarId;
    String nameFileBase = 'o$orgId$optionId';
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    return '$nameFileBase$timestamp$ext';
  }

  static List<TextInputFormatter> validateInput(String typeValidate){
    switch(typeValidate){
      case 'contact-number':
        return [
          WhitelistingTextInputFormatter(RegExp(r"[\d]")),
          LengthLimitingTextInputFormatter(15),
        ];
      case 'contact-mobile':
        return [
          WhitelistingTextInputFormatter(RegExp(r"[\d]")),
          LengthLimitingTextInputFormatter(10),
        ];
      case 'contact-email':
        return [
          WhitelistingTextInputFormatter(RegExp(r"[^A-Z]")),
        ];
      case 'pin-ecuador':
        return [
          WhitelistingTextInputFormatter(RegExp(r"[\d]")),
          LengthLimitingTextInputFormatter(10),
        ];
      case 'pin-extranjero':
        return [
          WhitelistingTextInputFormatter(RegExp(r"[a-z0-9]")),
          LengthLimitingTextInputFormatter(15),
        ];
      case 'year-number':
        return [
          WhitelistingTextInputFormatter(RegExp(r"[0-9]")),
          LengthLimitingTextInputFormatter(4),
        ];
      case 'only-numbers':
        return [
          WhitelistingTextInputFormatter(RegExp(r"[0-9]")),
          LengthLimitingTextInputFormatter(15),
        ];
      case 'percentage':
        return [
          WhitelistingTextInputFormatter(RegExp(r"[0-9]")),
          LengthLimitingTextInputFormatter(3),
        ];
      default:
        return [];
    }
  }

  static bool hasErrorInput(Option option){
    return Utility.getErrorInput(option) != null;
  }

  static String getErrorInput(Option option) {
    if (!option.hasValue() || option.validate == null) return null;
    switch (option.validate) {
      case 'year-number':
        return !Utility.passYear(option) ? 'Año de creación inválido' : null;
      case 'contact-mobile':
        return !Utility.passContactMobile(option) ? 'Número de celular inválido' : null;
      case 'contact-email':
        return !Utility.passContactEmail(option) ? 'Correo inválido' : null;
      case 'pin-ecuador':
        return !Utility.passPinEcuador(option) ? 'Número de cédula inválido' : null;
      case 'percentage':
        return !Utility.passPercentage(option) ? 'Porcentaje inválido' : null;
    }
    return null;
  }

  static bool passYear(Option option) {
    int currentYear = DateTime.now().year;
    int maxYearsOld = 101;
    return option.hasValue() && option.getValue() <= currentYear && option.getValue() > (currentYear - maxYearsOld);
  }

  static bool passContactMobile(Option option) {
    return option.hasValue() && option.getValue().toString().length == 10;
  }

  static bool passContactEmail(Option option) {
    return option.hasValue() && option.getValue().toString().indexOf('@') > 0 &&
        option.getValue().toString().indexOf('.') > 0;
  }

  static bool passPinEcuador(Option option) {
    return option.hasValue() && option.getValue().toString().length == 10;
  }

  static bool passPercentage(Option option) {
    return option.hasValue() && option.getValue() <= 100 && option.getValue() >= 0;
  }

}
