
class AnomalyEvidence {

  int anomalyEvidenceId;
  bool anomalyEvidenceStatus;

  // The value is dynamic since the type is determined according to the type Input
  dynamic anomalyEvidenceNameFile;
  dynamic anomalyEvidenceType;
  dynamic anomalyEvidencePathOrigin;
  dynamic anomalyEvidenceDescription;
  dynamic anomalyEvidenceUrl;

  AnomalyEvidence({
    this.anomalyEvidenceId,
    this.anomalyEvidenceStatus,
    this.anomalyEvidenceNameFile,
    this.anomalyEvidenceType,
    this.anomalyEvidencePathOrigin,
    this.anomalyEvidenceDescription,
    this.anomalyEvidenceUrl,
  });

  // FROM API
  factory AnomalyEvidence.fromJson(Map<String, dynamic> json) {
    return AnomalyEvidence(
      anomalyEvidenceId: json['anomalyEvidenceId'],
      anomalyEvidenceStatus: json['anomalyEvidenceStatus'],
      anomalyEvidenceNameFile: json['anomalyEvidenceNameFile'],
      anomalyEvidenceType: json['anomalyEvidenceType'],
      anomalyEvidencePathOrigin: json['anomalyEvidencePathOrigin'],
      anomalyEvidenceDescription: json['anomalyEvidenceDescription'],
      anomalyEvidenceUrl: json['anomalyEvidenceUrl'],
    );
  }

  // TO SAVE
  Map<String, dynamic> toJson() =>
  {
//    'anomalyEvidenceId': anomalyEvidenceId,
    'anomalyEvidenceStatus': anomalyEvidenceStatus,
    'anomalyEvidenceNameFile': anomalyEvidenceNameFile,
    'anomalyEvidenceType': anomalyEvidenceType,
    'anomalyEvidencePathOrigin': anomalyEvidencePathOrigin,
    'anomalyEvidenceDescription': anomalyEvidenceDescription,
    'anomalyEvidenceUrl': anomalyEvidenceUrl,
  };

  bool isEmpty(){
    return anomalyEvidenceNameFile == null;
  }

}
