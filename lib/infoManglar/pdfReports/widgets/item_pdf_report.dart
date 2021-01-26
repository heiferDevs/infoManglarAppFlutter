
import '../../infoForm/model/forms/pdf_report_form.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../util/user.dart';

class ItemPdfReport extends StatelessWidget{

  final PdfReportForm report;
  final List<SubmitButton> buttons;
  final VoidCallback onPressedInfo;

  ItemPdfReport({
    Key key,
    @required this.report,
    @required this.onPressedInfo,
    this.buttons,
  });

  @override
  Widget build(BuildContext context) {

    bool showSubmit = buttons.length > 0;

    final imageToUser = AssetImage(User.getImagePath('doc_icon.png'));
    final imageView = Container(
      width: 96,
      height: 80,
      padding: EdgeInsets.all(18),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6.0),
        child: FadeInImage(
          placeholder: AssetImage(User.getImagePath('loading.gif')),
          image: imageToUser,
        ),
      ),
    );


    final double cWidth = MediaQuery.of(context).size.width * 0.55;

    final String state = report.isApproved ? 'APROBADO' :
      (report.isWithObservations ? 'CON OBSERVACIONES' :
      (report.isPublished ? 'PUBLICADO' : null));

    final infoView = Container(
      width: cWidth,
      padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          state == null ? null : Text(state, style: TextStyle(color: Color(Constants.colorPrimary), fontSize: 16, fontWeight: FontWeight.bold),),
          report.publishedDate == null || !report.isPublished || report.isApproved ? null : Text('Fecha publicó: ${report.publishedDate}', style: TextStyle(color: Color(Constants.colorPrimary),), maxLines: 2,),
          !report.isApproved ? null : Text('Fecha de aprobación: ${report.approvedDate}', style: TextStyle(color: Color(Constants.colorPrimary),), maxLines: 2,),
          Text('${report.getNameFile()}', style: TextStyle(color: Color(Constants.colorPrimary), fontSize: 14.5, decoration: TextDecoration.underline,),),
          Text('FormularioId: ${report.pdfReportFormId}', style: TextStyle(color: Color(Constants.colorPrimary), fontSize: 14.5),),
          Text('Fecha reporte: ${report.startDate} - ${report.endDate}', style: TextStyle(color: Color(Constants.colorPrimary), fontSize: 14.5),),
        ].where((w) => w != null ).toList(),
      ),
    );

    final productInfo = InkWell( child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(Constants.colorPrimary)),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: <Widget>[
          imageView,
          infoView,
        ],
      ),
    ),
    onTap: (){
      onPressedInfo();
    },);

    final submits = Container(
      color: Color(Constants.colorPrimary),
      height: 30,
      child: Row(
        children: this.buttons.map<Widget>( (SubmitButton b) {
          return Expanded(
            child: Container(
              child: InkWell(
                child: Center(
                  child: Text(b.textSubmit, style: TextStyle(color: Colors.white,),),
                ),
                onTap: () {
                  b.onPressedSubmit();
                }),
              decoration: BoxDecoration(
                color: Color(Constants.colorPrimary),
                boxShadow: [
                  BoxShadow(color: Color(Constants.colorLight), spreadRadius: 1),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );

    return Container(
      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Column(
        children: <Widget>[
          productInfo,
          showSubmit ? submits : SizedBox(height: 0),
        ],
      ),
    );

  }

}

class SubmitButton {
  final String textSubmit;
  final VoidCallback onPressedSubmit;

  SubmitButton({
    Key key,
    @required this.textSubmit,
    @required this.onPressedSubmit,
  });

}
