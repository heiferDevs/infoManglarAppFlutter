
import '../../../../plugins/fileExport.dart';
import '../../../../plugins/file_picker.dart';
import '../../../../shared/form/model/option.dart';
import '../../../../util/utility.dart';

class FileForm {

  int id;
  String name;
  String type;
  String url;
  String idOption;
  String alfrescoCode;

  String pathOrigin; // Not saved on db
  String base64; // Not saved on db

  FileForm({
    this.id,
    this.name,
    this.type,
    this.url,
    this.idOption,
    this.alfrescoCode,
    this.pathOrigin,
    this.base64,
  });

  factory FileForm.fromOption(Option o) {
    if (o == null || !o.hasValue()) return null;
    String name = Utility.fixName(o.getValue());
    String url = FilePickerApp.getUrl(o.typeInput, name);
    return FileForm(
      id: o.idForm,
      name: name,
      type: o.typeInput,
      url: url,
      idOption: o.id,
      alfrescoCode: 'alfresco',
      pathOrigin: o.pathImageVideo,
      base64: o.fileExport != null ? o.fileExport.base64 : null,
    );
  }

  factory FileForm.fromFileExport(FileExport fileExport, String idOption) {
    if (fileExport == null) return null;
    String name = Utility.fixName(Utility.getNameFileFromOptionId(idOption, fileExport.name));
    String url = FilePickerApp.getUrl(fileExport.type, name);
    return FileForm(
      id: null,
      name: name,
      type: fileExport.type,
      url: url,
      idOption: idOption,
      alfrescoCode: 'alfresco',
      pathOrigin: fileExport.path,
      base64: fileExport != null ? fileExport.base64 : null,
    );
  }

  // TO SAVE
  Map<String, dynamic> toJson() {
    if ( name == Option.NO_VALUE ) return null;
    Map<String, dynamic>  mapJson = {};
    mapJson['id'] = id;
    mapJson['name'] = name;
    mapJson['type'] = type;
    mapJson['url'] = url;
    mapJson['idOption'] = idOption;
    mapJson['pathOrigin'] = pathOrigin;
    mapJson['alfrescoCode'] = alfrescoCode;
    return Utility.removeNull(mapJson);
  }

  factory FileForm.fromJson(Map<String, dynamic> json) {
    return FileForm(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      url: json['url'],
      idOption: json['idOption'],
      pathOrigin: json['pathOrigin'],
      alfrescoCode: json['alfrescoCode'],
    );
  }

  bool isEmpty(){
    return name == null;
  }

}
