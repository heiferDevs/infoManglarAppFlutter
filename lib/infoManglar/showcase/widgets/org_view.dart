import '../model/org.dart';
import '../screens/org_summary.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../util/utility.dart';
import '../../../util/user.dart';

class OrgView extends StatelessWidget{

  final Org org;

  OrgView({
    Key key,
    @required this.org,
  });

  @override
  Widget build(BuildContext context) {

    final imageProvider = org.image == null ? AssetImage(User.getImagePath('photo.png')): NetworkImage(org.image);

    final image = Container(
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(Constants.colorPrimary)),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
        ),
      ),
      child: Center(
        child: FadeInImage(
          placeholder: AssetImage(User.getImagePath('loading.gif')),
          image: imageProvider,
        )
      ),
    );

    final name = Container(
      color: Color(Constants.colorPrimary),
      height: 30,
      child: Center(
        child: Text(org.name.toUpperCase(),style: TextStyle(
          color: Colors.white,
        ),),
      ),
    );

    return InkWell(
      child: Container(
        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Column(
          children: <Widget>[
            image,
            name,
          ],
        ),
      ),
      onTap: (){
        Utility.navTo(context, OrgSummary(org: org,));
      },
    );

  }

}
