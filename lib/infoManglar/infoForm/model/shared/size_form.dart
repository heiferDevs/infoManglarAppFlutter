
import '../../../../shared/form/model/option.dart';
import '../../../../util/utility.dart';

class SizeForm {

  int id;
  String type;
  String idOption;
  String sex;

  int width;
  int length;

  SizeForm({
    this.id,
    this.type,
    this.idOption,
    this.sex,
    this.width,
    this.length,
  });

  factory SizeForm.fromOption(Option o) {
    Option sexOption = o.getOptionFromOptionsGroup('sex');
    return SizeForm(
      id: o.idForm,
      type: o.typeInput,
      idOption: o.id,
      sex: sexOption == null ? null : sexOption.getValue(),
      width: o.getOptionFromOptionsGroup('width').getValue(),
      length: o.getOptionFromOptionsGroup('length').getValue(),
    );
  }

  // TO SAVE
  Map<String, dynamic> toJson() {
    if ( width == null || length == null ) return null;
    Map<String, dynamic>  mapJson = {};
    mapJson['id'] = id;
    mapJson['type'] = type;
    mapJson['idOption'] = idOption;
    mapJson['sex'] = sex;
    mapJson['width'] = width;
    mapJson['length'] = length;
    return Utility.removeNull(mapJson);
  }

  factory SizeForm.fromJson(Map<String, dynamic> json) {
    return SizeForm(
      id: json['id'],
      type: json['type'],
      idOption: json['idOption'],
      sex: json['sex'],
      width: json['width'],
      length: json['length'],
    );
  }

  updateOptionGroup(Option option){
    if (option.optionsToGroup == null) throw 'MOST HAVE OPTIONS TO GROUP TO ADD';
    option.idForm = id;
/*    option.getOptionFromOptionsGroup('type').setValueInit(type);
    option.getOptionFromOptionsGroup('idOption').setValueInit(idOption);*/
    if (option.getOptionFromOptionsGroup('sex') != null )
    option.getOptionFromOptionsGroup('sex').setValueInit(sex);
    option.getOptionFromOptionsGroup('width').setValueInit(width);
    option.getOptionFromOptionsGroup('length').setValueInit(length);
  }

}
