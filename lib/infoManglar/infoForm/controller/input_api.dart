
import '../../../infoManglar/config/repository/config_repository.dart';
import '../repository/info_form_repository.dart';
import '../../../shared/form/model/data.dart';
import '../../../util/user.dart';

import '../../../util/utility.dart';
import 'dart:convert';

class InputApi {

  final InfoFormRepository infoFormRepository = InfoFormRepository();
  final _configRepository = ConfigRepository();

  Future<Map<String, dynamic>> updateApiInputs(Map<String, dynamic> configForms) async {
    for ( String key in configForms.keys ) {
      List<String> errors = [];
      String config = json.encode(configForms[key]);
      String newConfig = await _applyChanges(config, errors);
      configForms[key] = json.decode(newConfig);
      if (errors.length > 0) {
        configForms[key]['error'] = errors.join(', ');
      }
    }
    return configForms;
  }

  Future<String> _applyChanges(String config, List<String> errors) async {
    config = await _applySectors(config, errors);
    config = await _applyActivities(config, errors);
    config = await _applyOrganizations(config, errors);
    return config;
  }

  Future<String> _applySectors(String config, List<String> errors) async {
    int orgId = Utility.getInt(User.organizationManglarId);
    String pattern = '\"OPTIONS_SECTORS_API\"';
    if ( config.contains(pattern) ) {
      List<String> options = await getOptions('sectors$orgId', () async {
        return await infoFormRepository.sectorsFromApi(orgId);
      });
      if (options.length == 0) {
        errors.add('Su organización aún no tiene configurado los sectores necesarios para este formulario');
      }
      config = config.replaceAll(pattern, json.encode(options));
    }
    return config;
  }

  Future<String> _applyActivities(String config, List<String> errors) async {
    int orgId = Utility.getInt(User.organizationManglarId);
    String pattern = '\"OPTIONS_ACTIVITIES_API\"';
    if ( config.contains(pattern) ) {
      List<String> options = await getOptions('activities$orgId', () async {
        return await infoFormRepository.activitiesFromApi(orgId);
      });
      print('activities added $options');
      if (options.length == 0) {
        errors.add('Su organización aún no tiene configurado las actividades del plan de manejo necesarias para este formulario');
      }
      config = config.replaceAll(pattern, json.encode(options));
    }
    return config;
  }

  Future<String> _applyOrganizations(String config, List<String> errors) async {
    String pattern = '\"OPTIONS_ORGS_API\"';
    if ( config.contains(pattern) ) {
      List<String> options = await getOptions('organizations', () async {
        List<Data> _orgs = await _configRepository.getOrganizationsByType("org");
        return _orgs.map<String>( (Data d) => d.state ).toList();
      });
      if (options.length == 0) {
        errors.add('ERROR, no se obtuvo la lista de organizaciones');
      }
      config = config.replaceAll(pattern, json.encode(options));
    }
    return config;
  }

  Future<List<String>> getOptions(String localKey, getData) async {
    List<String> list = [];
    if (User.hasInternetConnection) {
      list = await getData();
      Utility.setLocalStorage(localKey, json.encode(list));
    }
    else {
      String result = await Utility.getLocalStorage(localKey);
      if (result != null) list = json.decode(result).cast<String>();
    }
    return list;
  }

}
