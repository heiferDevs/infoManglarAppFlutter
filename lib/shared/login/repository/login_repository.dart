import 'login_api.dart';

class LoginRepository {

  final _loginApi = LoginApi();

  Future<Map<String, dynamic>> access(String data) => _loginApi.access(data);

  Future<Map<String, dynamic>> recoverPassword(String data) => _loginApi.recoverPassword(data);

}
