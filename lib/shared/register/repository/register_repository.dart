
import '../../../shared/register/model/cedula.dart';

import '../model/user_register.dart';
import '../repository/register_api.dart';
import '../../form/model/data.dart';

class RegisterRepository {

  final _registerApi = RegisterApi();

  Future<UserRegister> validatePin(String cedula) => _registerApi.validatePin(cedula);

  Future<List<Data>> treatments() => _registerApi.treatments();

  Future<List<Data>> nationalities() => _registerApi.nationalities();

  Future<List<Data>> locations(String parentId) => _registerApi.locations(parentId);

  Future<Data> saveUser(String data) => _registerApi.saveUser(data);

  Future<Cedula> cedula(String pin) => _registerApi.cedula(pin);

}
