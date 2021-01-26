import '../../../util/web_client.dart';

class LoginApi {

  final WebClient _webClient = new WebClient();

  Future<Map<String, dynamic>> access(String data) async {
    Map<String, dynamic> result = await _webClient.post('rest/login/access', data);
    return result;
  }

  Future<Map<String, dynamic>> recoverPassword(String data) async {
    Map<String, dynamic> result = await _webClient.post('rest/register/recover-password', data);
    return result;
  }

}
