import '../widgets/wrapWidget.dart';
import 'package:flutter/material.dart';

import '../style.dart';

class WrapScreen extends StatelessWidget {
  final Widget child;
  WrapScreen({
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StyleApp.getAppBar(),
      body: WrapWidget(
        child: child,
      ),
    );
  }

}
