
import '../../../shared/userType/model/user_type.dart';
import '../../../util/web_client.dart';

class UserTypeApi {

  final WebClient _webClient = new WebClient();

  Future<List<UserType>> usersType(String userType) async {
    dynamic result = await _webClient.get('rest/user-type/$userType');
    return result.map<UserType>( (o) => UserType.fromJson(o) ).toList();
  }

}
