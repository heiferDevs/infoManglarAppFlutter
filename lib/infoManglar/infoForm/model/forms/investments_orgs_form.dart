
import '../../../../shared/form/model/form_config.dart';
import '../../../../util/utility.dart';

class InvestmentsOrgsForm{

  int investmentsOrgsFormId;
  int userId;
  int organizationManglarId;
  String formType;

  double surveillanceControl;
  double sustainableUse;
  double administrativesExpenses;
  double socialActivities;
  double monitoring;
  double capacitation;
  double reforestation;
  double infrastructure;

  InvestmentsOrgsForm({
    this.investmentsOrgsFormId,
    this.formType,
    this.userId,
    this.organizationManglarId,
    this.surveillanceControl,
    this.sustainableUse,
    this.administrativesExpenses,
    this.socialActivities,
    this.monitoring,
    this.capacitation,
    this.reforestation,
    this.infrastructure,
  });

  factory InvestmentsOrgsForm.fromFormConfig(FormConfig formConfig, int userId, int organizationManglarId) {
    return InvestmentsOrgsForm(
      formType: formConfig.idReport,
      investmentsOrgsFormId: formConfig.idForm,
      userId: userId,
      organizationManglarId: organizationManglarId,
      surveillanceControl: formConfig.getValue('surveillanceControl'),
      sustainableUse: formConfig.getValue('sustainableUse'),
      administrativesExpenses: formConfig.getValue('administrativesExpenses'),
      socialActivities: formConfig.getValue('socialActivities'),
      monitoring: formConfig.getValue('monitoring'),
      capacitation: formConfig.getValue('capacitation'),
      reforestation: formConfig.getValue('reforestation'),
      infrastructure: formConfig.getValue('infrastructure'),
    );
  }

  factory InvestmentsOrgsForm.fromJson(Map<String, dynamic> json) {
    return InvestmentsOrgsForm(
      investmentsOrgsFormId: json['investmentsOrgsFormId'],
      userId: json['userId'],
      organizationManglarId: json['organizationManglarId'],
      formType: json['formType'],
      surveillanceControl: json['surveillanceControl'],
      sustainableUse: json['sustainableUse'],
      administrativesExpenses: json['administrativesExpenses'],
      socialActivities: json['socialActivities'],
      monitoring: json['monitoring'],
      capacitation: json['capacitation'],
      reforestation: json['reforestation'],
      infrastructure: json['infrastructure'],
    );
  }

  // TO SAVE
  Map<String, dynamic> toJson() {
    Map<String, dynamic>  mapJson = {};
    mapJson['investmentsOrgsFormId'] = investmentsOrgsFormId;
    mapJson['formType'] = formType;
    mapJson['userId'] = userId;
    mapJson['organizationManglarId'] = organizationManglarId;
    mapJson['surveillanceControl'] = surveillanceControl;
    mapJson['sustainableUse'] = sustainableUse;
    mapJson['administrativesExpenses'] = administrativesExpenses;
    mapJson['socialActivities'] = socialActivities;
    mapJson['monitoring'] = monitoring;
    mapJson['capacitation'] = capacitation;
    mapJson['reforestation'] = reforestation;
    mapJson['infrastructure'] = infrastructure;
    return Utility.removeNull(mapJson);
  }

  FormConfig updateFormConfig(FormConfig formConfig){
    print('please review surveillanceControl = $surveillanceControl ');
    formConfig.getOption('surveillanceControl').setValueInit(surveillanceControl);
    formConfig.getOption('sustainableUse').setValueInit(sustainableUse);
    formConfig.getOption('administrativesExpenses').setValueInit(administrativesExpenses);
    formConfig.getOption('socialActivities').setValueInit(socialActivities);
    formConfig.getOption('monitoring').setValueInit(monitoring);
    formConfig.getOption('capacitation').setValueInit(capacitation);
    formConfig.getOption('reforestation').setValueInit(reforestation);
    formConfig.getOption('infrastructure').setValueInit(infrastructure);
    formConfig.idForm = investmentsOrgsFormId;

    return formConfig;
  }

}
