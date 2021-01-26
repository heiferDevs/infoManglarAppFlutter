
import '../../../../shared/form/model/form_config.dart';
import '../../../../util/utility.dart';

class InfoVedaForm{

  int infoVedaFormId;
  int userId;
  int organizationManglarId;
  String formType;

  String informationGathering;
  String eventType;
  String mudaFeatures;
  String observations;

  String sectorName;

  InfoVedaForm({
    this.infoVedaFormId,
    this.formType,
    this.userId,
    this.organizationManglarId,
    this.informationGathering,
    this.eventType,
    this.mudaFeatures,
    this.observations,
    this.sectorName,
  });

  factory InfoVedaForm.fromFormConfig(FormConfig formConfig, int userId, int organizationManglarId) {
    return InfoVedaForm(
      formType: formConfig.idReport,
      infoVedaFormId: formConfig.idForm,
      userId: userId,
      organizationManglarId: organizationManglarId,
      informationGathering: formConfig.getValue('informationGathering'),
      eventType: formConfig.getValue('eventType'),
      mudaFeatures: formConfig.getValue('mudaFeatures'),
      observations: formConfig.getValue('observations'),
      sectorName: formConfig.getValue('sectorName'),
    );
  }

  factory InfoVedaForm.fromJson(Map<String, dynamic> json) {
    return InfoVedaForm(
      infoVedaFormId: json['infoVedaFormId'],
      formType: json['formType'],
      userId: json['userId'],
      organizationManglarId: json['organizationManglarId'],
      informationGathering: json['informationGathering'],
      eventType: json['eventType'],
      mudaFeatures: json['mudaFeatures'],
      observations: json['observations'],
      sectorName: json['sectorName'],
    );
  }

  // TO SAVE
  Map<String, dynamic> toJson() {
    Map<String, dynamic>  mapJson = {};
    mapJson['infoVedaFormId'] = infoVedaFormId;
    mapJson['formType'] = formType;
    mapJson['userId'] = userId;
    mapJson['organizationManglarId'] = organizationManglarId;
    mapJson['informationGathering'] = informationGathering;
    mapJson['eventType'] = eventType;
    mapJson['mudaFeatures'] = mudaFeatures;
    mapJson['observations'] = observations;
    mapJson['sectorName'] = sectorName;
    return Utility.removeNull(mapJson);
  }

  FormConfig updateFormConfig(FormConfig formConfig){
    formConfig.getOption('informationGathering').setValueInit(informationGathering);
    formConfig.getOption('eventType').setValueInit(eventType);
    if (formConfig.getOption('mudaFeatures') != null)
      formConfig.getOption('mudaFeatures').setValueInit(mudaFeatures);
    formConfig.getOption('observations').setValueInit(observations);
    formConfig.getOption('sectorName').setValueInit(sectorName);
    formConfig.idForm = infoVedaFormId;

    return formConfig;
  }

}
