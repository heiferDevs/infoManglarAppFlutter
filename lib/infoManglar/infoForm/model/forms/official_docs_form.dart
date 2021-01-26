
import '../../model/shared/agreement.dart';
import '../../../../shared/form/model/option.dart';
import '../../../../shared/form/model/form_config.dart';
import '../../../../util/utility.dart';

import '../shared/file_form.dart';

class OfficialDocsForm{

  int officialDocsFormId;
  int userId;
  int organizationManglarId;
  String formType;


  // Organization
  String organizationName;
  String organizationLocation;
  String summary;
  String organizationType;

  double custodyArea;
  int yearCreation;
  String sepsRegister;

  List<FileForm> fileForms;

  // Dates
  String partnersListDate;
  String internalRegulationDate;
  String directorsRegisterDate;

  // Contact
  String presidentName;
  String pin;
  String phone;
  String email;

  List<Agreement> agreements;

  OfficialDocsForm({
    this.officialDocsFormId,
    this.formType,
    this.userId,
    this.organizationManglarId,
    this.fileForms,
    this.organizationName,
    this.organizationLocation,
    this.summary,
    this.organizationType,
    this.custodyArea,
    this.yearCreation,
    this.sepsRegister,
    this.presidentName,
    this.pin,
    this.phone,
    this.email,
    this.partnersListDate,
    this.internalRegulationDate,
    this.directorsRegisterDate,
    this.agreements,
  });

  factory OfficialDocsForm.fromFormConfig(FormConfig formConfig, int userId, int organizationManglarId) {
    List<Agreement> agreements = formConfig.getOptions('agreementInfo')
        .map<Agreement>( (Option o) {
      return Agreement.fromOption(o);
    }).toList();
    List<FileForm> fileForms = [
      FileForm.fromOption(formConfig.getOption('useCustodyAgreement')),
      FileForm.fromOption(formConfig.getOption('organizationStatutes')),
      FileForm.fromOption(formConfig.getOption('internalRegulation')),
      FileForm.fromOption(formConfig.getOption('managementPlan')),
      FileForm.fromOption(formConfig.getOption('organizationLogo')),
      FileForm.fromOption(formConfig.getOption('directorsRegister')),
      FileForm.fromOption(formConfig.getOption('legalExistence')),
      FileForm.fromOption(formConfig.getOption('partnersDirectorsList')),
    ];
    return OfficialDocsForm(
      formType: formConfig.idReport,
      officialDocsFormId: formConfig.idForm,
      userId: userId,
      organizationManglarId: organizationManglarId,
      fileForms: Utility.filterNull(fileForms),
      organizationName: formConfig.getValue('organizationName'),
      organizationLocation: formConfig.getValue('organizationLocation'),
      summary: formConfig.getValue('summary'),
      organizationType: formConfig.getValue('organizationType'),
      custodyArea: formConfig.getValue('custodyArea'),
      yearCreation: formConfig.getValue('yearCreation'),
      sepsRegister: formConfig.getValue('sepsRegister'),
      presidentName: formConfig.getValue('presidentName'),
      pin: formConfig.getValue('pin'),
      phone: formConfig.getValue('phone'),
      email: formConfig.getValue('email'),
      partnersListDate: formConfig.getValue('partnersListDate'),
      internalRegulationDate: formConfig.getValue('internalRegulationDate'),
      directorsRegisterDate: formConfig.getValue('directorsRegisterDate'),
      agreements: agreements,
    );
  }

  factory OfficialDocsForm.fromJson(Map<String, dynamic> json) {
    List<FileForm> fileFormsFromJson = json['fileForms'].map<FileForm>( (f) => FileForm.fromJson(f) ).toList();
    List<Agreement> agreementsJson = json['agreements'].map<Agreement>( (f) => Agreement.fromJson(f) ).toList();
    return OfficialDocsForm(
      officialDocsFormId: json['officialDocsFormId'],
      formType: json['formType'],
      userId: json['userId'],
      organizationManglarId: json['organizationManglarId'],
      fileForms: fileFormsFromJson,
      organizationName: json['organizationName'],
      organizationLocation: json['organizationLocation'],
      summary: json['summary'],
      organizationType: json['organizationType'],
      custodyArea: json['custodyArea'],
      yearCreation: json['yearCreation'],
      sepsRegister: json['sepsRegister'],
      presidentName: json['presidentName'],
      pin: json['pin'],
      phone: json['phone'],
      email: json['email'],
      partnersListDate: json['partnersListDate'],
      internalRegulationDate: json['internalRegulationDate'],
      directorsRegisterDate: json['directorsRegisterDate'],
      agreements: agreementsJson,
    );
  }

  // TO SAVE
  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> agreementJson = agreements
        .where((Agreement document) => !document.isEmpty() ).toList()
        .map<Map<String, dynamic>>( (Agreement document) => document.toJson() )
        .toList();
    List<Map<String, dynamic>> fileFormsJson = fileForms
      .map<Map<String, dynamic>>( (FileForm f) => f.toJson() ).toList();
    Map<String, dynamic>  mapJson = {};
    mapJson['officialDocsFormId'] = officialDocsFormId;
    mapJson['formType'] = formType;
    mapJson['userId'] = userId;
    mapJson['organizationManglarId'] = organizationManglarId;
    mapJson['fileForms'] = Utility.filterNull(fileFormsJson);
    mapJson['organizationName'] = organizationName;
    mapJson['organizationLocation'] = organizationLocation;
    mapJson['summary'] = Utility.maxChars(summary, 500);
    mapJson['organizationType'] = organizationType;
    mapJson['custodyArea'] = custodyArea;
    mapJson['yearCreation'] = yearCreation;
    mapJson['sepsRegister'] = sepsRegister;
    mapJson['presidentName'] = presidentName;
    mapJson['pin'] = pin;
    mapJson['phone'] = phone;
    mapJson['email'] = email;
    mapJson['partnersListDate'] = partnersListDate;
    mapJson['internalRegulationDate'] = internalRegulationDate;
    mapJson['directorsRegisterDate'] = directorsRegisterDate;
    mapJson['agreements'] = Utility.filterNull(agreementJson);
    return Utility.removeNull(mapJson);
  }

  FormConfig updateFormConfig(FormConfig formConfig){
    formConfig.getOption('organizationName').setValueInit(organizationName);
    formConfig.getOption('organizationLocation').setValueInit(organizationLocation);
    formConfig.getOption('summary').setValueInit(summary);
    formConfig.getOption('organizationType').setValueInit(organizationType);
    formConfig.getOption('custodyArea').setValueInit(custodyArea);
    formConfig.getOption('yearCreation').setValueInit(yearCreation);
    formConfig.getOption('sepsRegister').setValueInit(sepsRegister);
    formConfig.getOption('presidentName').setValueInit(presidentName);
    formConfig.getOption('pin').setValueInit(pin);
    formConfig.getOption('phone').setValueInit(phone);
    formConfig.getOption('email').setValueInit(email);
    formConfig.getOption('partnersListDate').setValueInit(partnersListDate);
    formConfig.getOption('internalRegulationDate').setValueInit(internalRegulationDate);
    formConfig.getOption('directorsRegisterDate').setValueInit(directorsRegisterDate);
    formConfig.idForm = officialDocsFormId;

    // Fill files
    fileForms.forEach( (FileForm fileForm) {
      formConfig.getOption(fileForm.idOption).setValueInit(fileForm);
    });

    Option baseSize = formConfig.getOption('agreements'); // most have optionsToAdd
    agreements.sort( (a, b) => a.id.compareTo(b.id) );
    agreements.forEach( (Agreement form) {
      formConfig.updateOptionGroup(baseSize, form.updateOptionGroup);
    });
    return formConfig;
  }

}
