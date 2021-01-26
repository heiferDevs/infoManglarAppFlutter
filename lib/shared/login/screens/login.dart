import 'package:flutter/material.dart';

import '../../../util/utility.dart';
import '../../../util/user.dart';
import '../../../util/style.dart';
import '../../../constants.dart';
import '../../register/screens/register_screen.dart';

import '../repository/login_repository.dart';

import 'dart:convert';

class Login extends StatefulWidget{
  @override
  _State createState() {
    return _State();
  }
}

class _State extends State<Login>{

  TextEditingController _userController = TextEditingController(text: '');
  TextEditingController _passController = TextEditingController(text: '');
  bool _showPass = false;
  bool _isLoading = false;

  final _loginRepository = LoginRepository();

  @override
  Widget build(BuildContext context) {

    final registerButton = Container(
      padding: EdgeInsets.fromLTRB(32, 0, 32, 0),
      child: InkWell(
        child: Text('Regístrate', textAlign: TextAlign.right, style: StyleApp.getStyleTitle(14)),
        onTap: () => Utility.navTo(context, RegisterScreen()),
      ),
    );

    final recoveryPassButton = Container(
      padding: EdgeInsets.only(top: 16),
      child: InkWell(
        child: Text('¿Olvidó su contraseña?', textAlign: TextAlign.center, style: StyleApp.getStyleTitle(12)),
        onTap: () {
          _recoveryPass();
        },
      ),
    );

/*    final logosFooter = Container(
      padding: EdgeInsets.fromLTRB(40, 20, 40, 10),
      child: Center(
        child: Container(
          child: Image( image: AssetImage(User.getImagePath('logos_footer.png')),),
        ),
      ),
    );*/

    return Container(
      child: _isLoading ?
      Utility.getCircularProgress() :
      ListView(
        children: <Widget>[
          _logo(),
          registerButton,
          _form(),
          _submitButton(),
          recoveryPassButton,
          //logosFooter,
        ],
      ),
    );
  }

  _logo(){
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
      height: 200,
      width: 200,
      child: Center(
        child: Image.asset("${Constants.imagesPath}logo_info_manglar.png"),
      )
    );
  }

  _form(){
    return Container(
      margin: EdgeInsets.fromLTRB(18, 6, 18, 6),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.person),
            title: TextField(
              enabled: true,
              controller: _userController,
              inputFormatters: Utility.validateInput('pin-ecuador'),
              keyboardType: TextInputType.number, // only accept user pin
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: 'Cédula',
              ),
            )
          ),
          Divider(
            height: 2,
            color: Colors.grey[300],
          ),
          ListTile(
              leading: InkWell(
                child: Icon(
                  Icons.remove_red_eye,
                  color: _showPass ? Color(Constants.colorPrimary) : null,
                ),
                onTap: () => _showPassword(),
              ),
              title: TextField(
                enabled: true,
                obscureText: !_showPass,
                controller: _passController,
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: 'Contraseña',
                ),
              )
          ),
        ],
      ),
    );
  }

  _submitButton(){
    return FlatButton(
      padding: const EdgeInsets.all(0.0),
      onPressed: () => _validateUser(),
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        width: 360,
        padding: const EdgeInsets.all(10.0),
        child: Text(
          'ENTRAR',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  _validateUser(){
    String username = _userController.text;
    String password = _passController.text;
    if ( username == '' || password == '' ) {
      Utility.showToast(context, 'Ingrese cédula y contraseña');
      return;
    }
    _setLoading(true);

    Map<String, dynamic> userCreds = {
      'username': username,
      'password': password,
    };
    String data = json.encode(userCreds);

    _loginRepository.access(data).then( (Map<String, dynamic> result) {
      String state = result['state'] ?? 'Error: No hay conexión con el servidor';
      if ( state == 'OK' ) {
        int userId = result['userId'];
        String userName = result['userName'];
        String userPin = result['userPin'];
        String userEmail = result['userEmail'];
        String typeUser = result['typeUser'];
        int organizationManglarId = result['organizationManglarId'];
        User.login(typeUser, userId.toString(), userName, password, userPin, userEmail, organizationManglarId.toString()).then( (_) {
        });
      } else {
        _setLoading(false);
        Utility.showToast(context, state);
      }
    });

  }

  _showPassword(){
    setState(() {
      _showPass = !_showPass;
    });
  }

  _setLoading(bool isLoading){
    setState(() {
      _isLoading = isLoading;
    });
  }

  _recoveryPass(){
    String username = _userController.text;
    if ( username == '' ) {
      Utility.showToast(context, 'Ingrese su cédula para recuperar contraseña');
      return;
    }

    Utility.showConfirm(context, 'Atención', 'Se enviará una contraseña temporal a su correo', (){
      Utility.showLoading(context);
      Map<String, dynamic> userInfo = {
        'userPin': username,
      };
      String data = json.encode(userInfo);
      _loginRepository.recoverPassword(data).then( (result) {
        Utility.dismissLoading(context);
        if (result['state'] == 'OK') {
          Utility.showToast(context, 'Se envió su contraseña a ${result['userEmail']}');
          return;
        }
        Utility.showToast(context, '${result['state']}');
      });
    });

  }

}
