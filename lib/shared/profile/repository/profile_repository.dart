import 'profile_api.dart';
import '../../form/model/data.dart';

class ProfileRepository {

  final _profileApi = ProfileApi();

  Future<Data> changePassword(String data) => _profileApi.changePassword(data);

}
