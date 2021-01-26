import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';
import '../../../util/user.dart';
import '../model/report.dart';

class ItemReport extends StatelessWidget{

  final Report report;
  final String textSubmit;
  final VoidCallback onPressed;
  final _formatDate = new DateFormat('yyyy-MM-dd HH:mm');

  ItemReport({
    Key key,
    @required this.onPressed,
    @required this.report,
    this.textSubmit = 'VER',
  });

  @override
  Widget build(BuildContext context) {

    final imageToUser = report.image == null ? AssetImage(User.getImagePath('photo.png')) : AssetImage(report.image);
    final imageView = Container(
      width: 96,
      height: 80,
      padding: EdgeInsets.all(18),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6.0),
        child: FadeInImage(
          placeholder: AssetImage(User.getImagePath('loading.gif')),
          image: imageToUser,
        ),
      ),
    );


    final double cWidth = MediaQuery.of(context).size.width * 0.55;

    String formatDate = _formatDate.format(
        DateTime.fromMillisecondsSinceEpoch(report.createdAt ?? 0));

    final infoView = Container(
      width: cWidth,
      padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('${report.title}', style: TextStyle(color: Color(Constants.colorPrimary), fontSize: 14.5, fontWeight: FontWeight.bold),),
          report.subTitle == null || report.subTitle == '' ? null : Text(report.subTitle, style: TextStyle(color: Color(Constants.colorPrimary), fontWeight: FontWeight.bold,), maxLines: 2),
          report.extraInfo == null || report.extraInfo == '' ? null : Text(report.extraInfo, style: TextStyle(color: Color(Constants.colorPrimary),), maxLines: 2,),
          Text('Fecha: $formatDate', style: TextStyle(color: Color(Constants.colorPrimary),),),
          Text('Creado por: ${report.userName}', style: TextStyle(color: Color(Constants.colorPrimary),),),
          Text('Creado tipo: ${report.userType}', style: TextStyle(color: Color(Constants.colorPrimary),),),
        ].where((w) => w != null ).toList(),
      ),
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
        child: Text(textSubmit, style: TextStyle(
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
