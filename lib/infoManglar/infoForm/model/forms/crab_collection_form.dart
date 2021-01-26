
import '../../../../shared/form/model/form_config.dart';
import '../../../../util/utility.dart';

class CrabCollectionForm{

  int crabCollectionFormId;
  int userId;
  int organizationManglarId;
  String formType;

  String crabPeriod;
  int hoursWorked;
  int crabCollectedCount;
  int quedadosCrabs;
  int femalesReturned;
  int collectedGreaterCount;

  String sectorName;
  String collectorName;
  String collectorDate;

  CrabCollectionForm({
    this.crabCollectionFormId,
    this.formType,
    this.userId,
    this.organizationManglarId,
    this.crabPeriod,
    this.hoursWorked,
    this.crabCollectedCount,
    this.quedadosCrabs,
    this.femalesReturned,
    this.collectedGreaterCount,
    this.sectorName,
    this.collectorName,
    this.collectorDate,
  });

  factory CrabCollectionForm.fromFormConfig(FormConfig formConfig, int userId, int organizationManglarId) {
    return CrabCollectionForm(
      formType: formConfig.idReport,
      crabCollectionFormId: formConfig.idForm,
      userId: userId,
      organizationManglarId: organizationManglarId,
      crabPeriod: formConfig.getValue('crabPeriod'),
      hoursWorked: formConfig.getValue('hoursWorked'),
      crabCollectedCount: formConfig.getValue('crabCollectedCount'),
      quedadosCrabs: formConfig.getValue('quedadosCrabs'),
      femalesReturned: formConfig.getValue('femalesReturned'),
      collectedGreaterCount: formConfig.getValue('collectedGreaterCount'),
      sectorName: formConfig.getValue('sectorName'),
      collectorName: formConfig.getValue('collectorName'),
      collectorDate: formConfig.getValue('collectorDate'),
    );
  }

  factory CrabCollectionForm.fromJson(Map<String, dynamic> json) {
    return CrabCollectionForm(
      crabCollectionFormId: json['crabCollectionFormId'],
      formType: json['formType'],
      userId: json['userId'],
      organizationManglarId: json['organizationManglarId'],
      crabPeriod: json['crabPeriod'],
      hoursWorked: json['hoursWorked'],
      crabCollectedCount: json['crabCollectedCount'],
      quedadosCrabs: json['quedadosCrabs'],
      femalesReturned: json['femalesReturned'],
      collectedGreaterCount: json['collectedGreaterCount'],
      sectorName: json['sectorName'],
      collectorName: json['collectorName'],
      collectorDate: json['collectorDate'],
    );
  }


  // TO SAVE
  Map<String, dynamic> toJson() {
    Map<String, dynamic>  mapJson = {};
    mapJson['crabCollectionFormId'] = crabCollectionFormId;
    mapJson['formType'] = formType;
    mapJson['userId'] = userId;
    mapJson['organizationManglarId'] = organizationManglarId;
    mapJson['crabPeriod'] = crabPeriod;
    mapJson['hoursWorked'] = hoursWorked;
    mapJson['crabCollectedCount'] = crabCollectedCount;
    mapJson['quedadosCrabs'] = quedadosCrabs;
    mapJson['femalesReturned'] = femalesReturned;
    mapJson['collectedGreaterCount'] = collectedGreaterCount;
    mapJson['sectorName'] = sectorName;
    mapJson['collectorName'] = collectorName;
    mapJson['collectorDate'] = collectorDate;
    return Utility.removeNull(mapJson);
  }

  FormConfig updateFormConfig(FormConfig formConfig){
    formConfig.getOption('crabPeriod').setValueInit(crabPeriod);
    formConfig.getOption('hoursWorked').setValueInit(hoursWorked);
    formConfig.getOption('crabCollectedCount').setValueInit(crabCollectedCount);
    formConfig.getOption('quedadosCrabs').setValueInit(quedadosCrabs);
    formConfig.getOption('femalesReturned').setValueInit(femalesReturned);
    formConfig.getOption('collectedGreaterCount').setValueInit(collectedGreaterCount);
    formConfig.getOption('sectorName').setValueInit(sectorName);
    formConfig.getOption('collectorName').setValueInit(collectorName);
    formConfig.getOption('collectorDate').setValueInit(collectorDate);
    formConfig.idForm = crabCollectionFormId;

    return formConfig;
  }

}
