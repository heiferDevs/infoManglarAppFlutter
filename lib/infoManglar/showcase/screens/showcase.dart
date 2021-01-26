import '../../../util/utility.dart';
import 'package:flutter/material.dart';

import '../model/org.dart';
import '../repository/showcase_repository.dart';
import '../widgets/org_view.dart';

import '../../../util/style.dart';

class Showcase extends StatefulWidget{
  @override
  _State createState() {
    return _State();
  }
}

class _State extends State<Showcase> {

  final _showcaseRepository = ShowcaseRepository();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _showcaseRepository.orgs(),
      builder: (context, snapshot){
        if (snapshot.hasData) {
          return showcase(snapshot.data);
        } else if (snapshot.hasError) {
          return Utility.getErrorMessage();
        }
        return Utility.getCircularProgress();
      },
    );
  }

  Widget showcase(List<Org> orgs){

    final headerTitle = Container(
      padding: EdgeInsets.fromLTRB(10, 30, 10, 30),
      child: Center(
        child: Text(
          'VITRINA ORGANIZACIONES',
          style: StyleApp.getStyleTitle(22),
        ),
      ),
    );

    final orgsList = orgs.length == 0 ?
      Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Text(
            'Ninguna organización ha ingresado información de productos o servicios',
            style: StyleApp.getStyleSubTitle(14),
            textAlign: TextAlign.center,
          ),
        ),
      ) :
      Container(
        child: Column(
          children: orgs.map<Widget>( (Org org) {
            return OrgView(org: org);
          }).toList(),
        ),
      );

    return Container(
      child: ListView(
        children: <Widget>[
          headerTitle,
          orgsList,
        ],
      ),
    );
  }

}
