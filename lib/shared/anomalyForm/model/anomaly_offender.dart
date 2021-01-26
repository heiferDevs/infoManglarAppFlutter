
class AnomalyOffender {

  int anomalyOffenderId;
  bool anomalyOffenderStatus;

  // The value is dynamic since the type is determined according to the type Input
  dynamic anomalyOffenderName;
  dynamic anomalyOffenderPin;
  dynamic anomalyOffenderPhone;
  dynamic anomalyOffenderAddress;
  dynamic anomalyOffenderAdditionalInformation;

  AnomalyOffender({
    this.anomalyOffenderId,
    this.anomalyOffenderStatus,
    this.anomalyOffenderName,
    this.anomalyOffenderPin,
    this.anomalyOffenderPhone,
    this.anomalyOffenderAddress,
    this.anomalyOffenderAdditionalInformation,
  });

  // FROM API
  factory AnomalyOffender.fromJson(Map<String, dynamic> json) {
    return AnomalyOffender(
      anomalyOffenderId: json['anomalyOffenderId'],
      anomalyOffenderStatus: json['anomalyOffenderStatus'],
      anomalyOffenderName: json['anomalyOffenderName'],
      anomalyOffenderPin: json['anomalyOffenderPin'],
      anomalyOffenderPhone: json['anomalyOffenderPhone'],
      anomalyOffenderAddress: json['anomalyOffenderAddress'],
      anomalyOffenderAdditionalInformation: json['anomalyOffenderAdditionalInformation'],
    );
  }

  // TO SAVE
  Map<String, dynamic> toJson() =>
  {
//    'anomalyOffenderId': anomalyOffenderId,
    'anomalyOffenderStatus': anomalyOffenderStatus,
    'anomalyOffenderName': anomalyOffenderName,
    'anomalyOffenderPin': anomalyOffenderPin,
    'anomalyOffenderPhone': anomalyOffenderPhone,
    'anomalyOffenderAddress': anomalyOffenderAddress,
    'anomalyOffenderAdditionalInformation': anomalyOffenderAdditionalInformation,
  };

  bool isEmpty(){
    return anomalyOffenderName == null && anomalyOffenderPin == null && anomalyOffenderPhone == null && anomalyOffenderAddress == null && anomalyOffenderAdditionalInformation == null;
  }

}
