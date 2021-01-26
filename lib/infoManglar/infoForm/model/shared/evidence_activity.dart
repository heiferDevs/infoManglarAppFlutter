
import '../../../../shared/form/model/option.dart';
import '../../../../util/utility.dart';
import 'file_form.dart';

class EvidenceActivity {

  int id;
  String evidenceType;

  List<FileForm> fileForms;

  EvidenceActivity({
    this.id,
    this.evidenceType,
    this.fileForms,
  });

  factory EvidenceActivity.fromOption(Option o) {
    List<FileForm> fileForms = [
      FileForm.fromOption(o.getOptionFromOptionsGroup('evidenceDoc')),
    ];
    List<Option> optionsGroup = o.optionsToGroup;
    return EvidenceActivity(
      id: o.idForm,
      evidenceType: o.getValueFromOptionsGroup('evidenceType', optionsGroup),
      fileForms: Utility.filterNull(fileForms),
    );
  }

  factory EvidenceActivity.fromJson(Map<String, dynamic> json) {
    List<FileForm> fileFormsFromJson = json['fileForms'].map<FileForm>( (f) => FileForm.fromJson(f) ).toList();
    return EvidenceActivity(
      id: json['id'],
      evidenceType: json['evidenceType'],
      fileForms: fileFormsFromJson,
    );
  }

  // TO SAVE
  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> fileFormsJson = fileForms
        .map<Map<String, dynamic>>( (FileForm f) => f.toJson() ).toList();
    Map<String, dynamic>  mapJson = {};
    mapJson['id'] = id;
    mapJson['evidenceType'] = evidenceType;
    mapJson['fileForms'] = fileFormsJson;
    return Utility.removeNull(mapJson);
  }

  isEmpty(){
    return fileForms.length == 0;
  }

  updateOptionGroup(Option option){
    if (option.optionsToGroup == null) throw 'MOST HAVE OPTIONS TO GROUP TO ADD';
    option.idForm = id;
    option.getOptionFromOptionsGroup('evidenceType').setValueInit(evidenceType);
    option.getOptionFromOptionsGroup('evidenceDoc').setValueInit(Utility.getFileForm(this, 'evidenceDoc'));
  }
}
