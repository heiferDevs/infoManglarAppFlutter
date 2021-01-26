
import '../../../../shared/form/model/option.dart';
import '../../../../util/utility.dart';
import 'file_form.dart';

class DocumentProject {

  int id;
  String supportType;
  List<FileForm> fileForms;

  DocumentProject({
    this.id,
    this.supportType,
    this.fileForms,
  });

  factory DocumentProject.fromOption(Option o) {
    List<FileForm> fileForms = [
      FileForm.fromOption(o.getOptionFromOptionsGroup('document')),
    ];
    List<Option> optionsGroup = o.optionsToGroup;
    return DocumentProject(
      id: o.idForm,
      supportType: o.getValueFromOptionsGroup('supportType', optionsGroup),
      fileForms: Utility.filterNull(fileForms),
    );
  }

  factory DocumentProject.fromJson(Map<String, dynamic> json) {
    List<FileForm> fileFormsFromJson = json['fileForms'].map<FileForm>( (f) => FileForm.fromJson(f) ).toList();
    return DocumentProject(
      id: json['id'],
      supportType: json['supportType'],
      fileForms: fileFormsFromJson,
    );
  }

  // TO SAVE
  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> fileFormsJson = fileForms
        .map<Map<String, dynamic>>( (FileForm f) => f.toJson() ).toList();
    Map<String, dynamic>  mapJson = {};
    mapJson['id'] = id;
    mapJson['supportType'] = supportType;
    mapJson['fileForms'] = Utility.filterNull(fileFormsJson);
    return Utility.removeNull(mapJson);
  }

  isEmpty(){
    return fileForms == null || fileForms.length == 0;
  }

  updateOptionGroup(Option option){
    if (option.optionsToGroup == null) throw 'MOST HAVE OPTIONS TO GROUP TO ADD';
    option.idForm = id;
    option.getOptionFromOptionsGroup('supportType').setValueInit(supportType);
    option.getOptionFromOptionsGroup('document').setValueInit(Utility.getFileForm(this, 'document'));
  }

}
