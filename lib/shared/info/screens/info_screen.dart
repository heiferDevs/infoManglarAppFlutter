import '../../../util/screens/wrapScreen.dart';
import 'package:flutter/material.dart';
import '../widgets/info.dart';

class InfoScreen extends StatelessWidget {

  final String title;
  final Widget info;

  InfoScreen({this.title, this.info});

  @override
  Widget build(BuildContext context) {
    return WrapScreen(
      child: Info(title: title, info: info,)
    );
  }

}
