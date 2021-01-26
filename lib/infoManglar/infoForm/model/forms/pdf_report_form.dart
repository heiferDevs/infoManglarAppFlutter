
import '../../../../shared/form/model/form_config.dart';
import '../../../../util/utility.dart';

import '../shared/file_form.dart';

class PdfReportForm{

  int pdfReportFormId;
  int userId;
  int organizationManglarId;
  String formType;

  String startDate;
  String endDate;

  bool isPublished;
  String publishedDate;

  // Approved
  bool isApproved;
  String approvedDate;
  int approvedId;

  // Observations
  bool isWithObservations;
  String observationDate;
  int observationId;

  List<FileForm> fileForms;

  PdfReportForm({
    this.pdfReportFormId,
    this.formType,
    this.userId,
    this.organizationManglarId,
    this.fileForms,
    this.startDate,
    this.endDate,
    this.publishedDate,
    this.approvedDate,
    this.observationDate,
    this.approvedId,
    this.observationId,
    this.isApproved = false,
    this.isWithObservations = false,
    this.isPublished = false,
  });

  factory PdfReportForm.fromFormConfig(FormConfig formConfig, int userId, int organizationManglarId) {
    List<FileForm> fileForms = [
      FileForm.fromOption(formConfig.getOption('pdfReport')),
    ];
    return PdfReportForm(
      pdfReportFormId: formConfig.idForm,
      formType: formConfig.idReport,
      userId: userId,
      organizationManglarId: organizationManglarId,
      fileForms: Utility.filterNull(fileForms),
      startDate: formConfig.getValue('startDate'),
      endDate: formConfig.getValue('endDate'),
      publishedDate: formConfig.getValue('publishedDate'),
      isPublished: formConfig.getValue('isPublished'),
      isApproved: formConfig.getValue('isApproved'),
      approvedDate: formConfig.getValue('approvedDate'),
      approvedId: formConfig.getValue('approvedId'),
      observationDate: formConfig.getValue('observationDate'),
      observationId: formConfig.getValue('observationId'),
      isWithObservations: formConfig.getValue('isWithObservations'),
    );
  }

  factory PdfReportForm.fromJson(Map<String, dynamic> json) {
    List<FileForm> fileFormsFromJson = json['fileForms'].map<FileForm>( (f) => FileForm.fromJson(f)).toList();
    return PdfReportForm(
      pdfReportFormId: json['pdfReportFormId'],
      formType: json['formType'],
      userId: json['userId'],
      organizationManglarId: json['organizationManglarId'],
      fileForms: fileFormsFromJson,
      startDate: json['startDate'],
      endDate: json['endDate'],
      publishedDate: json['publishedDate'],
      isPublished: json['isPublished'],
      isApproved: json['isApproved'],
      approvedId: json['approvedId'],
      approvedDate: json['approvedDate'],
      observationId: json['observationId'],
      observationDate: json['observationDate'],
      isWithObservations: json['isWithObservations'],
    );
  }

  // TO SAVE
  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> fileFormsJson = fileForms
      .map<Map<String, dynamic>>( (FileForm f) => f.toJson() ).toList();
    Map<String, dynamic>  mapJson = {};
    mapJson['pdfReportFormId'] = pdfReportFormId;
    mapJson['formType'] = formType;
    mapJson['userId'] = userId;
    mapJson['organizationManglarId'] = organizationManglarId;
    mapJson['fileForms'] = Utility.filterNull(fileFormsJson);
    mapJson['startDate'] = startDate;
    mapJson['endDate'] = endDate;
    mapJson['publishedDate'] = publishedDate;
    mapJson['isPublished'] = isPublished;
    mapJson['isApproved'] = isApproved;
    mapJson['isWithObservations'] = isWithObservations;
    mapJson['approvedDate'] = approvedDate;
    mapJson['approvedId'] = approvedId;
    mapJson['observationDate'] = observationDate;
    mapJson['observationId'] = observationId;
    return Utility.removeNull(mapJson);
  }

  FormConfig updateFormConfig(FormConfig formConfig){
    formConfig.getOption('startDate').setValueInit(startDate);
    formConfig.getOption('endDate').setValueInit(endDate);
    formConfig.getOption('publishedDate').setValueInit(publishedDate);
    formConfig.getOption('isPublished').setValueInit(isPublished);
    formConfig.getOption('isApproved').setValueInit(isApproved);
    formConfig.getOption('isWithObservations').setValueInit(approvedDate);
    formConfig.getOption('isWithObservations').setValueInit(approvedId);
    formConfig.getOption('isWithObservations').setValueInit(observationDate);
    formConfig.getOption('isWithObservations').setValueInit(observationId);
    formConfig.getOption('isWithObservations').setValueInit(isWithObservations);
    formConfig.idForm = pdfReportFormId;

    // Fill files
    fileForms.forEach( (FileForm fileForm) {
      formConfig.getOption(fileForm.idOption).setValueInit(fileForm);
    });
    return formConfig;
  }

  String getNameFile(){
    if (fileForms == null || fileForms.length == 0) return null;
    FileForm fileForm = fileForms.asMap()[0];
    return fileForm.name;
  }

  String getUrlFile(String idOption){
    if (fileForms == null || fileForms.length == 0) return null;
    FileForm fileForm = fileForms.where( (FileForm f) => f.idOption == idOption).toList().asMap()[0];
    return fileForm.url;
  }

}
