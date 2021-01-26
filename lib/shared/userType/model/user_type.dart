
class UserType {

  int userId;
  String userName;
  String userEmail;
  String userPin;
  String userType;

  UserType({
    this.userId,
    this.userName,
    this.userEmail,
    this.userPin,
    this.userType,
  });

  factory UserType.fromJson(Map<String, dynamic> json) {
    return UserType(
      userId: json['userId'],
      userName: json['userName'],
      userEmail: json['userEmail'],
      userPin: json['userPin'],
      userType: json['userType'],
    );
  }

}
