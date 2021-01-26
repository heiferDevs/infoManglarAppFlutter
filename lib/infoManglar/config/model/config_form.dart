
import '../../../shared/form/model/form_config.dart';
import '../../../util/utility.dart';

class ConfigForm{

  int configFormId;
  String version;

  ConfigForm({
    this.configFormId,
    this.version,
  });

  factory ConfigForm.fromFormConfig(FormConfig formConfig) {
    return ConfigForm(
      configFormId: formConfig.idForm,
      version: formConfig.idReport,
    );
  }

  factory ConfigForm.fromJson(Map<String, dynamic> json) {
    return ConfigForm(
      configFormId: json['configFormId'],
      version: json['version'],
    );
  }

  // TO SAVE
  Map<String, dynamic> toJson() {
    Map<String, dynamic>  mapJson = {};
    mapJson['configFormId'] = configFormId;
    mapJson['version'] = version;
    return Utility.removeNull(mapJson);
  }

}
