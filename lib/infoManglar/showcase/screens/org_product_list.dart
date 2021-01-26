import '../../../util/screens/wrapScreen.dart';

import '../widgets/item_view.dart';
import 'package:flutter/material.dart';

import '../model/org.dart';

import '../../../plugins/url_launcher.dart';
import '../../../util/style.dart';
import '../../../constants.dart';
import '../../../util/user.dart';

class OrgProductList extends StatelessWidget {

  final Org org;

  OrgProductList({
    Key key,
    @required this.org,
  });

  @override
  Widget build(BuildContext context) {

    // Remove image cache in case of image was updated
    PaintingBinding.instance.imageCache.clear();

    final itemList = Container(
      child: Column(
        children: org.products.map<Widget>( (Product product) {
          final info = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(product.name, style: TextStyle(color: Color(Constants.colorPrimary), fontSize: 16, fontWeight: FontWeight.bold),),
              Text('Calidad: ${product.quality}', style: TextStyle(color: Color(Constants.colorPrimary),),),
              //Text('Stock: ${product.stock}', style: TextStyle(color: Color(Constants.colorPrimary),),),
              Text('Precio(USD): ${product.price}', style: TextStyle(color: Color(Constants.colorPrimary),),),
            ],
          );
          final image = product.image == null ? AssetImage(User.getImagePath('vitrina_icon.png')) : NetworkImage(product.image);
          return ItemView(image: image, actionLabel: 'COMPRAR', info: info, onPressed: (){
            String userNameMsg = User.userName == null ? '' : ' mi nombre es ${User.userName},';
            UrlLauncher.launchWS(org.contactSellerMobile, 'Hola$userNameMsg me gustaria comprar ${product.name} me puede dar información', context);
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
            StyleApp.getTitle('PRODUCTOS', padding: 16),
            itemList,
          ],
        ),
      )
    );
  }

}
