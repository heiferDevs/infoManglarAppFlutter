import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../util/user.dart';

class ItemView extends StatelessWidget{

  final ImageProvider image;
  final Widget info;
  final String actionLabel;
  final VoidCallback onPressed;

  ItemView({
    Key key,
    @required this.image,
    @required this.info,
    @required this.onPressed,
    @required this.actionLabel,
  });

  @override
  Widget build(BuildContext context) {

    final imageView = Container(
      width: 140,
      height: 120,
      padding: EdgeInsets.all(12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: FadeInImage(
          placeholder: AssetImage(User.getImagePath('loading.gif')),
          image: image,
        ),
      ),
    );


    final double cWidth = MediaQuery.of(context).size.width * 0.55;

    final infoView = Container(
      width: cWidth,
      padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
      child: info,
    );

    final productInfo = Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(Constants.colorPrimary)),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: <Widget>[
          imageView,
          infoView,
        ],
      ),
    );

    final name = Container(
      color: Color(Constants.colorPrimary),
      height: 30,
      child: Center(
        child: Text(actionLabel, style: TextStyle(
          color: Colors.white,
        ),),
      ),
    );

    return InkWell(
      child: Container(
        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Column(
          children: <Widget>[
            productInfo,
            name,
          ],
        ),
      ),
      onTap: (){
        onPressed();
      },
    );

  }

}
