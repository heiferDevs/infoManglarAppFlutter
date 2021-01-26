
import '../../../../shared/form/model/form_config.dart';
import '../../../../util/utility.dart';

class ShellCollectionForm{

  int shellCollectionFormId;
  int userId;
  int organizationManglarId;
  String formType;

  String shellPeriod;
  int hoursWorked;
  int tuberculosasShellsCount;
  int similisShellsCount;
  int collectedGreaterCount;

  String sectorName;
  String collectorName;
  String collectorDate;

  ShellCollectionForm({
    this.shellCollectionFormId,
    this.formType,
    this.userId,
    this.organizationManglarId,
    this.shellPeriod,
    this.hoursWorked,
    this.tuberculosasShellsCount,
    this.similisShellsCount,
    this.collectedGreaterCount,
    this.sectorName,
    this.collectorName,
    this.collectorDate,
  });

  factory ShellCollectionForm.fromFormConfig(FormConfig formConfig, int userId, int organizationManglarId) {
    return ShellCollectionForm(
      formType: formConfig.idReport,
      shellCollectionFormId: formConfig.idForm,
      userId: userId,
      organizationManglarId: organizationManglarId,
      shellPeriod: formConfig.getValue('shellPeriod'),
      hoursWorked: formConfig.getValue('hoursWorked'),
      tuberculosasShellsCount: formConfig.getValue('tuberculosasShellsCount'),
      similisShellsCount: formConfig.getValue('similisShellsCount'),
      collectedGreaterCount: formConfig.getValue('collectedGreaterCount'),
      sectorName: formConfig.getValue('sectorName'),
      collectorName: formConfig.getValue('collectorName'),
      collectorDate: formConfig.getValue('collectorDate'),
    );
  }

  factory ShellCollectionForm.fromJson(Map<String, dynamic> json) {
    return ShellCollectionForm(
      shellCollectionFormId: json['shellCollectionFormId'],
      formType: json['formType'],
      userId: json['userId'],
      organizationManglarId: json['organizationManglarId'],
      shellPeriod: json['shellPeriod'],
      hoursWorked: json['hoursWorked'],
      tuberculosasShellsCount: json['tuberculosasShellsCount'],
      similisShellsCount: json['similisShellsCount'],
      collectedGreaterCount: json['collectedGreaterCount'],
      sectorName: json['sectorName'],
      collectorName: json['collectorName'],
      collectorDate: json['collectorDate'],
    );
  }


  // TO SAVE
  Map<String, dynamic> toJson() {
    Map<String, dynamic>  mapJson = {};
    mapJson['shellCollectionFormId'] = shellCollectionFormId;
    mapJson['formType'] = formType;
    mapJson['userId'] = userId;
    mapJson['organizationManglarId'] = organizationManglarId;
    mapJson['shellPeriod'] = shellPeriod;
    mapJson['hoursWorked'] = hoursWorked;
    mapJson['tuberculosasShellsCount'] = tuberculosasShellsCount;
    mapJson['similisShellsCount'] = similisShellsCount;
    mapJson['collectedGreaterCount'] = collectedGreaterCount;
    mapJson['sectorName'] = sectorName;
    mapJson['collectorName'] = collectorName;
    mapJson['collectorDate'] = collectorDate;
    return Utility.removeNull(mapJson);
  }

  FormConfig updateFormConfig(FormConfig formConfig){
    formConfig.getOption('shellPeriod').setValueInit(shellPeriod);
    formConfig.getOption('hoursWorked').setValueInit(hoursWorked);
    formConfig.getOption('tuberculosasShellsCount').setValueInit(tuberculosasShellsCount);
    formConfig.getOption('similisShellsCount').setValueInit(similisShellsCount);
    formConfig.getOption('collectedGreaterCount').setValueInit(collectedGreaterCount);
    formConfig.getOption('sectorName').setValueInit(sectorName);
    formConfig.getOption('collectorName').setValueInit(collectorName);
    formConfig.getOption('collectorDate').setValueInit(collectorDate);
    formConfig.idForm = shellCollectionFormId;

    return formConfig;
  }

}
