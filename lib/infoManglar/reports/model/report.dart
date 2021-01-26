
import '../../../util/user.dart';

class Report {

  final String image;

  final String title;
  final String subTitle;

  final int idForm;
  final String typeForm;
  final String extraInfo;

  final int createdAt;

  final int userId;
  final String userName;
  final String userType;

  final int organizationId;
  final String organizationName;

  Report({
    this.image,
    this.title,
    this.subTitle,
    this.idForm,
    this.typeForm,
    this.createdAt,
    this.extraInfo,
    this.userId,
    this.userName,
    this.userType,
    this.organizationId,
    this.organizationName,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      image: User.getImageFormsIcon('${json['typeForm']}.png'),
      title: json['title'],
      subTitle: json['subTitle'],
      idForm: json['idForm'],
      typeForm: json['typeForm'],
      createdAt: json['createdAt'],
      extraInfo: json['extraInfo'],
      userId: json['userId'],
      userName: json['userName'],
      userType: json['userType'],
      organizationId: json['organizationId'],
      organizationName: json['organizationName'],
    );
  }

}
