import 'package:flutter/material.dart';

class WrapWidget extends StatelessWidget {
  final Widget child;
  WrapWidget({
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 640),
          child: child,
        )
    );
  }

}
