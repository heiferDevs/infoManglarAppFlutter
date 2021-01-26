
import '../../model/shared/size_form.dart';
import '../../../../shared/form/model/form_config.dart';
import '../../../../shared/form/model/option.dart';
import '../../../../util/utility.dart';

class CrabSizeForm{

  int crabSizeFormId;
  int userId;
  int organizationManglarId;
  String formType;

  String cangrejeroName;
  String samplingDate;
  int crabCount;

  String sectorName;

  List<SizeForm> sizeForms;

  CrabSizeForm({
    this.crabSizeFormId,
    this.formType,
    this.userId,
    this.organizationManglarId,
    this.sizeForms,
    this.cangrejeroName,
    this.samplingDate,
    this.crabCount,
    this.sectorName,
  });

  factory CrabSizeForm.fromFormConfig(FormConfig formConfig, int userId, int organizationManglarId) {
    List<SizeForm> sizeForms = formConfig.getOptions('sizeGroup')
        .map<SizeForm>( (Option o) {
      return SizeForm.fromOption(o);
    }).toList();
    return CrabSizeForm(
      formType: formConfig.idReport,
      crabSizeFormId: formConfig.idForm,
      userId: userId,
      organizationManglarId: organizationManglarId,
      sizeForms: Utility.filterNull(sizeForms),
      cangrejeroName: formConfig.getValue('cangrejeroName'),
      samplingDate: formConfig.getValue('samplingDate'),
      sectorName: formConfig.getValue('sectorName'),
      crabCount: Utility.getInt(formConfig.getValue('crabCount')),
    );
  }

  factory CrabSizeForm.fromJson(Map<String, dynamic> json) {
    List<SizeForm> sizeFormsFromJson = json['sizeForms'].map<SizeForm>( (f) => SizeForm.fromJson(f)).toList();
    return CrabSizeForm(
      crabSizeFormId: json['crabSizeFormId'],
      formType: json['formType'],
      userId: json['userId'],
      organizationManglarId: json['organizationManglarId'],
      sizeForms: sizeFormsFromJson,
      cangrejeroName: json['cangrejeroName'],
      samplingDate: json['samplingDate'],
      crabCount: json['crabCount'],
      sectorName: json['sectorName'],
    );
  }


  // TO SAVE
  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> sizeFormsJson = sizeForms
        .map<Map<String, dynamic>>( (SizeForm f) => f.toJson() ).toList();
    Map<String, dynamic>  mapJson = {};
    mapJson['crabSizeFormId'] = crabSizeFormId;
    mapJson['formType'] = formType;
    mapJson['userId'] = userId;
    mapJson['organizationManglarId'] = organizationManglarId;
    mapJson['sizeForms'] = Utility.filterNull(sizeFormsJson);
    mapJson['cangrejeroName'] = cangrejeroName;
    mapJson['samplingDate'] = samplingDate;
    mapJson['crabCount'] = crabCount;
    mapJson['sectorName'] = sectorName;
    return Utility.removeNull(mapJson);
  }

  FormConfig updateFormConfig(FormConfig formConfig){
    formConfig.getOption('cangrejeroName').setValueInit(cangrejeroName);
    formConfig.getOption('samplingDate').setValueInit(samplingDate);
    formConfig.getOption('crabCount').setValueInit(crabCount);
    formConfig.getOption('sectorName').setValueInit(sectorName);
    formConfig.idForm = crabSizeFormId;

    Option baseSize = formConfig.getOption('crabSizes'); // most have optionsToAdd
    sizeForms.sort( (a, b) => a.id.compareTo(b.id) );
    sizeForms.forEach( (SizeForm form) {
      formConfig.updateOptionGroup(baseSize, form.updateOptionGroup);
    });
    return formConfig;
  }

}
