
import '../../../../shared/form/model/form_config.dart';
import '../../../../util/utility.dart';

import '../shared/file_form.dart';

class ControlForm{

  int controlFormId;
  int userId;
  int organizationManglarId;
  String formType;

  // Organization
  String responsiblePatrullaje;
  String sector;
  String startSite;
  String endSite;
  String registerDetails;
  int routeDuration;
  String routeDate;
  String routeLocalities;
  String internalAuditor;

  bool eventExists;
  String type;
  String verification;

  List<FileForm> fileForms;

  ControlForm({
    this.controlFormId,
    this.formType,
    this.userId,
    this.organizationManglarId,
    this.fileForms,
    this.responsiblePatrullaje,
    this.sector,
    this.startSite,
    this.endSite,
    this.registerDetails,
    this.routeDuration,
    this.routeDate,
    this.routeLocalities,
    this.internalAuditor,
    this.eventExists,
    this.type,
    this.verification,
  });

  factory ControlForm.fromFormConfig(FormConfig formConfig, int userId, int organizationManglarId) {
    List<FileForm> fileForms = [
    ];
    print('revise yearCreation ${formConfig.getValue('yearCreation')}');
    return ControlForm(
      controlFormId: formConfig.idForm,
      formType: formConfig.idReport,
      userId: userId,
      organizationManglarId: organizationManglarId,
      fileForms: Utility.filterNull(fileForms),
      responsiblePatrullaje: formConfig.getValue('responsiblePatrullaje'),
      sector: formConfig.getValue('sector'),
      startSite: formConfig.getValue('startSite'),
      endSite: formConfig.getValue('endSite'),
      registerDetails: formConfig.getValue('registerDetails'),
      routeDuration: Utility.getInt(formConfig.getValue('routeDuration')),
      routeDate: formConfig.getValue('routeDate'),
      routeLocalities: formConfig.getValue('routeLocalities'),
      internalAuditor: formConfig.getValue('internalAuditor'),
      eventExists: formConfig.getValue('eventExists'),
      type: formConfig.getValue('type'),
      verification: formConfig.getValue('verification'),
    );
  }

  factory ControlForm.fromJson(Map<String, dynamic> json) {
    List<FileForm> fileFormsFromJson = json['fileForms'].map<FileForm>( (f) => FileForm.fromJson(f)).toList();
    return ControlForm(
      controlFormId: json['controlFormId'],
      formType: json['formType'],
      userId: json['userId'],
      organizationManglarId: json['organizationManglarId'],
      fileForms: fileFormsFromJson,
      responsiblePatrullaje: json['responsiblePatrullaje'],
      sector: json['sector'],
      startSite: json['startSite'],
      endSite: json['endSite'],
      registerDetails: json['registerDetails'],
      routeDuration: json['routeDuration'],
      routeDate: json['routeDate'],
      routeLocalities: json['routeLocalities'],
      internalAuditor: json['internalAuditor'],
      eventExists: json['eventExists'],
      type: json['type'],
      verification: json['verification'],
    );
  }


  // TO SAVE
  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> fileFormsJson = fileForms
      .map<Map<String, dynamic>>( (FileForm f) => f.toJson() ).toList();
    Map<String, dynamic>  mapJson = {};
    mapJson['controlFormId'] = controlFormId;
    mapJson['formType'] = formType;
    mapJson['userId'] = userId;
    mapJson['organizationManglarId'] = organizationManglarId;
    mapJson['fileForms'] = Utility.filterNull(fileFormsJson);
    mapJson['responsiblePatrullaje'] = responsiblePatrullaje;
    mapJson['sector'] = sector;
    mapJson['startSite'] = startSite;
    mapJson['endSite'] = endSite;
    mapJson['registerDetails'] = registerDetails;
    mapJson['routeDuration'] = routeDuration;
    mapJson['routeDate'] = routeDate;
    mapJson['routeLocalities'] = routeLocalities;
    mapJson['internalAuditor'] = internalAuditor;
    mapJson['eventExists'] = eventExists;
    mapJson['type'] = type;
    mapJson['verification'] = verification;
    return Utility.removeNull(mapJson);
  }

  FormConfig updateFormConfig(FormConfig formConfig){
    formConfig.getOption('responsiblePatrullaje').setValueInit(responsiblePatrullaje);
    formConfig.getOption('sector').setValueInit(sector);
    formConfig.getOption('startSite').setValueInit(startSite);
    formConfig.getOption('endSite').setValueInit(endSite);
    formConfig.getOption('registerDetails').setValueInit(registerDetails);
    formConfig.getOption('routeDuration').setValueInit(routeDuration);
    formConfig.getOption('routeDate').setValueInit(routeDate);
    formConfig.getOption('routeLocalities').setValueInit(routeLocalities);
    formConfig.getOption('internalAuditor').setValueInit(internalAuditor);
    formConfig.getOption('eventExists').setValueInit(eventExists);
    if (formConfig.getOption('type') != null) formConfig.getOption('type').setValueInit(type);
    if (formConfig.getOption('verification') != null) formConfig.getOption('verification').setValueInit(verification);
    formConfig.idForm = controlFormId;

    // Fill files
    fileForms.forEach( (FileForm fileForm) {
      formConfig.getOption(fileForm.idOption).setValueInit(fileForm);
    });
    return formConfig;
  }

}
