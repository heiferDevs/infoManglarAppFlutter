
import '../../../util/web_client.dart';
import '../../form/model/data.dart';

class ProfileApi {

  final WebClient _webClient = new WebClient();

  Future<Data> changePassword(String data) async {
    Map<String, dynamic> result = await _webClient.post('rest/register/change-password', data);
    return Data.fromJson(result);
  }

}
