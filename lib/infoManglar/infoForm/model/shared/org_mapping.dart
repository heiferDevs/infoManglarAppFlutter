
import '../../../../shared/form/model/option.dart';
import '../../../../util/utility.dart';

import 'file_form.dart';

class OrgMapping {

  int id;

  int organizationId;

  String organizationName;
  String mappingDate;

  List<FileForm> fileForms;

  OrgMapping({
    this.id,
    this.organizationId,
    this.organizationName,
    this.mappingDate,
    this.fileForms,
  });

  factory OrgMapping.fromOption(Option o) {
    List<FileForm> fileForms = [
      FileForm.fromOption(o.getOptionFromOptionsGroup('fileGeoJson')),
    ];
    List<Option> optionsGroup = o.optionsToGroup;
    return OrgMapping(
      id: o.idForm,
      organizationName: o.getValueFromOptionsGroup('organizationName', optionsGroup),
      mappingDate: o.getValueFromOptionsGroup('mappingDate', optionsGroup),
      fileForms: Utility.filterNull(fileForms),
    );
  }

  factory OrgMapping.fromJson(Map<String, dynamic> json) {
    List<FileForm> fileFormsFromJson = json['fileForms'].map<FileForm>( (f) => FileForm.fromJson(f) ).toList();
    return OrgMapping(
      id: json['id'],
      organizationId: json['organizationId'],
      organizationName: json['organizationName'],
      mappingDate: json['mappingDate'],
      fileForms: fileFormsFromJson,
    );
  }

  // TO SAVE
  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> fileFormsJson = fileForms
        .map<Map<String, dynamic>>( (FileForm f) => f.toJson() ).toList();

    Map<String, dynamic>  mapJson = {};
    mapJson['id'] = id;
    mapJson['organizationId'] = organizationId;
    mapJson['organizationName'] = organizationName;
    mapJson['mappingDate'] = mappingDate;
    mapJson['fileForms'] = Utility.filterNull(fileFormsJson);
    return Utility.removeNull(mapJson);
  }

  updateOptionGroup(Option option){
    if (option.optionsToGroup == null) throw 'MOST HAVE OPTIONS TO GROUP TO ADD';
    option.idForm = id;
    option.getOptionFromOptionsGroup('organizationName').setValueInit(organizationName);
    option.getOptionFromOptionsGroup('mappingDate').setValueInit(mappingDate);
    option.getOptionFromOptionsGroup('fileGeoJson').setValueInit(Utility.getFileForm(this, 'fileGeoJson'));
  }

  isEmpty(){
    return fileForms.length == 0;
  }

}
