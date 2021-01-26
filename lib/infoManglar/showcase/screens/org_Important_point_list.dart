import '../../../util/screens/wrapScreen.dart';
import 'package:flutter/material.dart';

import '../model/org.dart';

import '../../../util/style.dart';

class OrgImportantPointList extends StatelessWidget {

  final Org org;

  OrgImportantPointList({
    Key key,
    @required this.org,
  });

  @override
  Widget build(BuildContext context) {

    final itemList = Container(
      padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: org.importantPoints.map<Widget>( (String item) {
          return Text(' -  $item', textAlign: TextAlign.justify, style: TextStyle(fontSize: 14, height: 1.4),);
        }).toList(),
      ),
    );

    return WrapScreen(
      child: Container(
        child: ListView(
          children: <Widget>[
            StyleApp.getLogoImageNetwork(org.image),
            // StyleApp.getTitle(org.name, padding: 0),
            StyleApp.getTitle('DATOS IMPORTANTES', padding: 12),
            itemList,
          ],
        ),
      )
    );
  }

}
