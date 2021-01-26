
import '../model/config_form.dart';

import '../../../infoManglar/config/model/allowed_user.dart';
import '../../../infoManglar/config/model/organization_manglar.dart';
import '../../../shared/form/model/data.dart';

import 'config_api.dart';

class ConfigRepository {

  final _configApi = ConfigApi();

  Future<List<OrganizationManglar>> getOrgs() => _configApi.getOrgs();

  Future<List<Data>> getLocations() => _configApi.getLocations();


  // ORGANIZATION MANGLAR
  Future<List<Data>> getOrganizationsByType(String userType) => _configApi.getOrganizationsByType(userType);
  Future<OrganizationManglar> getOrganizationManglar(int id) => _configApi.getOrganizationManglar(id);
  Future<Data> saveOrganizationManglar(OrganizationManglar organizationManglar) =>
      _configApi.saveOrganizationManglar(organizationManglar);
  Future<Data> removeOrganizationManglar(int organizationManglarId) => _configApi.removeOrganizationManglar(organizationManglarId);

  // ALLOWED USER
  Future<List<AllowedUser>> getAllowedUsers(String userType) => _configApi.getAllowedUsers(userType);
  Future<AllowedUser> getAllowedUser(int id) => _configApi.getAllowedUser(id);
  Future<Data> saveAllowedUser(String userType, AllowedUser user, int organizationManglarId, int geloId) =>
      _configApi.saveAllowedUser(userType, user, organizationManglarId, geloId);
  Future<Data> removeAllowedUser(int allowedUserId) => _configApi.removeAllowedUser(allowedUserId);

  // CONFIG
  Future<Data> saveConfigForm(ConfigForm configForm) => _configApi.saveConfigForm(configForm);
  Future<ConfigForm> getConfigForm() => _configApi.getConfigForm();

}
