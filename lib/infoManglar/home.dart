import 'package:flutter/material.dart';

import 'config/model/config_form.dart';
import 'config/repository/config_repository.dart';
import 'drawer/model/drawer_config.dart';
import 'drawer/repository/drawer_repository.dart';
import 'drawer/widgets/drawer_widget.dart';

import '../constants.dart';
import '../util/style.dart';
import '../util/user.dart';
import '../util/utility.dart';
import '../util/widgets/wrapWidget.dart';

class Home extends StatefulWidget{
  @override
  _State createState() {
    return _State();
  }
}

class _State extends State<Home>{

  Widget _body;
  DrawerConfig _drawerConfig;
  final _drawerRepository = DrawerRepository();
  final _configRepository = ConfigRepository();
  final GlobalKey<ScaffoldState> _homeKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    User.setOnUserChange(_loadUserData);
    _loadUserData();
  }

  _loadUserData() {
    _body = Container(
        width: Constants.isWeb ? 300 : 250,
        padding: EdgeInsets.only(top: Constants.isWeb ? 160 : 80),
        child: Center(
          child: ListView(
            children: <Widget>[
              Image.asset("${Constants.imagesPath}logo_info_manglar.png"),
              Text('versión: ${Constants.version}', style: StyleApp.getStyleSubTitle(11), textAlign: TextAlign.center,),
              StyleApp.getButton('Menú', () {
                _homeKey.currentState.openDrawer();
              }, margin: 20),
            ],
          ),
        )
    );
    bool isLogged = User.role != 'public';
    _drawerRepository.getDrawerConfig().then( (DrawerConfig drawerConfig) {
      setState(() {
        _drawerConfig = drawerConfig;
      });
      if (isLogged) {
        Utility.showToast(context, 'Bienvenido usuario ${User.role}');
        _validateVersion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _homeKey,
      appBar: StyleApp.getAppBar(),
      drawer: _drawerConfig == null ? null :
        MainDrawer(drawerConfig: _drawerConfig, onChangeScreen: _setWidget),
      body: WrapWidget(
        child: _body,
      ),
    );
  }

  _setWidget(Widget w){
    setState(() {
      _body = w;
    });
  }

  _validateVersion(){
   _configRepository.getConfigForm().then( (ConfigForm config){
     String currentVersion = Constants.version;
     String systemVersion = config.version;
     if (currentVersion != systemVersion) {
       String msg = "InfoManglar tiene una nueva versión v$systemVersion, por favor contacte al administrador para obtener la actualización";
       Utility.showConfirmNoCancel(context, 'Atención', msg, () => {});
     }
   });

  }

}
