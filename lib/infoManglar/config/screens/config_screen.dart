
import '../../../infoManglar/config/model/allowed_user.dart';
import '../../../infoManglar/config/model/organization_manglar.dart';
import '../../../infoManglar/config/repository/config_repository.dart';
import '../../../infoManglar/config/screens/organization_screen.dart';
import '../../../infoManglar/config/widgets/table_list.dart';
import '../../../shared/form/model/data.dart';
import '../../../shared/form/model/option.dart';
import '../../../shared/form/widgets/input.dart';
import '../../../util/style.dart';
import '../../../util/utility.dart';
import '../model/config_form.dart';
import 'package:flutter/material.dart';

import 'allowed_user_screen.dart';

class ConfigScreen extends StatefulWidget{
  @override
  _State createState() {
    return _State();
  }
}

class _State extends State<ConfigScreen> {

  final _configRepository = ConfigRepository();
  bool _loaded = false;

  ConfigForm _configForm;
  List<OrganizationManglar> _orgs = [];
  List<AllowedUser> _sociosAllowed = [];
  List<AllowedUser> _orgsAllowed = [];
  List<AllowedUser> _maesAllowed = [];
  List<AllowedUser> _inpsAllowed = [];
  List<AllowedUser> _superAdminsAllowed = [];

  final Option versionOption = Option(label: 'Versión', type: 'input', typeInput: 'textPersonName', placeholder: 'Ejemplo: 1.0.7');

  @override
  void initState() {
    super.initState();
    updateData();
  }

  updateData(){
    _loadData().then( (_){
      setState(() {
        _loaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    final versionInput = Input(config: versionOption);

    final headerTitle = Container(
      padding: EdgeInsets.fromLTRB(10, 30, 10, 30),
      child: Center(
        child: Text(
          'CONFIGURACIÓN',
          style: StyleApp.getStyleTitle(22),
        ),
      ),
    );

    final changeVersion = StyleApp.getButton('ACTUALIZAR VERSIÓN', () {
      _changeVersion(context);
    });

    final orgTable = TableList(
      title: 'Organizaciones',
      data: _getDataOrganizations(),
      titles: ['Id', 'Nombre'],
      onCreateNew: () => _onCreateNewOrg(),
      onRemove: (int organizationManglarId) => _onRemoveOrg(organizationManglarId),
      onEdit: (int organizationManglarId) => _onEditOrg(organizationManglarId),
    );

    return Container(
      child: ListView(
        children: <Widget>[
          headerTitle,
          _loaded ? versionInput : Utility.getCircularProgress(),
          _loaded ? changeVersion : Utility.getCircularProgress(),
          _loaded ? orgTable : Utility.getCircularProgress(),
          _loaded ? _getTableListAllowedUsers('super-admin', 'Super Administradores') : Utility.getCircularProgress(),
          _loaded ? _getTableListAllowedUsers('org', 'ORG Administradores') : Utility.getCircularProgress(),
          _loaded ? _getTableListAllowedUsers('mae', 'MAE Administradores') : Utility.getCircularProgress(),
          _loaded ? _getTableListAllowedUsers('inp', 'INP Administradores') : Utility.getCircularProgress(),
          _loaded ? _getTableListAllowedUsers('socio', 'Socios') : Utility.getCircularProgress(),
        ],
      ),
    );

  }

  Future<Null> _loadData() async {
    _orgs = await _configRepository.getOrgs();
    _sociosAllowed = await _configRepository.getAllowedUsers('socio');
    _orgsAllowed = await _configRepository.getAllowedUsers('org');
    _maesAllowed = await _configRepository.getAllowedUsers('mae');
    _inpsAllowed = await _configRepository.getAllowedUsers('inp');
    _superAdminsAllowed = await _configRepository.getAllowedUsers('super-admin');
    _configForm = await _configRepository.getConfigForm();
    versionOption.setValueInit(_configForm.version);
  }

  List<List<String>> _getDataOrganizations() {
    List<List<String>> result = [];
    for ( OrganizationManglar org in _orgs ) {
      if (org.organizationManglarType != OrganizationManglar.ORG_TYPE) {
        continue;
      }
      List<String> row = [
        org.organizationManglarId.toString(),
        org.organizationManglarName
      ];
      result.add(row);
    }
    return result;
  }

  TableList _getTableListAllowedUsers(String userType, String title){
    List<List<String>> data;
    if (userType == 'socio') data = _getDataAllowedUsers(_sociosAllowed);
    if (userType == 'org') data = _getDataAllowedUsers(_orgsAllowed);
    if (userType == 'mae') data = _getDataAllowedUsers(_maesAllowed);
    if (userType == 'inp') data = _getDataAllowedUsers(_inpsAllowed);
    if (userType == 'super-admin') data = _getDataAllowedUsers(_superAdminsAllowed);
    if (data == null) throw 'ADD GET DATA FOR $userType';
    return TableList(
      title: title,
      data: data,
      titles: ['Id', 'Nombre', 'Cédula', 'Org.'],
      onCreateNew: () => _onCreateNew(userType),
      onRemove: (int allowedUserId) => _onRemove(allowedUserId),
      onEdit: (int allowedUserId) => _onEdit(userType, allowedUserId),
    );
  }

  _onCreateNewOrg(){
    Utility.navTo(
      context,
      OrganizationScreen(
        onSave: () => updateData(),
      ),
    );
  }

  _onEditOrg(int organizationManglarId){
    print('on edit $organizationManglarId');
    Utility.navTo(
      context,
      OrganizationScreen(
        onSave: () => updateData(),
        organizationManglarId: organizationManglarId,
      ),
    );
  }

  _onRemoveOrg(int organizationManglarId){
    Utility.showConfirm(context, 'Atención','¿Esta seguro de remover al usuario id: $organizationManglarId?', (){
      Utility.showLoading(context);
      _configRepository.removeOrganizationManglar(organizationManglarId).then( (Data result){
        Utility.dismissLoading(context);
        if (result.state == 'OK') {
          Utility.showToast(context, 'Se removió correctamente');
          updateData();
        }
        else {
          Utility.showToast(context, result.state);
        }
      });
    });
  }

  _onCreateNew(String userType){
    Utility.navTo(
      context,
      AllowedUserScreen(
        userType: userType,
        onSave: () => updateData(),
      ),
    );
  }

  _onEdit(String userType, int allowedUserId){
    print('on edit $userType $allowedUserId');
    Utility.navTo(
      context,
      AllowedUserScreen(
        userType: userType,
        onSave: () => updateData(),
        allowedUserId: allowedUserId,
      ),
    );
  }

  _onRemove(int allowedUserId){
    Utility.showConfirm(context, 'Atención','¿Esta seguro de remover al usuario id: $allowedUserId?', (){
      Utility.showLoading(context);
      _configRepository.removeAllowedUser(allowedUserId).then( (Data result){
        Utility.dismissLoading(context);
        if (result.state == 'OK') {
          Utility.showToast(context, 'Se removió correctamente');
          updateData();
        }
        else {
          Utility.showToast(context, result.state);
        }
      });
    });
  }

  List<List<String>> _getDataAllowedUsers(List<AllowedUser> allowedUsers){
    List<List<String>> result = [];
    for ( AllowedUser user in allowedUsers ) {
      List<String> row = [
        user.allowedUserId.toString(),
        user.allowedUserName,
        user.allowedUserPin,
        user.organizationManglarName,
      ];
      result.add(row);
    }
    return result;
  }

  _changeVersion(context){
    if ( _configForm == null ) {
      Utility.showToast(context, 'No se logró obtener la configuración de versión actual');
      return;
    }
    if ( !versionOption.hasValue() ) {
      Utility.showToast(context, 'Debe llenar el valor de version ejemplo 1.0.7');
      return;
    }
    String newVersion = versionOption.getValue();
    if ( _configForm.version ==  newVersion ) {
      Utility.showToast(context, 'No realizó ningún cambio en la versión');
      return;
    }

    Utility.showConfirm(context, 'Atención','¿Esta seguro de cambiar la versión de ${_configForm.version} a $newVersion?', () {
      Utility.showLoading(context);
      _configForm.version = newVersion;

      _configRepository.saveConfigForm(_configForm).then( (Data result) {
        Utility.dismissLoading(context);
        if (result.state == 'OK') {
          Utility.showToast(context, 'Se actualizó con exito');
          return;
        }
        Utility.showToast(context, '${result.state}');
      });
    });
  }

}
