
import '../../../../shared/form/model/form_config.dart';
import '../../../../util/utility.dart';

class FishingEffortForm{

  int fishingEffortFormId;
  int userId;
  int organizationManglarId;
  String formType;

  int activePartners;
  String fishingEffortDate;

  FishingEffortForm({
    this.fishingEffortFormId,
    this.formType,
    this.userId,
    this.organizationManglarId,
    this.activePartners,
    this.fishingEffortDate,
  });

  factory FishingEffortForm.fromFormConfig(FormConfig formConfig, int userId, int organizationManglarId) {
    return FishingEffortForm(
      formType: formConfig.idReport,
      fishingEffortFormId: formConfig.idForm,
      userId: userId,
      organizationManglarId: organizationManglarId,
      activePartners: formConfig.getValue('activePartners'),
      fishingEffortDate: formConfig.getValue('fishingEffortDate'),
    );
  }

  factory FishingEffortForm.fromJson(Map<String, dynamic> json) {
    return FishingEffortForm(
      fishingEffortFormId: json['fishingEffortFormId'],
      formType: json['formType'],
      userId: json['userId'],
      organizationManglarId: json['organizationManglarId'],
      activePartners: json['activePartners'],
      fishingEffortDate: json['fishingEffortDate'],
    );
  }


  // TO SAVE
  Map<String, dynamic> toJson() {
    Map<String, dynamic>  mapJson = {};
    mapJson['fishingEffortFormId'] = fishingEffortFormId;
    mapJson['formType'] = formType;
    mapJson['userId'] = userId;
    mapJson['organizationManglarId'] = organizationManglarId;
    mapJson['activePartners'] = activePartners;
    mapJson['fishingEffortDate'] = fishingEffortDate;
    return Utility.removeNull(mapJson);
  }

  FormConfig updateFormConfig(FormConfig formConfig){
    formConfig.getOption('activePartners').setValueInit(activePartners);
    formConfig.getOption('fishingEffortDate').setValueInit(fishingEffortDate);
    formConfig.idForm = fishingEffortFormId;
    return formConfig;
  }

}
