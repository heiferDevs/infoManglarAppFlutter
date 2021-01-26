import '../../infoForm/controller/input_api.dart';

import '../model/drawer_config.dart';
import '../../../shared/form/model/form_config.dart';

import '../model/drawer_option.dart';
import '../../../util/user.dart';
import '../../../util/utility.dart';
import '../../../shared/formMenu/model/form_menu.dart';

class DrawerApi {

  final InputApi inputApi = new InputApi();

  Future<DrawerConfig> getDrawerConfig() async {
    print('LOAD DRAWER');
    String pathUsers = User.getUserConfig();
    dynamic configUser = await Utility.loadConfig(pathUsers);
    bool hasForms = User.role == 'socio' || User.role == 'org' || User.role == 'mae' || User.role == 'inp';
    dynamic configForms;
    if (hasForms) {
      Map<String, dynamic> config = await Utility.loadConfigForms(User.role);
      configForms = await inputApi.updateApiInputs(config);
    }
    List<DrawerOption> options = _listDrawerOptions(configUser['nav-options'], configForms);
    return DrawerConfig(options: options);
  }

  List<DrawerOption> _listDrawerOptions(List<dynamic> listConfig, dynamic configForms){
    return listConfig.map<DrawerOption>( (dynamic option) {
      return _drawerOption(option, configForms);
    }).toList();
  }

  DrawerOption _drawerOption(dynamic option, dynamic configForms){
    DrawerOption drawerOption = DrawerOption(
      id: option['id'],
      title: option['title'],
      type: option['type'],
      image: option['image'],
    );
    if (option['sub-options'] != null){
      drawerOption.subOptions = _listDrawerOptions(option['sub-options'], configForms);
    }
    if (option['forms'] != null){
      drawerOption.formMenu = _formMenu(option, configForms);
    }
    return drawerOption;
  }

  FormMenu _formMenu(dynamic option, dynamic configForms){
    List<FormConfig> forms = (option['forms'] ?? []).map<FormConfig>( (formId) {
      return FormConfig.fromJson(configForms[formId]);
    }).toList();
    FormMenu formMenu = FormMenu(
      id: option['id'] ?? 'no_id',
      title: option['title'] ?? 'no_title',
      subTitle: option['subTitle'] ?? '',
      type: option['type'] ?? 'no_type',
      forms: forms,
    );
    return formMenu;
  }

}
