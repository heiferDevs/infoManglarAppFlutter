import '../infoManglar/reports/model/report.dart';

import '../constants.dart';
import 'utility.dart';

class User {

  static String role = 'public'; // By default
  static String userId;
  static String userName;
  static String pass;
  static String userPin;
  static String organizationManglarId;
  static String userEmail;
  static bool hasInternetConnection = false;

  static Function onUserChange;

  static setOnUserChange(Function onChange){
    onUserChange = onChange;
  }

  static Future<Null> setInfoFromLocalStorage() async {
    role = await Utility.getLocalStorage('role') ?? 'public';
    userName = await Utility.getLocalStorage('userName');
    pass = await Utility.getLocalStorage('pass');
    userPin = await Utility.getLocalStorage('userPin');
    organizationManglarId = await Utility.getLocalStorage('organizationManglarId');
    userId = await Utility.getLocalStorage('userId');
    userEmail = await Utility.getLocalStorage('userEmail');
    if (role == null || userName == null || pass == null || userPin == null || organizationManglarId == null || userId == null || userEmail == null) {
      await logout();
    }
  }

  static Future<Null> login(role, userId, userName, pass, userPin, userEmail, organizationManglarId) async {
    await Utility.setLocalStorage('role', role);
    await Utility.setLocalStorage('userName', userName);
    await Utility.setLocalStorage('pass', pass);
    await Utility.setLocalStorage('userPin', userPin);
    await Utility.setLocalStorage('organizationManglarId', organizationManglarId);
    await Utility.setLocalStorage('userId', userId);
    await Utility.setLocalStorage('userEmail', userEmail);
    User.role = role;
    User.userName = userName;
    User.pass = pass;
    User.userPin = userPin;
    User.organizationManglarId = organizationManglarId;
    User.userId = userId;
    User.userEmail = userEmail;
    if (onUserChange != null) onUserChange();
  }

  static Future<Null> logout() async {
    role = 'public';
    userName = null;
    pass = null;
    userPin = null;
    organizationManglarId = null;
    userEmail = null;
    userId = null;
    await Utility.setLocalStorage('role', role);
    await Utility.setLocalStorage('userName', null);
    await Utility.setLocalStorage('pass', null);
    await Utility.setLocalStorage('userPin', null);
    await Utility.setLocalStorage('organizationManglarId', null);
    await Utility.setLocalStorage('userId', null);
    await Utility.setLocalStorage('userEmail', null);
    if (onUserChange != null) onUserChange();
  }

  static getUserConfig(){
    return '${Constants.configPath}$role/user_config.json';
  }

  static getFormsConfig(){
    return '${Constants.configPath}$role/forms.json';
  }

  static getFormsConfigByRole(String role){
    return '${Constants.configPath}$role/forms.json';
  }

  static getRegisterConfig(){
    return '${Constants.configPath}register.json';
  }

  static getImageFormsIcon(String idImage){
    return '${Constants.imagesPath}forms_icons/$idImage';
  }

  static getImagePath(String idImage){
    return '${Constants.imagesPath}$idImage';
  }

  static hasOfflineMode(){
    return role == 'socio' && !Constants.isWeb;
  }

  static canEditForms(Report report){
    return (report.userId.toString() == userId) ||
        (role == 'org' && report.userType == 'socio') ||
        (role == report.userType && report.userType != 'socio');
  }

  static setHastInternetConnection(context, bool hasInternet){
    hasInternetConnection = hasInternet;
    print('modo online $hasInternetConnection');
    if (hasOfflineMode()){
      if ( hasInternetConnection ) Utility.showToast(context, 'Modo online activado');
      if ( !hasInternetConnection ) Utility.showToast(context, 'Modo offline activado');
    }
  }

}
