
import 'package:flutter/material.dart';

import '../../../infoManglar/config/screens/config_screen.dart';
import '../model/drawer_config.dart';
import '../model/drawer_option.dart';
import '../../../shared/profile/screens/profile.dart';
import '../../../util/utility.dart';

import '../../../shared/formMenu/widgets/form_menu_widget.dart';
import '../../../util/style.dart';
import '../../../util/user.dart';
import '../../../constants.dart';

// SCREENS
import '../../stats/screens/stats.dart';
import '../../reports/screens/reports.dart';
import '../../pdfReports/screens/pdf_reports.dart';
import '../../pdfReports/screens/pdf_reports_view.dart';
import '../../reports/screens/geoportal.dart';
import '../../showcase/screens/showcase.dart';
import '../../norms.dart';
import '../../../shared/login/screens/login.dart';
import '../../info_app.dart';

class MainDrawer extends StatefulWidget{

  final Function onChangeScreen;
  final DrawerConfig drawerConfig;

  MainDrawer({
    this.onChangeScreen,
    @required this.drawerConfig,
  });

  @override
  _State createState() {
    return _State();
  }
}

class _State extends State<MainDrawer>{

  DrawerOption _selectedOption;
  List<DrawerOption> _listOptions = [];

  void initState() {
    super.initState();
    _selectedOption = widget.drawerConfig.selected;
    _listOptions = widget.drawerConfig.options;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: _drawer(),
    );
  }

  Widget _drawer(){
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xffDCD3B9),
            ),
            child: ListView(
              children: _iconsNav(),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: ListView(
                children: _titlesNav()
            ),
          ),
        ),
      ],
    );
  }

  void setSelectedOption(DrawerOption selected){
    setState( () {
      _selectedOption = selected;
      widget.drawerConfig.selected = selected;
    });
  }


  _iconsNav(){
    if (_selectedOption == null) {
      return _listOptions.map<Widget>( (DrawerOption navOption) {
        return getTile(
          image: navOption.image,
          f: () => _onNav(navOption),
        );
      }).toList();
    }
    return <Widget>[
      getTile(image: _selectedOption.image, f: () =>
          setSelectedOption(null)
      ),
    ];
  }

  _titlesNav(){
    if (_selectedOption == null) {
      return _listOptions.map<Widget>( (DrawerOption navOption) {
        return getTile(
          title: navOption.title,
          f: () => _onNav(navOption),
        );
      }).toList();
    }
    return _selectedOption.subOptions
        .map<Widget>( (DrawerOption navOption) {
      return getTile(
        title: navOption.title,
        f: () => _onNav(navOption),
      );
    }).toList();
  }

  _onNav(DrawerOption navOption){
    switch(navOption.type){
      case 'sub-nav':
        setSelectedOption(navOption);
        break;
      case 'exit':
        User.logout();
        Navigator.of(context).pop();
        Utility.showToast(context, 'Cerró la sesión');
        break;
      case 'screen':
        Navigator.of(context).pop();
        widget.onChangeScreen(_widgetScreen(navOption));
        break;
      case 'form-menu':
        Navigator.of(context).pop();
        widget.onChangeScreen(FormMenuWidget(formMenu: navOption.formMenu,));
        break;
      default:
        throw 'no config drawer for ${navOption.type}';
    }
  }

  _widgetScreen(DrawerOption navOption){
    switch(navOption.id){
      case 'login':
        return Login();
      case 'stats':
        return Stats();
      case 'reports':
        return Reports();
      case 'geoportal':
        return Geoportal();
      case 'showcase':
        return Showcase();
      case 'infoApp':
        return InfoApp();
      case 'profile':
        return Profile();
      case 'pdf_reports':
        return PdfReports();
      case 'pdf_reports_view':
        return PdfReportsView();
      case 'configs':
        return ConfigScreen();
      case 'norm_constitucion_republica':
        return Norms(id: 'norm_constitucion_republica');
      case 'norm_codigo_organico':
        return Norms(id: 'norm_codigo_organico');
      case 'ley_pesca_desarrollo':
        return Norms(id: 'ley_pesca_desarrollo');
      case 'reglamento_coa':
        return Norms(id: 'reglamento_coa');
      case 'legislacion_mae':
        return Norms(id: 'legislacion_mae');
      case 'auscm':
        return Norms(id: 'auscm');
    }
  }

  Widget getTile({String title, String image, double sizeFont = 13, Function f, bool isBold = true}){
    Text t;
    CircleAvatar c;
    if ( title != null ) {
      t = Text(
        title,
        style: isBold ? StyleApp.getStyleTitle(sizeFont) : StyleApp.getStyleSubTitle(sizeFont-1),
      );
    }
    if ( image != null ) {
      String imageAsset = "${Constants.imagesPath}$image";
      c = CircleAvatar(
        backgroundColor: Colors.white,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Image.asset(imageAsset),
        ),
      );
    }
    return ListTile(
      title: t,
      leading: c,
      onTap: f,
    );
  }

}
