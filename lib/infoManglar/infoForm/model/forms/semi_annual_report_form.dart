
import '../../../../shared/form/model/form_config.dart';
import '../../../../util/utility.dart';

import '../shared/file_form.dart';

class SemiAnnualReportForm{

  int semiAnnualReportFormId;
  int userId;
  int organizationManglarId;
  String formType;

  String organizationName;
  String semiAnnual;
  int yearReport;

  List<FileForm> fileForms;

  SemiAnnualReportForm({
    this.semiAnnualReportFormId,
    this.formType,
    this.userId,
    this.organizationManglarId,
    this.fileForms,
    this.organizationName,
    this.semiAnnual,
    this.yearReport,
  });

  factory SemiAnnualReportForm.fromFormConfig(FormConfig formConfig, int userId, int organizationManglarId) {
    List<FileForm> fileForms = [
      FileForm.fromOption(formConfig.getOption('reportApproved')),
      FileForm.fromOption(formConfig.getOption('reportSgmc')),
    ];
    return SemiAnnualReportForm(
      formType: formConfig.idReport,
      semiAnnualReportFormId: formConfig.idForm,
      userId: userId,
      organizationManglarId: organizationManglarId,
      fileForms: Utility.filterNull(fileForms),
      organizationName: formConfig.getValue('organizationName'),
      semiAnnual: formConfig.getValue('semiAnnual'),
      yearReport: formConfig.getValue('yearReport'),
    );
  }

  factory SemiAnnualReportForm.fromJson(Map<String, dynamic> json) {
    List<FileForm> fileFormsFromJson = json['fileForms'].map<FileForm>( (f) => FileForm.fromJson(f) ).toList();
    return SemiAnnualReportForm(
      semiAnnualReportFormId: json['semiAnnualReportFormId'],
      formType: json['formType'],
      userId: json['userId'],
      organizationManglarId: json['organizationManglarId'],
      fileForms: fileFormsFromJson,
      organizationName: json['organizationName'],
      semiAnnual: json['semiAnnual'],
      yearReport: json['yearReport'],
    );
  }

  // TO SAVE
  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> fileFormsJson = fileForms
      .map<Map<String, dynamic>>( (FileForm f) => f.toJson() ).toList();
    Map<String, dynamic>  mapJson = {};
    mapJson['semiAnnualReportFormId'] = semiAnnualReportFormId;
    mapJson['formType'] = formType;
    mapJson['userId'] = userId;
    mapJson['organizationManglarId'] = organizationManglarId;
    mapJson['fileForms'] = Utility.filterNull(fileFormsJson);
    mapJson['organizationName'] = organizationName;
    mapJson['semiAnnual'] = semiAnnual;
    mapJson['yearReport'] = yearReport;
    return Utility.removeNull(mapJson);
  }

  FormConfig updateFormConfig(FormConfig formConfig){
    formConfig.getOption('organizationName').setValueInit(organizationName);
    formConfig.getOption('semiAnnual').setValueInit(semiAnnual);
    formConfig.getOption('yearReport').setValueInit(yearReport);
    formConfig.idForm = semiAnnualReportFormId;

    // Fill files
    fileForms.forEach( (FileForm fileForm) {
      formConfig.getOption(fileForm.idOption).setValueInit(fileForm);
    });
    return formConfig;
  }

}
