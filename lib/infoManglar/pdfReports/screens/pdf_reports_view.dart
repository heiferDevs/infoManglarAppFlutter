
import 'package:intl/intl.dart';

import '../../../infoManglar/config/repository/config_repository.dart';
import '../../../infoManglar/infoForm/repository/info_form_repository.dart';
import '../../../infoManglar/infoForm/model/forms/pdf_report_form.dart';
import '../../../infoManglar/infoForm/controller/info_form_save_controller.dart';
import '../../../infoManglar/infoForm/model/shared/file_form.dart';
import '../../../plugins/fileExport.dart';
import '../../../plugins/file_picker.dart';
import '../../../shared/form/model/data.dart';
import '../../../shared/form/model/option.dart';
import '../../../shared/form/widgets/input.dart';
import '../../../util/user.dart';
import '../../../util/utility.dart';
import 'package:flutter/material.dart';
import '../repository/pdf_reports_repository.dart';
import '../widgets/item_pdf_report.dart';
import '../../../util/style.dart';
import '../../../plugins/url_launcher.dart';
import 'dart:convert';

class PdfReportsView extends StatefulWidget{
  @override
  _State createState() {
    return _State();
  }
}

class _State extends State<PdfReportsView> {

  final _configRepository = ConfigRepository();
  final _pdfReportsRepository = PdfReportsRepository();
  final _infoFormRepository = InfoFormRepository();
  final _infoFormSaveController = InfoFormSaveController();

  bool _isLoadingPdfReportsView = true;

  // Custom Filters
  final Option organizationsOption = Option(label: 'Organización', type: 'select', options: []);

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
      _isLoadingPdfReportsView = loading;
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

    return _isLoadingPdfReportsView ?
    (User.hasInternetConnection ? Utility.getCircularProgress() : Utility.getErrorMessage()) :
    Container(
      child: ListView(
        children: <Widget>[
          headerTitle,
          Input(config: organizationsOption),
          _getPdfReportsView(),
        ],
      ),
    );
  }

  Widget _getPdfReportsView() {
    String orgId = organizationsOption.value.id;
    return FutureBuilder(
      future: _infoFormRepository.getPdfReportsPublished(orgId),
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
      if (!report.isApproved) submits.add(_getApprovedButton(report));
      if (!report.isApproved && !report.isWithObservations) submits.add(_getObservationsButton(report));

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

  SubmitButton _getApprovedButton(PdfReportForm report){
    String textSubmit = 'SUBIR APROBACIÓN';
    return SubmitButton(textSubmit: textSubmit, onPressedSubmit: () {
      FilePickerApp.getImageOrDocumentPath().then( (FileExport fileExport) {
        if ( fileExport == null ) {
          Utility.showToast(context, 'FORMATO O ARCHIVO NO VALIDO');
          return;
        }
        _setLoading(true);
        List<FileForm> fileForms = [];
        fileForms.addAll(report.fileForms);
        fileForms.add(FileForm.fromFileExport(fileExport, "approved"));
        _infoFormSaveController.saveFiles(fileForms).then( (success) {
          if (!success) {
            Utility.showToast(context, 'FORMATO O ARCHIVO NO VALIDO');
            _setLoading(false);
            return;
          }
          report.isApproved = true;
          report.approvedId = int.tryParse(User.userId);
          report.approvedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
          report.fileForms = fileForms;
          String data = json.encode(report.toJson());
          _infoFormRepository.savePdfReportForm(data).then( (Data data) {
            if (data.state == 'OK') {
              Utility.showToast(context, 'Informe aprobado');
            }
            _setLoading(false);
          });
        });
      });
    });
  }

  SubmitButton _getObservationsButton(PdfReportForm report){
    String textSubmit = 'SUBIR OBSERVACIONES';
    return SubmitButton(textSubmit: textSubmit, onPressedSubmit: () {
      FilePickerApp.getImageOrDocumentPath().then( (FileExport fileExport) {
        if ( fileExport == null ) {
          Utility.showToast(context, 'FORMATO O ARCHIVO NO VALIDO');
          return;
        }
        _setLoading(true);
        List<FileForm> fileForms = [];
        fileForms.addAll(report.fileForms);
        fileForms.add(FileForm.fromFileExport(fileExport, "observations"));
        _infoFormSaveController.saveFiles(fileForms).then( (success) {
          if (!success) {
            Utility.showToast(context, 'FORMATO O ARCHIVO NO VALIDO');
            _setLoading(false);
            return;
          }
          report.isWithObservations = true;
          report.observationId = int.tryParse(User.userId);
          report.observationDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
          report.fileForms = fileForms;
          String data = json.encode(report.toJson());
          _infoFormRepository.savePdfReportForm(data).then( (Data data) {
            if (data.state == 'OK') {
              Utility.showToast(context, 'Subió observaciones');
            }
            _setLoading(false);
          });
        });
      });
    });
  }

  Future<bool> _loadData() async {
    if (!User.hasInternetConnection) return false;
    List<Data> organizations = await _configRepository.getOrganizationsByType("org");
    organizationsOption.options = organizations;
    organizationsOption.value = organizationsOption.options.asMap()[0];
    organizationsOption.onClick = (value) => _addActionSelect(organizationsOption, value);
    return true;
  }

  _addActionSelect(Option option, String value){
    option.setValueByIdOption(value, ({idOptionChange = ''}){
      setState(() {
      });
    });
  }

}
