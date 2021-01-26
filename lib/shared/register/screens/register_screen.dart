import '../../../util/screens/wrapScreen.dart';
import '../../../util/widgets/wrapListView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import '../../../util/user.dart';
import '../../../util/style.dart';
import '../../../util/utility.dart';

import '../model/user_register.dart';

import '../repository/register_repository.dart';

import '../../form/model/data.dart';
import '../../form/model/option.dart';
import '../../form/widgets/input.dart';
import '../../form/model/form_config.dart';

class RegisterScreen extends StatefulWidget {

  @override
  FormAppState createState() => FormAppState();
}

class FormAppState extends State<RegisterScreen> {

  FormConfig _formConfig;
  bool _loaded = false;
  bool _validPin = false;
  UserRegister _userRegister;
  final _registerRepository = RegisterRepository();

  @override
  void initState() {
    super.initState();
    loadForm().then((formConfig) => setState(() {
      _formConfig = formConfig;
      _formConfig.configOptions(context, _onSave);
      _loaded = true;
    }));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode()); // Hide keyboard on dismiss
        },
        child: _loaded ?
          WrapScreen(
            child: Builder(builder: (contextScaffold) => WrapListView(
              children: _getInputs(contextScaffold),
            )),
          ) :
          new Center( child: new CircularProgressIndicator(), ),
    );
  }

  List<Widget> _getInputs(context) {
    List<Widget> inputs = [];
    if (_validPin) {
      List<Widget> inputsRegister = _formConfig.options
          .where( (Option o) => _formConfig.isShowOption(o) ).toList()
          .map<Widget>( (Option o) => Input(config: o) ).toList();
      inputs.addAll(inputsRegister);
      inputs.add(_getSaveButton(context, _formConfig.submitLabel));
    }
    else {
      Option optionCedula = _getOption('cedula');
      inputs.add(Input(config: optionCedula));
      inputs.add(_validPinButton(context));
    }
    return inputs;
  }

  Option _getOption(String idOption){
    return _formConfig.options
        .firstWhere( (Option o) => o.id == idOption );
  }

  _onSave({idOptionChange = ''}){
    _updateOptionsFromDB(idOptionChange).then( (x) {
      setState(() {
        _formConfig.configOptions(context, _onSave);
      });
    });
  }

  Future<Null> _updateOptionsFromDB(String idOptionChange) async {

    if ( idOptionChange != 'province' &&
        idOptionChange != 'canton' ) {
      return;
    }

    Utility.showLoading(context);

    String idProvince = _getOption('province').value.id;
    String idCanton = _getOption('canton').value.id;

    if ( idOptionChange == 'province' && int.tryParse(idProvince) != null ) {
      List<Data> cantones = await _registerRepository.locations(idProvince);
      cantones.insert(0, Data(id: "seleccione", state: "Seleccione"));
      Option option = _getOption('canton');
      option.options = cantones;
      option.value = option.options.asMap()[0];
      option.hideOption = false;
    }
    if ( idOptionChange == 'canton' && int.tryParse(idCanton) != null ) {
      List<Data> parroquias = await _registerRepository.locations(idCanton);
      parroquias.insert(0, Data(id: "seleccione", state: "Seleccione"));
      Option option = _getOption('parroquia');
      option.options = parroquias;
      option.value = option.options.asMap()[0];
      option.hideOption = false;
    }

    Utility.dismissLoading(context);

  }

  Future<FormConfig> loadForm() async {
    String jsonString = await rootBundle.loadString(User.getRegisterConfig());
    final jsonResponse = json.decode(jsonString);
    print(jsonResponse);
    var jForm = jsonResponse;
    print(jForm);
    return new FormConfig.fromJson(jForm);
  }

  _saveInfo(context){
    List<Option> optionsToSave = _formConfig.options
        .where( (Option o) => !o.avoidValue() && _formConfig.isShowOption(o) )
        .toList();

    if ( !Utility.isValidForm(optionsToSave, context) ) {
      _onSave(); // SHOW WARNINGS
      return;
    }

    if ( int.tryParse(_getOption('parroquia').value.id ) == null ) {
      Utility.showToast(context, 'Seleccione su localidad');
      return;
    }
    String email = _getOption('email').getValue();
    if (!email.contains('@')) {
      Utility.showToast(context, 'La dirección de correo ingresada es incorrecta, por favor verifique.');
      return;
    }

    Utility.showConfirm(context, 'Confirmar correo', 'Se enviará un correo a $email ¿Es correcto su correo? De lo contrario, no podrá ingresar', () {
      _updateUserRegisterFromOptions();
      String data = json.encode(_userRegister.toJson());
      Utility.showLoading(context);
      _registerRepository.saveUser(data).then( (Data result) {
        if ( result.state == 'OK' ) {
          Utility.dismissLoading(context);
          Utility.showToast(context, 'Se envió un correo con su usuario y contraseña');
          Navigator.pop(context);
        } else {
          Utility.dismissLoading(context);
          Utility.showToast(context, result.state);
        }
      });
    });
  }

  _updateUserRegisterFromOptions(){
    _userRegister.name = _getOption('name').getValue();
    _userRegister.phone = _getOption('telefono').getValue();
    _userRegister.mobile = _getOption('celular').getValue();
    _userRegister.email = _getOption('email').getValue();
    _userRegister.address = _getOption('direccion').getValue();
    _userRegister.treatmentId = _getOption('treatment').value.id;
    _userRegister.nationalityId = _getOption('nationality').value.id;
    _userRegister.parroquiaId = _getOption('parroquia').value.id;
  }

  _getSaveButton(context, String submitLabel){
    return FlatButton(
      padding: const EdgeInsets.all(0.0),
      onPressed: () => _saveInfo(context),
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        width: 360,
        padding: const EdgeInsets.all(10.0),
        child: Text(
          submitLabel,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  _updateUserRegister(UserRegister userRegister){
    _getDataSelects().then( (dataSelects) {
      List<Data> treatments = dataSelects['treatments'];
      List<Data> nationalities = dataSelects['nationalities'];
      List<Data> provinces = dataSelects['provinces'];
      setState(() {
        _validPin = true;
        _userRegister = userRegister;
        _getOption('cedula').isEditable = false;
        if (userRegister.name != null ){
          Option option = _getOption('name');
          option.setTextToController(userRegister.name, _onSave);
          //option.isEditable = false;
        }
        if (userRegister.organizationManglarName != null ){
          Option option = _getOption('organization');
          option.setTextToController(userRegister.organizationManglarName, _onSave);
          option.isEditable = false;
        }
        if (treatments.length > 0) {
          Option option = _getOption('treatment');
          option.options = treatments;
          option.value = option.options.asMap()[0];
        }
        if (nationalities.length > 0) {
          Option option = _getOption('nationality');
          option.options = nationalities;
          option.value = option.options.asMap()[0];
        }
        if (provinces.length > 0) {
          provinces.insert(0, Data(id: "seleccione", state: "Seleccione"));
          Option option = _getOption('province');
          option.options = provinces;
          option.value = option.options.asMap()[0];
          _getOption('canton').hideOption = true;
          _getOption('parroquia').hideOption = true;
        }
      });
    });
  }

  Future<Map<String, dynamic>> _getDataSelects() async {
    Utility.showLoading(context);
    List<Data> treatments = await _registerRepository.treatments();
    List<Data> nationalities = await _registerRepository.nationalities();
    List<Data> provinces = await _registerRepository.locations('1'); // Ecuador
    Utility.dismissLoading(context);
    return {
      'treatments': treatments,
      'nationalities': nationalities,
      'provinces': provinces,
    };
  }

  _validPinButton(context){
    return StyleApp.getButton('Validar cedula', (){
      Option optionCedula = _getOption('cedula');
      if ( optionCedula.hasValue() ) {
        String cedula = optionCedula.getValue();
        String data = json.encode({ 'userPin': cedula });
        _registerRepository.validatePin(data).then( (UserRegister userRegister){
          if (userRegister.state == 'OK' ) {
            _updateUserRegister(userRegister);
          }
          else {
            Utility.showToast(context, userRegister.state);
          }
        });
      }
      else {
        Utility.showToast(context, 'Ingrese una cedula valida');
      }
    });
  }

}
