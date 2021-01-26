
import '../../../infoManglar/infoForm/controller/info_form_on_init_controller.dart';

import '../../../shared/form/screens/form_list_screen.dart';
import 'package:flutter/material.dart';

import '../model/form_menu.dart';

import '../../form/model/form_config.dart';
import '../../form/screens/form_screen.dart';

import '../../../util/style.dart';
import '../../../util/utility.dart';
import '../../../util/user.dart';

class FormMenuWidget extends StatelessWidget{

  final FormMenu formMenu;
  final InfoFormOnInitController infoFormOnInitController = InfoFormOnInitController();

  FormMenuWidget({
    Key key,
    @required this.formMenu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headerTitle = Container(
      padding: EdgeInsets.fromLTRB(10, 30, 10, 30),
      child: Column(
        children: <Widget>[
          Text(
            getTitle(),
            textAlign: TextAlign.center,
            style: StyleApp.getStyleTitle(22),
          ),
          SizedBox(height: 8.0),
          Text(
            getSubTitle(),
            textAlign: TextAlign.center,
            style: StyleApp.getStyleSubTitle(14),
          ),
        ],
      ),
    );

    final items = Container(
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 3,
        padding: EdgeInsets.all(4),
        children: formMenu.forms.map<Widget>( (FormConfig formConfig) {
          return getItem(context, formConfig);
        }).toList(),
      ),
    );

    return ListView(
      padding: EdgeInsets.all(8.0),
      children: <Widget>[
        headerTitle,
        items,
      ],
    );
  }

  getTitle(){
    return formMenu.title ?? 'no_title';
  }

  getSubTitle(){
    return formMenu.subTitle ?? '';
  }

  Widget getItem(BuildContext context, FormConfig formConfig){
    String imageAsset = User.getImageFormsIcon(formConfig.image);
    String titleToUse = formConfig.title ?? 'no_title';
    return Container(
      child: FlatButton(
        onPressed: () {
          infoFormOnInitController.onInitForm(User.role, formConfig.idReport, null, context).then( (FormConfig f) {
            if (f.error != null ) {
              Utility.showConfirmNoCancel(context, 'Atención', f.error, () => {});
            } else if (f.showListBeforeForm) {
              Utility.navTo(context, FormListScreen(formConfig: f));
            } else {
              Utility.navTo(context, FormScreen(formConfig: f));
            }
          });
        },
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              width: 120,
              height: 60,
              child: Image.asset(imageAsset),
            ),
            Text(
              titleToUse,
              textAlign: TextAlign.center,
              style: StyleApp.getStyleSubTitle(13),
            ),
          ],
        )),
    );
  }

}
