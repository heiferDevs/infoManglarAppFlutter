import 'package:flutter/material.dart';
import '../../../util/style.dart';

class Info extends StatelessWidget {

  final String title;
  final Widget info;

  Info({this.title, this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: ListView(
        children: <Widget>[
          StyleApp.getTitle(title),
          Container(
              child: info
          ),
        ],
      ),
    );
  }

}
