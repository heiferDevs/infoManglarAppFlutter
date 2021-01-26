
import '../../../infoManglar/config/model/allowed_user.dart';
import '../../../infoManglar/config/repository/config_repository.dart';
import '../../../shared/form/model/data.dart';
import '../../../shared/form/model/option.dart';
import '../../../shared/form/widgets/input.dart';
import '../../../shared/register/model/cedula.dart';
import '../../../shared/register/repository/register_repository.dart';
import '../../../util/screens/wrapScreen.dart';
import 'package:flutter/material.dart';

import '../../../util/style.dart';
import '../../../util/utility.dart';


class AllowedUserScreen extends StatefulWidget{

  final String userType;
  final VoidCallback onSave;
  final int allowedUserId;

  AllowedUserScreen({
    @required this.userType,
    @required this.onSave,
    this.allowedUserId,
  });

  @override
  _State createState() {
    return _State();
  }
}

class _State extends State<AllowedUserScreen> {

  bool _validPin = false;
  bool _isLoading = true;

  final _registerRepository = RegisterRepository();
  final _configRepository = ConfigRepository();

  // Options
  final Option pinOption = Option(label: 'Cédula', type: 'input', typeInput: 'text');
  final Option nameOption = Option(label: 'Nombre', type: 'input', typeInput: 'text');
  final Option organizationsOption = Option(label: 'Organización', type: 'select', options: []);
  final Option provincesOption = Option(label: 'Provincias', type: 'select', options: []);

  @override
  void initState() {
    super.initState();
    provincesOption.onClick = (value) => _addActionSelect(provincesOption, value);
    organizationsOption.onClick = (value) => _addActionSelect(organizationsOption, value);
    _updateAllowedUser();
  }

  _addActionSelect(Option option, String value){
    option.setValueByIdOption(value, ({idOptionChange = ''}){
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {

    final pinInput = Input(config: pinOption);
    final nameInput = Input(config: nameOption);
    final organizationsInput = Input(config: organizationsOption);
    final provincesInput = Input(config: provincesOption);

    return WrapScreen(
      child: Builder(builder: (contextScaffold) => _isLoading ?
        Utility.getCircularProgress() :
        Container(
            padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: !_validPin ?
            ListView(
              children: <Widget>[
                pinInput,
                _validPinButton(contextScaffold),
              ],
            ) :
            ListView(
              children: <Widget>[
                pinInput,
                nameInput,
                organizationsInput,
                provincesInput,
                _saveButton(contextScaffold),
              ],
            )
        )
      )
    );
  }



  _validPinButton(context){
    return StyleApp.getButton('Guardar', () {
      if ( pinOption.hasValue() ) {
        String pin = pinOption.getValue();
        print('pin $pin');
        Utility.showLoading(context);
        _registerRepository.cedula(pin).then( (Cedula cedula) {
          print('error <${cedula.error}>');
          if (cedula.error == 'NO ERROR') {
            _updateOptionsFromDB(null, null).then((_){
              Utility.dismissLoading(context);
              setState(() {
                pinOption.isEditable = false;
                nameOption.isEditable = false;
                _validPin = true;
                nameOption.setValueInit(cedula.nombre);
              });
            });
          }
          else {
            Utility.dismissLoading(context);
            Utility.showToast(context, cedula.error);
          }
        });
      }
      else {
        Utility.showToast(context, 'Ingrese una cedula valida');
      }
    });
  }

  _saveButton(context){
    return StyleApp.getButton('Guardar', () {
      if ( pinOption.hasValue() && nameOption.hasValue() ) {
        int organizationManglarId = Utility.getInt(organizationsOption.value.id);
        int geloId = Utility.getInt(provincesOption.value.id);
        AllowedUser allowedUser = AllowedUser(
            allowedUserId: widget.allowedUserId,
            allowedUserName: nameOption.getValue(),
            allowedUserPin: pinOption.getValue(),
        );
        Utility.showLoading(context);
        _configRepository.saveAllowedUser(widget.userType, allowedUser, organizationManglarId, geloId)
          .then( (Data result) {
            Utility.dismissLoading(context);
            print('error <${result.state}>');
            if (result.state == 'OK') {
              Utility.navBack(context);
              Utility.showToast(context, 'Se guardo correctamente');
              widget.onSave();
            }
            else {
              Utility.showToast(context, result.state);
            }
          });
      }
      else {
        Utility.showToast(context, 'Ingrese una cedula valida');
      }
    });
  }

  Future<Null> _updateOptionsFromDB(String orgName, String geoName) async {
    List<Data> organizations = await _configRepository.getOrganizationsByType(widget.userType);
    organizationsOption.options = organizations;
    organizationsOption.value = organizationsOption.options.asMap()[0];
    if (orgName != null) {
      Data value = organizationsOption.options.firstWhere((Data d) => d.state == orgName, orElse:() => null);
      if (value != null) organizationsOption.value = value;
    }

    List<Data> provinces = await _registerRepository.locations('1');
    provincesOption.options = provinces;
    provincesOption.value = provincesOption.options.asMap()[0];
    if (geoName != null) {
      Data value = provincesOption.options.firstWhere((Data d) => d.state == geoName, orElse:() => null);
      if (value != null) provincesOption.value = value;
    }
  }

  void _updateAllowedUser() {
    if (widget.allowedUserId == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    _configRepository.getAllowedUser(widget.allowedUserId).then((AllowedUser allowedUser){
      _updateOptionsFromDB(allowedUser.organizationManglarName, allowedUser.geographicalLocationName).then((_){
        setState(() {
          _isLoading = false;
          pinOption.isEditable = false;
          nameOption.isEditable = false;
          _validPin = true;
          pinOption.setValueInit(allowedUser.allowedUserPin);
          nameOption.setValueInit(allowedUser.allowedUserName);
        });
      });
    });
  }

}
