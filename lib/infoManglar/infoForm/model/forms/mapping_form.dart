
import '../../model/shared/org_mapping.dart';
import '../../../../shared/form/model/form_config.dart';
import '../../../../shared/form/model/option.dart';
import '../../../../util/utility.dart';

class MappingForm{

  int mappingFormId;
  int userId;
  int organizationManglarId;
  String formType;

  List<OrgMapping> orgsMapping;

  MappingForm({
    this.mappingFormId,
    this.formType,
    this.userId,
    this.organizationManglarId,
    this.orgsMapping,
  });

  factory MappingForm.fromFormConfig(FormConfig formConfig, int userId, int organizationManglarId) {
    List<OrgMapping> orgsMapping = formConfig.getOptions('organizationGeoJson')
        .map<OrgMapping>( (Option o) {
      return OrgMapping.fromOption(o);
    }).toList();
    return MappingForm(
      formType: formConfig.idReport,
      mappingFormId: formConfig.idForm,
      userId: userId,
      organizationManglarId: organizationManglarId,
      orgsMapping: orgsMapping,
    );
  }

  factory MappingForm.fromJson(Map<String, dynamic> json) {
    List<OrgMapping> orgsMappingJson = json['orgsMapping'].map<OrgMapping>( (f) => OrgMapping.fromJson(f) ).toList();
    return MappingForm(
      mappingFormId: json['mappingFormId'],
      formType: json['formType'],
      userId: json['userId'],
      organizationManglarId: json['organizationManglarId'],
      orgsMapping: orgsMappingJson,
    );
  }

  // TO SAVE
  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> orgsMappingJson = orgsMapping
        .where((OrgMapping priceDaily) => !priceDaily.isEmpty() ).toList()
        .map<Map<String, dynamic>>( (OrgMapping priceDaily) => priceDaily.toJson() )
        .toList();
    Map<String, dynamic>  mapJson = {};
    mapJson['mappingFormId'] = mappingFormId;
    mapJson['formType'] = formType;
    mapJson['userId'] = userId;
    mapJson['organizationManglarId'] = organizationManglarId;
    mapJson['orgsMapping'] = Utility.filterNull(orgsMappingJson);
    return Utility.removeNull(mapJson);
  }

  FormConfig updateFormConfig(FormConfig formConfig){
    formConfig.removeOptionsCreatedByUser();
    formConfig.idForm = mappingFormId;

    Option base = formConfig.getOption('organizationsGeoJson'); // most have optionsToAdd
    orgsMapping.sort( (a, b) => a.id.compareTo(b.id) );
    orgsMapping.forEach( (OrgMapping f) {
      formConfig.updateOptionGroup(base, f.updateOptionGroup);
    });
    return formConfig;
  }

}
