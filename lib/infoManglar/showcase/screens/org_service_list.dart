import '../../../util/screens/wrapScreen.dart';

import '../widgets/item_view.dart';
import 'package:flutter/material.dart';

import '../model/org.dart';

import '../../../plugins/url_launcher.dart';

import '../../../util/style.dart';
import '../../../constants.dart';
import '../../../util/user.dart';

class OrgServiceList extends StatelessWidget {

  final Org org;

  OrgServiceList({
    Key key,
    @required this.org,
  });

  @override
  Widget build(BuildContext context) {

    // Remove image cache in case of image was updated
    PaintingBinding.instance.imageCache.clear();

    final itemList = Container(
      child: Column(
        children: org.services.map<Widget>( (Service service) {
          final info = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(service.name, style: TextStyle(color: Color(Constants.colorPrimary), fontSize: 16, fontWeight: FontWeight.bold),),
              Text('${service.desc}', style: TextStyle(color: Color(Constants.colorPrimary),),),
              //Text('Precio(USD): ${service.price}', style: TextStyle(color: Color(Constants.colorPrimary),),),
            ],
          );
          final image = service.image == null ? AssetImage(User.getImagePath('service_icon.png')) : NetworkImage(service.image);
          return ItemView(image: image, actionLabel: 'CONTACTAR', info: info, onPressed: () {
            String userNameMsg = User.userName == null ? '' : ' mi nombre es ${User.userName},';
            UrlLauncher.launchWS(org.contactSellerMobile, 'Hola$userNameMsg me gustaria solicitar el servicio de ${service.name} me puede dar información', context);
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
            StyleApp.getTitle('SERVICIOS', padding: 16),
            itemList,
          ],
        ),
      )
    );
  }

}
