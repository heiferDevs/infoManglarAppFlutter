import '../../../util/screens/wrapScreen.dart';
import 'package:flutter/material.dart';

import 'org_Important_point_list.dart';
import 'org_document_list.dart';
import 'org_product_list.dart';
import 'org_project_list.dart';
import 'org_service_list.dart';

import '../model/org.dart';
import '../widgets/category_button.dart';

import '../../../util/style.dart';
import '../../../util/user.dart';
import '../../../util/utility.dart';
import '../../../constants.dart';
import '../../../util/widgets/read_more_text.dart';

class OrgSummary extends StatelessWidget {

  final Org org;

  OrgSummary({
    Key key,
    @required this.org,
  });

  @override
  Widget build(BuildContext context) {

    final imageProvider = org.image == null ? AssetImage(User.getImagePath('photo.png')): NetworkImage(org.image);

    final logo = Container(
      padding: EdgeInsets.fromLTRB(10, 30, 10, 5),
      height: 120,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.contain,
        ),
      ),
    );

//    final title = Container(
//      child: Center(
//        child: Text(org.name, style: StyleApp.getStyleTitle(18),),
//      ),
//    );

    final orgSummary = Container(
      padding: EdgeInsets.fromLTRB(18, 6, 18, 6),
      child: Constants.isWeb ?
        Text(org.summary, style: StyleApp.getStyleSubTitle(13),) :
        ReadMoreText(
          org.summary,
          trimLines: 6,
          colorClickableText: Color(Constants.colorPrimary),
          trimMode: TrimMode.Line,
          trimCollapsedText: ' ...mostrar más',
          trimExpandedText: ' ...mostrar menos',
          textAlign: TextAlign.justify,
        ),
    );

    final productsServices = _productsServices(context, org);

    return WrapScreen(
      child: ListView(
        children: <Widget>[
          logo,
          //title,
          orgSummary,
          productsServices,
        ],
      )
    );
  }

  Widget _productsServices(BuildContext context, Org org){

    List<Widget> productServices = [];

    if (org.hasImportantPoints()){
      productServices.add(
          CategoryButton(title: 'DATOS IMPORTANTES', image: _imageCategory('important_points'), onPressed: (){
            Utility.navTo(context, OrgImportantPointList(org: org));
          })
      );
    }

    if (org.hasProducts()){
      productServices.add(
        CategoryButton(title: 'PRODUCTOS', image: _imageCategory('products'), onPressed: (){
          Utility.navTo(context, OrgProductList(org: org));
        })
      );
    }

    if (org.hasServices()){
      productServices.add(
        CategoryButton(title: 'SERVICIOS', image: _imageCategory('services'), onPressed: (){
          Utility.navTo(context, OrgServiceList(org: org));
        })
      );
    }

    if (org.hasProjects()){
      productServices.add(
        CategoryButton(title: 'PROYECTOS', image: _imageCategory('projects'), onPressed: (){
          Utility.navTo(context, OrgProjectList(org: org));
        })
      );
    }

    if (org.hasDocuments()){
      productServices.add(
        CategoryButton(title: 'DOCUMENTOS', image: _imageCategory('documents'), onPressed: (){
          Utility.navTo(context, OrgDocumentList(org: org));
        })
      );
    }

    return Container(
      child: Column(
        children: productServices,
      ),
    );
  }

  String _imageCategory(String type){
    switch (type) {
      case 'important_points':
        return User.getImagePath('formularios_icon.png');
      case 'products':
        return User.getImagePath('vitrina_icon.png');
      case 'services':
        return User.getImagePath('service_icon.png');
      case 'projects':
        return User.getImagePath('projects_icon.png');
      case 'documents':
        return User.getImagePath('note.png');
      default:
        return User.getImagePath('vitrina_icon.png');
    }
  }

}
