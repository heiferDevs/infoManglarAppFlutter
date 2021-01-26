import '../../../util/screens/wrapScreen.dart';

import '../widgets/item_view.dart';
import 'package:flutter/material.dart';

import '../model/org.dart';

import '../../../util/style.dart';
import '../../../util/user.dart';
import '../../../constants.dart';

class OrgDocumentList extends StatelessWidget {

  final Org org;

  OrgDocumentList({
    Key key,
    @required this.org,
  });

  @override
  Widget build(BuildContext context) {

    final itemList = Container(
      child: Column(
        children: org.documents.map<Widget>( (Document document) {
          final info = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(document.name, style: TextStyle(color: Color(Constants.colorPrimary), fontSize: 16, fontWeight: FontWeight.bold),),
              Text('Descripción: ${document.desc}', style: TextStyle(color: Color(Constants.colorPrimary),),),
            ],
          );
          final image = document.image == null ? AssetImage(User.getImagePath('doc_icon.png')) : NetworkImage(document.image);
          return ItemView(image: image, actionLabel: 'VER', info: info, onPressed: (){
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
            StyleApp.getTitle('DOCUMENTOS', padding: 16),
            itemList,
          ],
        ),
      )
    );
  }

}
