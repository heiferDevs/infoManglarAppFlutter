

import '../../../infoManglar/config/model/allowed_user.dart';
import '../../../infoManglar/config/model/organization_manglar.dart';
import '../../../shared/form/model/data.dart';
import '../../../util/web_client.dart';
import '../model/config_form.dart';
import 'dart:convert';

class ConfigApi {

  final WebClient _webClient = new WebClient();

  Future<List<OrganizationManglar>> getOrgs() async {
    dynamic result = await _webClient.get('rest/organization-manglar/get');
    return result.map<OrganizationManglar>( (o) => OrganizationManglar.fromJson(o) ).toList();
  }

  Future<List<Data>> getLocations() async {
    dynamic result = await _webClient.get('rest/register/locations');
    return result.map<Data>( (o) => Data.fromJson(o) ).toList();
  }

  Future<List<Data>> getOrganizations() async {
    dynamic result = await _webClient.get('rest/register/organizations');
    return result.map<Data>( (o) => Data.fromJson(o) ).toList();
  }

  Future<List<Data>> getOrganizationsByType(String userType) async {
    dynamic result = await _webClient.get('rest/register/organizations-by-type/$userType');
    return result.map<Data>( (o) => Data.fromJson(o) ).toList();
  }

  Future<List<AllowedUser>> getAllowedUsers(String userType) async {
    dynamic result = await _webClient.get('rest/allowed-user/get/$userType');
    return result.map<AllowedUser>( (o) => AllowedUser.fromJson(o) ).toList();
  }

  Future<AllowedUser> getAllowedUser(int id) async {
    dynamic result = await _webClient.get('rest/allowed-user/get-by-id/$id');
    return AllowedUser.fromJson(result);
  }

  Future<OrganizationManglar> getOrganizationManglar(int id) async {
    dynamic result = await _webClient.get('rest/organization-manglar/get-by-id/$id');
    return OrganizationManglar.fromJson(result);
  }

  Future<Data> saveOrganizationManglar(OrganizationManglar organizationManglar) async {
    String data = json.encode(organizationManglar.toJson());
    dynamic result = await _webClient.post('rest/organization-manglar/save', data);
    return Data.fromJson(result);
  }

  Future<Data> saveConfigForm(ConfigForm configForm) async {
    String data = json.encode(configForm.toJson());
    dynamic result = await _webClient.post('rest/config-form/save', data);
    return Data.fromJson(result);
  }

  Future<ConfigForm> getConfigForm() async {
    dynamic result = await _webClient.get('rest/config-form/get');
    return ConfigForm.fromJson(result);
  }

  Future<Data> saveAllowedUser(String userType, AllowedUser user, int organizationManglarId, int geloId) async {
    Map<String, dynamic> map = {
      "allowedUser": {
        "allowedUserId": user.allowedUserId,
        "allowedUserStatus": user.allowedUserStatus,
        "allowedUserName": user.allowedUserName,
        "allowedUserPin": user.allowedUserPin
      },
      "organizationManglarId": organizationManglarId,
      "geloId": geloId
    };
    String data = json.encode(map);
    dynamic result = await _webClient.post('rest/allowed-user/save/$userType', data);
    return Data.fromJson(result);
  }

  Future<Data> removeAllowedUser(int allowedUserId) async {
    Map<String, dynamic> map = {
      "id": allowedUserId,
    };
    String data = json.encode(map);
    dynamic result = await _webClient.post('rest/allowed-user/remove', data);
    return Data.fromJson(result);
  }

  Future<Data> removeOrganizationManglar(int organizationManglarId) async {
    Map<String, dynamic> map = {
      "id": organizationManglarId,
    };
    String data = json.encode(map);
    dynamic result = await _webClient.post('rest/organization-manglar/remove', data);
    return Data.fromJson(result);
  }

}
