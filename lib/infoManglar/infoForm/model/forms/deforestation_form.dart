
import '../../../../shared/form/model/form_config.dart';
import '../../../../util/utility.dart';

class DeforestationForm{

  int deforestationFormId;
  int userId;
  int organizationManglarId;
  String formType;

  String probableCause;
  String deforestedArea;
  String custodyArea;
  String protectedArea;
  String location;
  String latlong;
  String address;
  String estuary;
  String community;

  DeforestationForm({
    this.deforestationFormId,
    this.formType,
    this.userId,
    this.organizationManglarId,
    this.probableCause,
    this.deforestedArea,
    this.custodyArea,
    this.protectedArea,
    this.location,
    this.latlong,
    this.address,
    this.estuary,
    this.community,
  });

  factory DeforestationForm.fromFormConfig(FormConfig formConfig, int userId, int organizationManglarId) {
    return DeforestationForm(
      formType: formConfig.idReport,
      deforestationFormId: formConfig.idForm,
      userId: userId,
      organizationManglarId: organizationManglarId,
      probableCause: formConfig.getValue('probableCause'),
      deforestedArea: formConfig.getValue('deforestedArea'),
      custodyArea: formConfig.getValue('custodyArea'),
      protectedArea: formConfig.getValue('protectedArea'),
      location: formConfig.getValue('location'),
      latlong: formConfig.getValue('latlong'),
      address: formConfig.getValue('address'),
      estuary: formConfig.getValue('estuary'),
      community: formConfig.getValue('community'),
    );
  }

  factory DeforestationForm.fromJson(Map<String, dynamic> json) {
    return DeforestationForm(
      deforestationFormId: json['deforestationFormId'],
      formType: json['formType'],
      userId: json['userId'],
      organizationManglarId: json['organizationManglarId'],
      probableCause: json['probableCause'],
      deforestedArea: json['deforestedArea'],
      custodyArea: json['custodyArea'],
      protectedArea: json['protectedArea'],
      location: json['location'],
      latlong: json['latlong'],
      address: json['address'],
      estuary: json['estuary'],
      community: json['community'],
    );
  }


  // TO SAVE
  Map<String, dynamic> toJson() {
    Map<String, dynamic>  mapJson = {};
    mapJson['deforestationFormId'] = deforestationFormId;
    mapJson['formType'] = formType;
    mapJson['userId'] = userId;
    mapJson['organizationManglarId'] = organizationManglarId;
    mapJson['probableCause'] = probableCause;
    mapJson['deforestedArea'] = deforestedArea;
    mapJson['custodyArea'] = custodyArea;
    mapJson['protectedArea'] = protectedArea;
    mapJson['location'] = location;
    mapJson['latlong'] = latlong;
    mapJson['address'] = address;
    mapJson['estuary'] = estuary;
    mapJson['community'] = community;
    return Utility.removeNull(mapJson);
  }

  FormConfig updateFormConfig(FormConfig formConfig){
    formConfig.getOption('probableCause').setValueInit(probableCause);
    formConfig.getOption('deforestedArea').setValueInit(deforestedArea);
    formConfig.getOption('custodyArea').setValueInit(custodyArea);
    formConfig.getOption('protectedArea').setValueInit(protectedArea);
    formConfig.getOption('location').setValueInit(location);
    formConfig.idForm = deforestationFormId;

    if (formConfig.getOption('latlong') != null)
      formConfig.getOption('latlong').setValueInit(latlong);
    if (formConfig.getOption('address') != null)
      formConfig.getOption('address').setValueInit(address);
    if (formConfig.getOption('estuary') != null)
      formConfig.getOption('estuary').setValueInit(estuary);
    if (formConfig.getOption('community') != null)
      formConfig.getOption('community').setValueInit(community);
    return formConfig;
  }

}
