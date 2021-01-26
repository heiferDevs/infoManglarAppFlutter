import 'package:flutter/material.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';

import '../../constants.dart';

class WrapListView extends StatelessWidget {

  final List<Widget> children;
  final ScrollController _rrectController = ScrollController();

  WrapListView({
    @required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: DraggableScrollbar.rrect(
          controller: _rrectController,
          padding: EdgeInsets.only(right: 0),
          alwaysVisibleScrollThumb: false,
          heightScrollThumb: 20,
//          scrollbarTimeToFade: Duration(microseconds: 6400),
          //scrollbarAnimationDuration: Duration(microseconds: 1200),
          backgroundColor: Color(Constants.colorPrimary),
          child: ListView(
            controller: _rrectController,
            children: children,
          ),
        ),
    );
  }

}

