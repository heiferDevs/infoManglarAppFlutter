import 'package:flutter/material.dart';

import '../plugins/url_launcher.dart';
import '../util/user.dart';
import '../constants.dart';

class StyleApp{

  static getAppBar(){
   if (Constants.simpleHeader) return getAppBarSimple();
   return getAppBarWithMaeAndEcu();
  }

  static getAppBarSimple(){

    if (Constants.isWeb) {
      return AppBar(
        title: Text('InfoManglar'),
      );
    }
    final String logo = User.getImagePath('logo.png');
    final String background = User.getImagePath('background_toolbar.png');

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      titleSpacing: 0.0,
      iconTheme: IconThemeData(color: Color(Constants.colorPrimary)),
      title: Container(
          margin: EdgeInsets.all(0.0),
          padding: EdgeInsets.all(0.0),
          height: 300,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(background),
                //fit: BoxFit.fill,
              )
          ),
          child: Center(
            child: Container(
              height: 60,
              margin: EdgeInsets.only(right: 50),
              child: Image.asset(logo),
            ),
          )
      ),
      centerTitle: true,
    );
  }

  static getAppBarWithMaeAndEcu(){

    final String logo = User.getImagePath('logo.png');
    //final String mae = User.getImagePath('logo_mae.png');
    final String ecu911 = User.getImagePath('ecu911.png');
    final String background = User.getImagePath('background_toolbar.png');

    final maeButton = FlatButton(
        onPressed: (){
          //UrlLauncher.launchURL('http://www.ambiente.gob.ec/');
        },
        child: Container(
          width: 110,
          padding: EdgeInsets.all(5),
          //child: Image.asset(mae),
        )
    );

    final ecu911Button = FlatButton(
        onPressed: (){
          UrlLauncher.callNumber('+593999123757');
        },
        child: Container(
          width: 110,
          padding: EdgeInsets.all(5),
          child: Image.asset(ecu911),
        )
    );

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      titleSpacing: 0.0,
      iconTheme: IconThemeData(color: Color(Constants.colorPrimary)),
      title: Container(
          margin: EdgeInsets.all(0.0),
          padding: EdgeInsets.all(0.0),
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(background),
                fit: BoxFit.cover,
              )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              maeButton,
              Image.asset(logo),
              ecu911Button,
            ],
          )
      ),
      centerTitle: true,
    );
  }

  static getStyleTitle(double fontSize){
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
      color: Color(Constants.colorPrimary)
    );
  }

  static getStyleSubTitle(double fontSize){
    return TextStyle(
      fontSize: fontSize,
      color: Color(Constants.colorSecondary),
    );
  }

  static getBoxDecoration(){
    return BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Color(Constants.colorPrimary)),
      borderRadius: BorderRadius.all(Radius.circular(20)),
    );
  }

  static getTitle(String title, {double padding = 20}){
    return Container(
      padding: EdgeInsets.all(padding),
      child: Text(title, textAlign: TextAlign.center, style: getStyleTitle(18)),
    );
  }

  static getLogoImageNetwork(String image){
    final imageToUser = image == null ? AssetImage(User.getImagePath('photo.png')) : NetworkImage(image);

    return Container(
      padding: EdgeInsets.fromLTRB(10, 30, 10, 5),
      height: 120,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imageToUser,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  static Widget getButton(String title, Function onPressed, { double margin = 6 }){
    return FlatButton(
      padding: const EdgeInsets.all(0.0),
      onPressed: () => onPressed(),
      child: Container(
        margin: EdgeInsets.all(margin),
        decoration: BoxDecoration(
          color: Color(Constants.colorPrimary),
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        width: 360,
        padding: const EdgeInsets.all(10.0),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

}