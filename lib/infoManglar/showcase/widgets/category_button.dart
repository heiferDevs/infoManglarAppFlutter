import 'package:flutter/material.dart';

import '../../../constants.dart';

class CategoryButton extends StatelessWidget {

  final String title;
  final String image;
  final VoidCallback onPressed;

  CategoryButton({
    Key key,
    @required this.title,
    @required this.image,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {

    final label = Container(
      height: 34,
      padding: EdgeInsets.only(left: 54, bottom: 2),
      decoration: BoxDecoration(
        color: Color(Constants.colorPrimary),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),),
      ),
    );

    final icon = Container(
      height: 68,
      width: 68,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
            color: Color(Constants.colorPrimary)
        ),
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
      child: Container(
        padding: EdgeInsets.all(16),
        child: Image(image: AssetImage(image),),
      ),
    );

    return InkWell(
      child: Container(
        padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            label,
            icon,
          ],
        ),
      ),
      onTap: (){
        onPressed();
      },
    );
  }

}
