
import '../../model/shared/document_project.dart';
import '../../../../shared/form/model/form_config.dart';
import '../../../../shared/form/model/option.dart';
import '../../../../util/utility.dart';

class DescProjectsForm{

  int descProjectsFormId;
  int userId;
  int organizationManglarId;
  String formType;

  String projectType;
  String projectName;
  String projectObjective;
  String institutionType;
  String institutionsName;

  double budget;

  List<DocumentProject> documentProjects;

  DescProjectsForm({
    this.descProjectsFormId,
    this.formType,
    this.userId,
    this.organizationManglarId,
    this.projectType,
    this.projectName,
    this.projectObjective,
    this.institutionType,
    this.budget,
    this.institutionsName,
    this.documentProjects,
  });

  factory DescProjectsForm.fromFormConfig(FormConfig formConfig, int userId, int organizationManglarId) {
    List<DocumentProject> documentProjects = formConfig.getOptions('documentInfo')
      .map<DocumentProject>( (Option o) {
        print('will call with option id ${o.id}');
        return DocumentProject.fromOption(o);
    }).toList();
    return DescProjectsForm(
      formType: formConfig.idReport,
      descProjectsFormId: formConfig.idForm,
      userId: userId,
      organizationManglarId: organizationManglarId,
      documentProjects: documentProjects,
      projectType: formConfig.getValue('projectType'),
      projectName: formConfig.getValue('projectName'),
      projectObjective: formConfig.getValue('projectObjective'),
      institutionType: formConfig.getValue('institutionType'),
      budget: Utility.getDouble(formConfig.getValue('budget')),
      institutionsName: formConfig.getValue('institutionsName'),
    );
  }

  factory DescProjectsForm.fromJson(Map<String, dynamic> json) {
    List<DocumentProject> documentProjectsJson = json['documentProjects'].map<DocumentProject>( (f) => DocumentProject.fromJson(f) ).toList();
    return DescProjectsForm(
      descProjectsFormId: json['descProjectsFormId'],
      userId: json['userId'],
      organizationManglarId: json['organizationManglarId'],
      formType: json['formType'],
      projectType: json['projectType'],
      projectName: json['projectName'],
      projectObjective: json['projectObjective'],
      institutionType: json['institutionType'],
      institutionsName: json['institutionsName'],
      budget: json['budget'],
      documentProjects: documentProjectsJson,
    );
  }

  // TO SAVE
  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> documentProjectJson = documentProjects
        .where((DocumentProject document) => !document.isEmpty() ).toList()
        .map<Map<String, dynamic>>( (DocumentProject document) => document.toJson() )
        .toList();
    Map<String, dynamic>  mapJson = {};
    mapJson['descProjectsFormId'] = descProjectsFormId;
    mapJson['formType'] = formType;
    mapJson['userId'] = userId;
    mapJson['organizationManglarId'] = organizationManglarId;
    mapJson['documentProjects'] = Utility.filterNull(documentProjectJson);
    mapJson['projectType'] = projectType;
    mapJson['projectName'] = projectName;
    mapJson['projectObjective'] = projectObjective;
    mapJson['institutionType'] = institutionType;
    mapJson['budget'] = budget;
    mapJson['institutionsName'] = institutionsName;
    return Utility.removeNull(mapJson);
  }


  FormConfig updateFormConfig(FormConfig formConfig){
    formConfig.getOption('projectType').setValueInit(projectType);
    if (formConfig.getOption('projectName') != null)
      formConfig.getOption('projectName').setValueInit(projectName);
    if (formConfig.getOption('projectObjective') != null)
      formConfig.getOption('projectObjective').setValueInit(projectObjective);
    formConfig.getOption('institutionType').setValueInit(institutionType);
    formConfig.getOption('institutionsName').setValueInit(institutionsName);
    formConfig.getOption('budget').setValueInit(budget);
    formConfig.idForm = descProjectsFormId;

    Option baseSize = formConfig.getOption('documents'); // most have optionsToAdd
    documentProjects.sort( (a, b) => a.id.compareTo(b.id) );
    documentProjects.forEach( (DocumentProject form) {
      formConfig.updateOptionGroup(baseSize, form.updateOptionGroup);
    });
    return formConfig;
  }

}
