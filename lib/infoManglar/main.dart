import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:async';

import 'home.dart';

import '../util/user.dart';
import '../constants.dart';
import '../util/utility.dart';
import '../plugins/internet_connection.dart';
import 'infoForm/controller/info_form_save_controller.dart';

class InfoManglarApp extends StatefulWidget{
  @override
  _State createState() {
    return _State();
  }
}

class _State extends State<InfoManglarApp> {

  bool _loaded = false;
  StreamSubscription subscription;
  final _infoFormSaveController = InfoFormSaveController();

  @override
  void initState() {
    super.initState();
    print('init');
    if (Constants.isWeb) {
      User.setHastInternetConnection(context, true);
    } else {
      subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
        bool isConnected = result == ConnectivityResult.mobile || result == ConnectivityResult.wifi;
        if ( isConnected ) _saveLocalStorageForms();
        if ( !isConnected ) User.setHastInternetConnection(context, false);
      });
    }
    User.setInfoFromLocalStorage().then((_) {
      setState(() {
        _loaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _loaded
        ? _materialApp()
        : Utility.getCircularProgress();
  }

  _saveLocalStorageForms() async {
    bool hasInternet = await InternetConection.checkInternet();
    User.setHastInternetConnection(context, hasInternet);
    if ( hasInternet && User.hasOfflineMode()) {
      await _infoFormSaveController.saveFromLocalStorage(context);
    }
  }


  _materialApp() {
    return MaterialApp(
      title: 'Info Manglar',
      theme: ThemeData(
        primaryColor: Color(Constants.colorPrimary),
        primaryColorLight: Color(Constants.colorSecondary),
        // Define the default font family.
        fontFamily: 'Bookman',
        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('es'), // Spanish
      ],
      home: Home(),
    );
  }

}
