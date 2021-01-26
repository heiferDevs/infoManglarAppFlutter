
import '../../../../shared/form/model/form_config.dart';
import '../../../../util/utility.dart';

import '../shared/file_form.dart';

class TechnicalReportForm{

  int technicalReportFormId;
  int userId;
  int organizationManglarId;
  String formType;

  List<FileForm> fileForms;

  TechnicalReportForm({
    this.technicalReportFormId,
    this.formType,
    this.userId,
    this.organizationManglarId,
    this.fileForms,
  });

  factory TechnicalReportForm.fromFormConfig(FormConfig formConfig, int userId, int organizationManglarId) {
    List<FileForm> fileForms = [
      FileForm.fromOption(formConfig.getOption('reportInp')),
    ];
    return TechnicalReportForm(
      formType: formConfig.idReport,
      technicalReportFormId: formConfig.idForm,
      userId: userId,
      organizationManglarId: organizationManglarId,
      fileForms: Utility.filterNull(fileForms),
    );
  }

  factory TechnicalReportForm.fromJson(Map<String, dynamic> json) {
    List<FileForm> fileFormsFromJson = json['fileForms'].map<FileForm>( (f) => FileForm.fromJson(f) ).toList();
    return TechnicalReportForm(
      technicalReportFormId: json['technicalReportFormId'],
      formType: json['formType'],
      userId: json['userId'],
      organizationManglarId: json['organizationManglarId'],
      fileForms: fileFormsFromJson,
    );
  }

  // TO SAVE
  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> fileFormsJson = fileForms
      .map<Map<String, dynamic>>( (FileForm f) => f.toJson() ).toList();
    Map<String, dynamic>  mapJson = {};
    mapJson['technicalReportFormId'] = technicalReportFormId;
    mapJson['formType'] = formType;
    mapJson['userId'] = userId;
    mapJson['organizationManglarId'] = organizationManglarId;
    mapJson['fileForms'] = Utility.filterNull(fileFormsJson);
    return Utility.removeNull(mapJson);
  }

  FormConfig updateFormConfig(FormConfig formConfig){
    formConfig.idForm = technicalReportFormId;

    // Fill files
    fileForms.forEach( (FileForm fileForm) {
      formConfig.getOption(fileForm.idOption).setValueInit(fileForm);
    });
    return formConfig;
  }

}
