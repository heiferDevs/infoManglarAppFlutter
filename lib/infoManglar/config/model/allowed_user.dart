
class AllowedUser {

  int allowedUserId;
  bool allowedUserStatus;
  String allowedUserName;
  String allowedUserPin;
  String organizationManglarName;
  String geographicalLocationName;

  AllowedUser({
    this.allowedUserId,
    this.allowedUserName,
    this.allowedUserStatus = true,
    this.allowedUserPin,
    this.organizationManglarName,
    this.geographicalLocationName,
  });

  factory AllowedUser.fromJson(Map<String, dynamic> json) {
    return AllowedUser(
      allowedUserId: json['allowedUserId'],
      allowedUserStatus: json['allowedUserStatus'],
      allowedUserName: json['allowedUserName'],
      allowedUserPin: json['allowedUserPin'],
      organizationManglarName: json['organizationManglarName'],
      geographicalLocationName: json['geographicalLocationName'],
    );
  }

}
