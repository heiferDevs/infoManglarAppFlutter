import 'package:flutter/material.dart';
import './infoManglar/main.dart';
//import './manglarApp/main.dart';
import 'package:flutter/services.dart';
import 'constants.dart';

void main(){
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color(Constants.colorPrimary),
  ));
  runApp(InfoManglarApp());
}
