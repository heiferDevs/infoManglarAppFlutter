import '../../../util/screens/wrapScreen.dart';

import '../widgets/item_view.dart';
import 'package:flutter/material.dart';

import '../model/org.dart';

import '../../../plugins/url_launcher.dart';

import '../../../util/style.dart';
import '../../../constants.dart';
import '../../../util/user.dart';

class OrgProjectList extends StatelessWidget {

  final Org org;

  OrgProjectList({
    Key key,
    @required this.org,
  });

  @override
  Widget build(BuildContext context) {

    // Remove image cache in case of image was updated
    PaintingBinding.instance.imageCache.clear();

    final itemList = Container(
      child: Column(
        children: org.projects.map<Widget>( (Project project) {
          final info = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(project.name, style: TextStyle(color: Color(Constants.colorPrimary), fontSize: 16, fontWeight: FontWeight.bold),),
              Text('Descripción: ${project.desc}', style: TextStyle(color: Color(Constants.colorPrimary),),)
            ],
          );

          final image = project.image == null ? AssetImage(User.getImagePath('projects_icon.png')) : NetworkImage(project.image);
          return ItemView(image: image, actionLabel: 'CONTACTAR', info: info, onPressed: () {
            String userNameMsg = User.userName == null ? '' : ' mi nombre es ${User.userName},';
            UrlLauncher.launchWS(org.contactSellerMobile, 'Hola$userNameMsg me gustaria conocer más de este proyecto ...', context);
          },);
        }).toList(),
      ),
    );

    return WrapScreen(
      child: Container(
        child: ListView(
          children: <Widget>[
            StyleApp.getLogoImageNetwork(org.image),
            // StyleApp.getTitle(org.name, padding: 0),
            StyleApp.getTitle('PROYECTOS', padding: 16),
            itemList,
          ],
        ),
      )
    );
  }

}
