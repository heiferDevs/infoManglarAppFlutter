
import '../../../shared/userType/model/user_type.dart';
import '../../../shared/userType/repository/user_type_api.dart';


class UserTypeRepository {

  final _userTypeApi = UserTypeApi();

  Future<List<UserType>> usersType(String userType) => _userTypeApi.usersType(userType);

}
