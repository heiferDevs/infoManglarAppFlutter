
import '../../../../shared/form/model/form_config.dart';
import '../../../../util/utility.dart';

class SocialIndicatorsForm{

  int socialIndicatorsFormId;
  int userId;
  int organizationManglarId;
  String formType;

  int countFamilyMembers;
  int countManglarDependents;
  double incomePercentage;
  String nivel;

  SocialIndicatorsForm({
    this.socialIndicatorsFormId,
    this.formType,
    this.userId,
    this.organizationManglarId,
    this.countFamilyMembers,
    this.countManglarDependents,
    this.incomePercentage,
    this.nivel,
  });

  factory SocialIndicatorsForm.fromFormConfig(FormConfig formConfig, int userId, int organizationManglarId) {
    return SocialIndicatorsForm(
      formType: formConfig.idReport,
      socialIndicatorsFormId: formConfig.idForm,
      userId: userId,
      organizationManglarId: organizationManglarId,
      countFamilyMembers: formConfig.getValue('countFamilyMembers'),
      countManglarDependents: formConfig.getValue('countManglarDependents'),
      incomePercentage: formConfig.getValue('incomePercentage'),
      nivel: formConfig.getValue('nivel'),
    );
  }

  factory SocialIndicatorsForm.fromJson(Map<String, dynamic> json) {
    return SocialIndicatorsForm(
      socialIndicatorsFormId: json['socialIndicatorsFormId'],
      formType: json['formType'],
      userId: json['userId'],
      organizationManglarId: json['organizationManglarId'],
      countFamilyMembers: json['countFamilyMembers'],
      countManglarDependents: json['countManglarDependents'],
      incomePercentage: json['incomePercentage'],
      nivel: json['nivel'],
    );
  }

  // TO SAVE
  Map<String, dynamic> toJson() {
    Map<String, dynamic>  mapJson = {};
    mapJson['socialIndicatorsFormId'] = socialIndicatorsFormId;
    mapJson['formType'] = formType;
    mapJson['userId'] = userId;
    mapJson['organizationManglarId'] = organizationManglarId;
    mapJson['countFamilyMembers'] = countFamilyMembers;
    mapJson['countManglarDependents'] = countManglarDependents;
    mapJson['incomePercentage'] = incomePercentage;
    mapJson['nivel'] = nivel;
    return Utility.removeNull(mapJson);
  }

  FormConfig updateFormConfig(FormConfig formConfig){
    formConfig.getOption('countFamilyMembers').setValueInit(countFamilyMembers);
    formConfig.getOption('countManglarDependents').setValueInit(countManglarDependents);
    formConfig.getOption('incomePercentage').setValueInit(incomePercentage);
    formConfig.getOption('nivel').setValueInit(nivel);
    formConfig.idForm = socialIndicatorsFormId;
    return formConfig;
  }

}
