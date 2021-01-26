import 'package:flutter/material.dart';

import '../../../util/utility.dart';
import '../../../util/user.dart';
import '../../../util/style.dart';
import 'change_password.dart';

class Profile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final userInfo = Container(
      padding: EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Nombre: ${User.userName}', textAlign: TextAlign.left, style: StyleApp.getStyleSubTitle(15)),
          Text('Cédula: ${User.userPin}', textAlign: TextAlign.left, style: StyleApp.getStyleSubTitle(15)),
          Text('Correo: ${User.userEmail}', textAlign: TextAlign.left, style: StyleApp.getStyleSubTitle(15)),
        ],
      ),
    );

    final changePassword = ChangePassword();

    return Container(
        padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
        child: ListView(
          children: <Widget>[
            StyleApp.getTitle('PERFIL'),
            userInfo,
            _option(context, 'Cambiar contraseña', 'changePassword', changePassword),
          ],
        )
    );
  }

  _option(BuildContext context, String title, String image, Widget w){
    return InkWell(
      onTap: (){
        Utility.navTo(context, w);
      },
      child: ListTile(
        leading: _getIcon(image),
        dense: true,
        title: Text(title, textAlign: TextAlign.left, style: StyleApp.getStyleSubTitle(16)),
      ),
    );
  }

  _getIcon(String image){
    switch (image) {
      case 'changePassword':
        return Icon(Icons.security);
    }
  }

}