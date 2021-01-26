
import '../../../util/utility.dart';

class OrganizationManglar {

  static const String ORG_TYPE = 'org';

  int organizationManglarId;
  bool organizationManglarStatus;
  String organizationManglarName;
  String organizationManglarCompleteName;
  String organizationManglarType;

  OrganizationManglar({
    this.organizationManglarId,
    this.organizationManglarStatus = true,
    this.organizationManglarName,
    this.organizationManglarCompleteName,
    this.organizationManglarType = ORG_TYPE,
  });

  factory OrganizationManglar.fromJson(Map<String, dynamic> json) {
    return OrganizationManglar(
      organizationManglarId: json['organizationManglarId'],
      organizationManglarStatus: json['organizationManglarStatus'],
      organizationManglarName: json['organizationManglarName'],
      organizationManglarCompleteName: json['organizationManglarCompleteName'],
      organizationManglarType: json['organizationManglarType'],
    );
  }

  // TO SAVE
  Map<String, dynamic> toJson() {
    Map<String, dynamic>  mapJson = {};
    mapJson['organizationManglarId'] = organizationManglarId;
    mapJson['organizationManglarStatus'] = organizationManglarStatus;
    mapJson['organizationManglarName'] = organizationManglarName;
    mapJson['organizationManglarCompleteName'] = organizationManglarCompleteName;
    mapJson['organizationManglarType'] = organizationManglarType;
    return Utility.removeNull(mapJson);
  }

}
