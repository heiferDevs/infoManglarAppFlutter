
import '../../../infoManglar/config/repository/config_repository.dart';
import '../../../infoManglar/infoForm/repository/info_form_repository.dart';
import '../../../infoManglar/infoForm/model/forms/pdf_report_form.dart';
import '../../../shared/form/model/data.dart';
import '../../../shared/form/model/option.dart';
import '../../../shared/form/widgets/input.dart';
import '../../../util/user.dart';
import '../../../util/utility.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../repository/pdf_reports_repository.dart';
import '../widgets/item_pdf_report.dart';
import '../../../util/style.dart';
import 'dart:convert';
import '../../../constants.dart';
import '../../../plugins/url_launcher.dart';

class PdfReports extends StatefulWidget{
  @override
  _State createState() {
    return _State();
  }
}

class _State extends State<PdfReports> {

  final _pdfReportsRepository = PdfReportsRepository();
  final _infoFormRepository = InfoFormRepository();

  bool _isLoadingPdfReports = false;

  // Custom Filters
  final Option startDate = Option(label: 'Fecha inicio', type: 'calendar', typeInput: 'date');
  final Option endDate = Option(label: 'Fecha fin', type: 'calendar', typeInput: 'date');

  @override
  void initState() {
    super.initState();
    _loadData().then( (bool success) {
      if (!success) return;
      _setLoading(false);
    });
  }

  _setLoading(bool loading){
    setState(() {
      _isLoadingPdfReports = loading;
    });
  }

  _generatePdfReports(){
    setState(() {
      _isLoadingPdfReports = true;
    });
    int start = DateTime.parse(startDate.getValue()).millisecondsSinceEpoch;
    int end = DateTime.parse(endDate.getValue()).add(Duration(days: 1)).subtract(Duration(seconds: 1)).millisecondsSinceEpoch;
    String data = json.encode({
      'urlBase': Constants.hostUrl,
      'start': start,
      'end': end,
      'userId': int.tryParse(User.userId),
      'orgId': int.tryParse(User.organizationManglarId),
    });
    print('data $data');
    _pdfReportsRepository.generatePdfReport(data).then( (Data result) {
      setState(() {
        print('result ${result.state}');
        _isLoadingPdfReports = false;
      });
    });
  }


  @override
  Widget build(BuildContext context) {

    final headerTitle = Container(
      padding: EdgeInsets.fromLTRB(10, 30, 10, 30),
      child: Center(
        child: Text(
          'INFORME SEMESTRAL',
          style: StyleApp.getStyleTitle(22),
        ),
      ),
    );

    final submitButton = StyleApp.getButton('GENERAR', () => _generatePdfReports(), margin: 12);

    return _isLoadingPdfReports ?
    (User.hasInternetConnection ? Utility.getCircularProgress() : Utility.getErrorMessage()) :
    Container(
      child: ListView(
        children: <Widget>[
          headerTitle,
          Input(config: startDate),
          Input(config: endDate),
          submitButton,
          _getPdfReports(),
        ],
      ),
    );
  }

  Widget _getPdfReports() {
    return FutureBuilder(
      future: _infoFormRepository.getPdfReports(User.organizationManglarId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return reports(snapshot.data);
        } else if (snapshot.hasError) {
          return Utility.getErrorMessage();
        }
        return Utility.getCircularProgress();
      },
    );
  }

  Widget reports(List<PdfReportForm> reports){
    List<Widget> items = [
      StyleApp.getTitle('RESULTADOS: ${reports.length}', padding: 8),
    ];

    List<Widget> _reportsItems = reports.map<Widget>( (PdfReportForm report) {
      List<SubmitButton> submits = [];
      if (!report.isPublished && !report.isApproved) submits.add(_getDeleteButton(report));
      if (!report.isApproved) submits.add(_getPublishButton(report));
      if (report.isApproved) submits.add(_getApprovedFileButton(report));
      if (!report.isApproved && report.isWithObservations) submits.add(_getObservationsFileButton(report));
      return ItemPdfReport(report: report, buttons: submits, onPressedInfo: () {
        UrlLauncher.launchURL(report.getUrlFile('pdfReport'));
      });
    }).toList();

    items.addAll(_reportsItems);

    return Container(
      child: Column(
        children: items,
      ),
    );
  }

  SubmitButton _getApprovedFileButton(PdfReportForm report){
    String textSubmit = 'VER APROBACIÓN';
    return SubmitButton(textSubmit: textSubmit, onPressedSubmit: () {
      UrlLauncher.launchURL(report.getUrlFile('approved'));
    });
  }

  SubmitButton _getObservationsFileButton(PdfReportForm report){
    String textSubmit = 'VER OBSERVACIONES';
    return SubmitButton(textSubmit: textSubmit, onPressedSubmit: () {
      UrlLauncher.launchURL(report.getUrlFile('observations'));
    });
  }


  SubmitButton _getDeleteButton(PdfReportForm report){
    String textSubmit = 'DESCARTAR';
    return SubmitButton(textSubmit: textSubmit, onPressedSubmit: () {
      Utility.showConfirm(context, 'Atención','¿Esta seguro de descartar el informe ${report.pdfReportFormId}?', (){
        _setLoading(true);
        _infoFormRepository.removePdfReportForm(report.pdfReportFormId).then( (Data data) {
          if (data.state == 'OK') {
            Utility.showToast(context, 'Descartó el informe' );
          }
          _setLoading(false);
        });
      });
    });
  }

  SubmitButton _getPublishButton(PdfReportForm report){
    String textSubmit = !report.isPublished ? 'PUBLICAR' : 'DEJAR DE PUBLICAR';
    return SubmitButton(textSubmit: textSubmit, onPressedSubmit: () {
      _setLoading(true);
      report.isPublished = !report.isPublished;
      report.publishedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
      String data = json.encode(report.toJson());
      _infoFormRepository.savePdfReportForm(data).then( (Data data) {
        if (data.state == 'OK') {
          Utility.showToast(context, report.isPublished ? 'Informe publicado' : 'Informe no publicado' );
        }
        _setLoading(false);
      });
    });
  }

  Future<bool> _loadData() async {
    if (!User.hasInternetConnection) return false;
    // Date
    startDate.setValueInit(DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 7))));
    endDate.setValueInit(DateFormat('yyyy-MM-dd').format(DateTime.now()));
    startDate.onClick = (value) => _addActionCalendar(startDate, value);
    endDate.onClick = (value) => _addActionCalendar(endDate, value);
    return true;
  }

  _addActionCalendar(Option option, String value){
    option.setValue(value, ({idOptionChange = ''}){
      setState(() {
        //_enableSubmit = true;
      });
    });
  }

}
