
import '../../../../shared/form/model/form_config.dart';
import '../../../../shared/form/model/option.dart';
import '../../../../util/utility.dart';

class ReforestationForm{

  int reforestationFormId;
  int userId;
  int organizationManglarId;
  String formType;

  double reforestedArea;
  int mangleSembradoCount;
  String plantingDate;
  String plantingState;
  double averageState;

  List<String> entities;
  List<String> vertices;

  ReforestationForm({
    this.reforestationFormId,
    this.formType,
    this.userId,
    this.organizationManglarId,
    this.reforestedArea,
    this.mangleSembradoCount,
    this.plantingDate,
    this.plantingState,
    this.averageState,
    this.entities,
    this.vertices,
  });

  factory ReforestationForm.fromFormConfig(FormConfig formConfig, int userId, int organizationManglarId) {
    List<String> entities = formConfig.getOptions('entityName')
        .map((Option o) => o.getValue()).toList().cast<String>();
    List<String> vertices = formConfig.getOptions('vertice')
        .map((Option o) => o.getValue()).toList().cast<String>();

    print('revisa int ini ${formConfig.getValue('reforestedArea')} final: ${Utility.getInt(formConfig.getValue('reforestedArea'))}');
    return ReforestationForm(
      formType: formConfig.idReport,
      reforestationFormId: formConfig.idForm,
      userId: userId,
      organizationManglarId: organizationManglarId,
      reforestedArea: formConfig.getValue('reforestedArea'),
      mangleSembradoCount: formConfig.getValue('mangleSembradoCount'),
      plantingDate: formConfig.getValue('plantingDate'),
      plantingState: formConfig.getValue('plantingState'),
      averageState: formConfig.getValue('averageState'),
      entities: Utility.filterNull(entities),
      vertices: Utility.filterNull(vertices),
    );
  }

  factory ReforestationForm.fromJson(Map<String, dynamic> json) {
    return ReforestationForm(
      reforestationFormId: json['reforestationFormId'],
      formType: json['formType'],
      userId: json['userId'],
      organizationManglarId: json['organizationManglarId'],
      reforestedArea: json['reforestedArea'],
      mangleSembradoCount: json['mangleSembradoCount'],
      plantingDate: json['plantingDate'],
      plantingState: json['plantingState'],
      averageState: json['averageState'],
      entities: json['entities'].cast<String>(),
      vertices: json['vertices'].cast<String>(),
    );
  }


  // TO SAVE
  Map<String, dynamic> toJson() {
    Map<String, dynamic>  mapJson = {};
    mapJson['reforestationFormId'] = reforestationFormId;
    mapJson['formType'] = formType;
    mapJson['userId'] = userId;
    mapJson['organizationManglarId'] = organizationManglarId;
    mapJson['reforestedArea'] = reforestedArea;
    mapJson['mangleSembradoCount'] = mangleSembradoCount;
    mapJson['plantingDate'] = plantingDate;
    mapJson['plantingState'] = plantingState;
    mapJson['averageState'] = averageState;
    mapJson['entities'] = entities;
    mapJson['vertices'] = vertices;
    return Utility.removeNull(mapJson);
  }

  FormConfig updateFormConfig(FormConfig formConfig){
    formConfig.getOption('reforestedArea').setValueInit(reforestedArea);
    formConfig.getOption('mangleSembradoCount').setValueInit(mangleSembradoCount);
    formConfig.getOption('plantingDate').setValueInit(plantingDate);
    formConfig.getOption('plantingState').setValueInit(plantingState);
    formConfig.idForm = reforestationFormId;

    if (formConfig.getOption('averageState') != null)
      formConfig.getOption('averageState').setValueInit(averageState);
    Option baseEntities = formConfig.getOption('entities'); // most have optionsToAdd
    entities.forEach( (String entity) {
      formConfig.updateOptionGroup(baseEntities, (Option oGroup) {
        oGroup.setValueInit(entity);
      });
    });
    Option baseVertices = formConfig.getOption('vertices'); // most have optionsToAdd
    vertices.forEach( (String vertice) {
      formConfig.updateOptionGroup(baseVertices, (Option oGroup) {
        oGroup.setValueInit(vertice);
      });
    });
    return formConfig;
  }

}
