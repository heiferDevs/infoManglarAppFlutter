import '../../../shared/register/model/cedula.dart';

import '../../../util/web_client.dart';
import '../../form/model/data.dart';
import '../model/user_register.dart';

class RegisterApi {

  final WebClient _webClient = new WebClient();

  Future<UserRegister> validatePin(String data) async {
    dynamic result = await _webClient.post('rest/validate-pin', data);
    return UserRegister.fromJson(result);
  }

  Future<List<Data>> treatments() async {
    dynamic result = await _webClient.get('rest/register/treatments');
    return result.map<Data>( (o) => Data.fromJson(o) ).toList();
  }

  Future<List<Data>> nationalities() async {
    dynamic result = await _webClient.get('rest/register/nationalities');
    return result.map<Data>( (o) => Data.fromJson(o) ).toList();
  }

  Future<List<Data>> locations(String parentId) async {
    dynamic result = await _webClient.get('rest/register/locations?parentId=' + parentId);
    return result.map<Data>( (o) => Data.fromJson(o) ).toList();
  }

  Future<Data> saveUser(String data) async {
    dynamic result = await _webClient.post('rest/register/save', data);
    return Data.fromJson(result);
  }

  Future<Cedula> cedula(String pin) async {
    dynamic result = await _webClient.get('rest/register/pin/$pin');
    return Cedula.fromJson(result);
  }

}
