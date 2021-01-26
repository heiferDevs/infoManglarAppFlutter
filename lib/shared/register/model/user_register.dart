
class UserRegister{

  String state;
  String pin;
  String name;
  String treatmentId;
  String nationalityId;
  String phone;
  String mobile;
  String email;
  String address;
  String gender;
  String civilStatus;
  String parroquiaId;
  String provinceName;
  String organizationManglarName;

  int provinceId;
  int organizationManglarId;

  UserRegister({
    this.state,
    this.pin,
    this.name,
    this.treatmentId,
    this.nationalityId,
    this.phone,
    this.mobile,
    this.email,
    this.address,
    this.gender,
    this.civilStatus,
    this.parroquiaId,
    this.provinceId,
    this.provinceName,
    this.organizationManglarId,
    this.organizationManglarName,
  });

  // FROM API
  factory UserRegister.fromJson(Map<String, dynamic> json) {
    return UserRegister(
      state: json['state'],
      pin: json['pin'],
      name: json['name'],
      gender: json['gender'],
      civilStatus: json['civilStatus'],
      organizationManglarId: json['organizationManglarId'],
      organizationManglarName: json['organizationManglarName'],
      provinceId: json['provinceId'],
      provinceName: json['provinceName'],
    );
  }

  // TO SAVE
  Map<String, dynamic> toJson() =>
  {
    'pin': pin,
    'name': name,
    'treatmentId': treatmentId,
    'nationalityId': nationalityId,
    'phone': phone,
    'mobile': mobile,
    'email': email,
    'address': address,
    'parroquiaId': parroquiaId,
    'gender': gender,
    'civilStatus': civilStatus,
    'organizationManglarId': organizationManglarId,
  };

}

