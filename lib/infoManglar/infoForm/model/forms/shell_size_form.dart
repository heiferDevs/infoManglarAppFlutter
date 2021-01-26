
import '../../model/shared/size_form.dart';
import '../../../../shared/form/model/form_config.dart';
import '../../../../shared/form/model/option.dart';
import '../../../../util/utility.dart';

class ShellSizeForm{

  int shellSizeFormId;
  int userId;
  int organizationManglarId;
  String formType;

  String concheroName;
  String shellType;
  String samplingDate;
  int shellCount;

  String sectorName;

  List<SizeForm> sizeForms;

  ShellSizeForm({
    this.shellSizeFormId,
    this.formType,
    this.userId,
    this.organizationManglarId,
    this.sizeForms,
    this.concheroName,
    this.samplingDate,
    this.shellType,
    this.shellCount,
    this.sectorName,
  });

  factory ShellSizeForm.fromFormConfig(FormConfig formConfig, int userId, int organizationManglarId) {
    List<SizeForm> sizeForms = formConfig.getOptions('sizeGroup')
        .map<SizeForm>( (Option o) {
      return SizeForm.fromOption(o);
    }).toList();
    return ShellSizeForm(
      formType: formConfig.idReport,
      shellSizeFormId: formConfig.idForm,
      userId: userId,
      organizationManglarId: organizationManglarId,
      sizeForms: Utility.filterNull(sizeForms),
      concheroName: formConfig.getValue('concheroName'),
      samplingDate: formConfig.getValue('samplingDate'),
      shellType: formConfig.getValue('shellType'),
      sectorName: formConfig.getValue('sectorName'),
      shellCount: Utility.getInt(formConfig.getValue('shellCount')),
    );
  }

  factory ShellSizeForm.fromJson(Map<String, dynamic> json) {
    List<SizeForm> sizeFormsFromJson = json['sizeForms'].map<SizeForm>( (f) => SizeForm.fromJson(f)).toList();
    return ShellSizeForm(
      shellSizeFormId: json['shellSizeFormId'],
      formType: json['formType'],
      userId: json['userId'],
      organizationManglarId: json['organizationManglarId'],
      sizeForms: sizeFormsFromJson,
      concheroName: json['concheroName'],
      samplingDate: json['samplingDate'],
      shellType: json['shellType'],
      shellCount: json['shellCount'],
      sectorName: json['sectorName'],
    );
  }


  // TO SAVE
  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> sizeFormsJson = sizeForms
        .map<Map<String, dynamic>>( (SizeForm f) => f.toJson() ).toList();
    Map<String, dynamic>  mapJson = {};
    mapJson['shellSizeFormId'] = shellSizeFormId;
    mapJson['formType'] = formType;
    mapJson['userId'] = userId;
    mapJson['organizationManglarId'] = organizationManglarId;
    mapJson['sizeForms'] = Utility.filterNull(sizeFormsJson);
    mapJson['concheroName'] = concheroName;
    mapJson['samplingDate'] = samplingDate;
    mapJson['shellType'] = shellType;
    mapJson['shellCount'] = shellCount;
    mapJson['sectorName'] = sectorName;
    return Utility.removeNull(mapJson);
  }

  FormConfig updateFormConfig(FormConfig formConfig){
    formConfig.getOption('concheroName').setValueInit(concheroName);
    formConfig.getOption('samplingDate').setValueInit(samplingDate);
    formConfig.getOption('shellType').setValueInit(shellType);
    formConfig.getOption('shellCount').setValueInit(shellCount);
    formConfig.getOption('sectorName').setValueInit(sectorName);
    formConfig.idForm = shellSizeFormId;

    Option baseSize = formConfig.getOption('shellSizes'); // most have optionsToAdd
    sizeForms.sort( (a, b) => a.id.compareTo(b.id) );
    sizeForms.forEach( (SizeForm form) {
      formConfig.updateOptionGroup(baseSize, form.updateOptionGroup);
    });
    return formConfig;
  }

}
