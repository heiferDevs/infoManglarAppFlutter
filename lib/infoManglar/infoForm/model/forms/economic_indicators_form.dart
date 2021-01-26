
import '../../../../shared/form/model/form_config.dart';
import '../../../../util/utility.dart';

class EconomicIndicatorsForm{

  int economicIndicatorsFormId;
  int userId;
  int organizationManglarId;
  String formType;

  String principalActivity;
  String averageIncome;
  String alternativeActivities;
  String averageIncomeAlternatives;

  EconomicIndicatorsForm({
    this.economicIndicatorsFormId,
    this.formType,
    this.userId,
    this.organizationManglarId,
    this.principalActivity,
    this.averageIncome,
    this.alternativeActivities,
    this.averageIncomeAlternatives,
  });

  factory EconomicIndicatorsForm.fromFormConfig(FormConfig formConfig, int userId, int organizationManglarId) {
    return EconomicIndicatorsForm(
      formType: formConfig.idReport,
      economicIndicatorsFormId: formConfig.idForm,
      userId: userId,
      organizationManglarId: organizationManglarId,
      principalActivity: formConfig.getValue('principalActivity'),
      averageIncome: formConfig.getValue('averageIncome'),
      alternativeActivities: formConfig.getValue('alternativeActivities'),
      averageIncomeAlternatives: formConfig.getValue('averageIncomeAlternatives'),
    );
  }

  factory EconomicIndicatorsForm.fromJson(Map<String, dynamic> json) {
    return EconomicIndicatorsForm(
      economicIndicatorsFormId: json['economicIndicatorsFormId'],
      userId: json['userId'],
      organizationManglarId: json['organizationManglarId'],
      formType: json['formType'],
      principalActivity: json['principalActivity'],
      averageIncome: json['averageIncome'],
      alternativeActivities: json['alternativeActivities'],
      averageIncomeAlternatives: json['averageIncomeAlternatives'],
    );
  }

  // TO SAVE
  Map<String, dynamic> toJson() {
    Map<String, dynamic>  mapJson = {};
    mapJson['economicIndicatorsFormId'] = economicIndicatorsFormId;
    mapJson['formType'] = formType;
    mapJson['userId'] = userId;
    mapJson['organizationManglarId'] = organizationManglarId;
    mapJson['principalActivity'] = principalActivity;
    mapJson['averageIncome'] = averageIncome;
    mapJson['alternativeActivities'] = alternativeActivities;
    mapJson['averageIncomeAlternatives'] = averageIncomeAlternatives;
    return Utility.removeNull(mapJson);
  }

  FormConfig updateFormConfig(FormConfig formConfig){
    formConfig.getOption('principalActivity').setValueInit(principalActivity);
    formConfig.getOption('averageIncome').setValueInit(averageIncome);
    formConfig.getOption('alternativeActivities').setValueInit(alternativeActivities);
    formConfig.getOption('averageIncomeAlternatives').setValueInit(averageIncomeAlternatives);
    formConfig.idForm = economicIndicatorsFormId;

    return formConfig;
  }

}
