
import '../../../../shared/form/model/option.dart';
import '../../../../util/utility.dart';
import 'file_form.dart';

class Agreement {

  int id;
  String agreementType;
  String startAgreementDate;
  String endAgreementDate;

  List<FileForm> fileForms;

  Agreement({
    this.id,
    this.agreementType,
    this.fileForms,
    this.startAgreementDate,
    this.endAgreementDate,
  });

  factory Agreement.fromOption(Option o) {
    List<FileForm> fileForms = [
      FileForm.fromOption(o.getOptionFromOptionsGroup('agreement')),
    ];
    List<Option> optionsGroup = o.optionsToGroup;
    return Agreement(
      id: o.idForm,
      agreementType: o.getValueFromOptionsGroup('agreementType', optionsGroup),
      startAgreementDate: o.getValueFromOptionsGroup('startAgreementDate', optionsGroup),
      endAgreementDate: o.getValueFromOptionsGroup('endAgreementDate', optionsGroup),
      fileForms: Utility.filterNull(fileForms),
    );
  }

  factory Agreement.fromJson(Map<String, dynamic> json) {
    List<FileForm> fileFormsFromJson = json['fileForms'].map<FileForm>( (f) => FileForm.fromJson(f) ).toList();
    return Agreement(
      id: json['id'],
      agreementType: json['agreementType'],
      startAgreementDate: json['startAgreementDate'],
      endAgreementDate: json['endAgreementDate'],
      fileForms: fileFormsFromJson,
    );
  }

  // TO SAVE
  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> fileFormsJson = fileForms
        .map<Map<String, dynamic>>( (FileForm f) => f.toJson() ).toList();
    Map<String, dynamic>  mapJson = {};
    mapJson['id'] = id;
    mapJson['agreementType'] = agreementType;
    mapJson['startAgreementDate'] = startAgreementDate;
    mapJson['endAgreementDate'] = endAgreementDate;
    mapJson['fileForms'] = Utility.filterNull(fileFormsJson);
    return Utility.removeNull(mapJson);
  }

  isEmpty(){
    return fileForms == null || fileForms.length == 0;
  }

  updateOptionGroup(Option option){
    if (option.optionsToGroup == null) throw 'MOST HAVE OPTIONS TO GROUP TO ADD';
    option.idForm = id;
    option.getOptionFromOptionsGroup('agreementType').setValueInit(agreementType);
    option.getOptionFromOptionsGroup('startAgreementDate').setValueInit(startAgreementDate);
    option.getOptionFromOptionsGroup('endAgreementDate').setValueInit(endAgreementDate);
    option.getOptionFromOptionsGroup('agreement').setValueInit(Utility.getFileForm(this, 'agreement'));
  }

}
