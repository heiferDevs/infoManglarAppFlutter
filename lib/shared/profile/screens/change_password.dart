import '../../../util/screens/wrapScreen.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import '../repository/profile_repository.dart';

import '../../form/model/data.dart';
import '../../form/model/option.dart';
import '../../form/widgets/input.dart';

import '../../../util/style.dart';
import '../../../util/utility.dart';
import '../../../util/user.dart';

class ChangePassword extends StatelessWidget {

  final _profileRepository = ProfileRepository();

  final Option configCurrentPass = Option(label: 'Contraseña actual', type: 'input', typeInput: 'password');
  final Option configNewPass = Option(label: 'Nueva contraseña', type: 'input', typeInput: 'password');
  final Option configConfirmNewPass = Option(label: 'Confirmación', type: 'input', typeInput: 'password');

  @override
  Widget build(BuildContext context) {

    final currentPassInput = Input(config: configCurrentPass);

    final newPassInput = Input(config: configNewPass);

    final confirmNewPassInput = Input(config: configConfirmNewPass);

    final submitButton = StyleApp.getButton('CAMBIAR', (){
      _changePassword(context);
    });

    return WrapScreen(
      child: Container(
          padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
          child: ListView(
            children: <Widget>[
              currentPassInput,
              newPassInput,
              confirmNewPassInput,
              submitButton,
            ],
          )
      )
    );

  }

  _changePassword(context){
    if ( !configCurrentPass.hasValue() || !configNewPass.hasValue() || !configConfirmNewPass.hasValue() ) {
      Utility.showToast(context, 'Debe llenar todos los campos');
      return;
    }
    String currentPassword = configCurrentPass.getValue();
    String newPassword = configNewPass.getValue();
    String confirmPassword = configConfirmNewPass.getValue();

    if ( newPassword != confirmPassword ) {
      Utility.showToast(context, 'La nueva contraseña no coincide con la confirmación');
      return;
    }

    Utility.showLoading(context);
    Map<String, dynamic> passInfo = {
      'userPin': User.userPin,
      'password': currentPassword,
      'newPassword': newPassword,
      'newPasswordConfirm': confirmPassword,
    };
    String data = json.encode(passInfo);
    _profileRepository.changePassword(data).then( (Data result) {
      Utility.dismissLoading(context);
      if (result.state == 'OK') {
        Utility.showToast(context, 'Se cambió con exito, debe iniciar con su nueva clave');
        Navigator.pop(context);
        User.logout();
        return;
      }
      Utility.showToast(context, '${result.state}');
    });
  }

}
