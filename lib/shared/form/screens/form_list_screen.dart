
import 'package:flutter/material.dart';

import '../../../infoManglar/infoForm/controller/info_form_on_get_all_controller.dart';
import '../../../infoManglar/infoForm/controller/info_form_on_init_controller.dart';
import '../../../infoManglar/infoForm/repository/info_form_repository.dart';

import '../../../infoManglar/reports/model/report.dart';
import '../../../infoManglar/reports/widgets/item_report.dart';
import '../../../util/screens/wrapScreen.dart';
import '../../../util/widgets/wrapListView.dart';

import '../../form/model/form_config.dart';
import '../../../util/style.dart';
import '../../../util/utility.dart';
import '../../../util/user.dart';
import 'form_screen.dart';

class FormListScreen extends StatefulWidget {

  final FormConfig formConfig;

  FormListScreen({
    @required this.formConfig,
  });

  @override
  _State createState() => _State();
}

class _State extends State<FormListScreen> {

  final InfoFormRepository infoFormRepository = InfoFormRepository();
  final InfoFormOnGetAllController infoFormOnGetAllController = InfoFormOnGetAllController();
  final InfoFormOnInitController infoFormOnInitController = InfoFormOnInitController();

  @override
  Widget build(BuildContext context) {

    final headerTitle = Container(
      padding: EdgeInsets.fromLTRB(10, 30, 10, 30),
      child: Center(
        child: Text(
          widget.formConfig.title,
          style: StyleApp.getStyleTitle(22),
        ),
      ),
    );

//    final submitButton = StyleApp.getButton('CONSULTAR', () => setLoaded(true), margin: 12);

    final reports = FutureBuilder(
      future:infoFormOnGetAllController.onGetAllForm(widget.formConfig, context),
      builder: (context, snapshot){
        if (snapshot.hasData) {
          return _reports(snapshot.data);
        } else if (snapshot.hasError) {
          String msg = User.hasInternetConnection ?  snapshot.error : 'No se obtuvo la lista por falta de conexión a internet';
          return Container( margin: EdgeInsets.only(top: 30),child: Center(child: Text(msg, style: StyleApp.getStyleSubTitle(13),)));
        }
        return Utility.getCircularProgress();
      },
    );

    final createNewButton = StyleApp.getButton('CREAR NUEVO', () async {
      infoFormOnInitController.onInitForm(User.role, widget.formConfig.idReport, null, context).then( (FormConfig formConfig) {
        Utility.navTo(context, FormScreen(formConfig: formConfig));
      });
    });

    return WrapScreen(
      child: Container(
        child: WrapListView(
          children: <Widget>[
            headerTitle,
            createNewButton,
            reports,
          ],
        ),
      )
    );
  }

  Widget _reports(List<Report> reports){

    List<Widget> items = [
      SizedBox(height: 26,),
      StyleApp.getTitle('ANTERIORES: ${reports.length}', padding: 8),
    ];

    List<Widget> _reportsItems = reports.map<Widget>( (Report report) {
      bool canEdit = User.canEditForms(report);
      String textSubmit = canEdit ? 'VER/EDITAR' : 'VER';
      return ItemReport(report: report, textSubmit: textSubmit, onPressed: () {
        infoFormOnInitController.onInitFormFromReport(report, context).then((FormConfig formConfig) {
          formConfig.enableSubmit = canEdit;
          Utility.navTo(context, FormScreen(formConfig: formConfig));
        });
      },);
    }).toList();

    items.addAll(_reportsItems);

    return Container(
      child: Column(
        children: items,
      ),
    );
  }

}
