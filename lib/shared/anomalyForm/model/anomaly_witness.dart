
class AnomalyWitness {

  int anomalyWitnessId;
  bool anomalyWitnessStatus;

  // The value is dynamic since the type is determined according to the type Input
  dynamic anomalyWitnessName;
  dynamic anomalyWitnessPhone;

  AnomalyWitness({
    this.anomalyWitnessId,
    this.anomalyWitnessStatus,
    this.anomalyWitnessName,
    this.anomalyWitnessPhone,
  });

  // FROM API
  factory AnomalyWitness.fromJson(Map<String, dynamic> json) {
    return AnomalyWitness(
      anomalyWitnessId: json['anomalyWitnessId'],
      anomalyWitnessStatus: json['anomalyWitnessStatus'],
      anomalyWitnessName: json['anomalyWitnessName'],
      anomalyWitnessPhone: json['anomalyWitnessPhone'],
    );
  }

  // TO SAVE
  Map<String, dynamic> toJson() =>
  {
//    'anomalyWitnessId': anomalyWitnessId,
    'anomalyWitnessStatus': anomalyWitnessStatus,
    'anomalyWitnessName': anomalyWitnessName,
    'anomalyWitnessPhone': anomalyWitnessPhone,
  };

  bool isEmpty(){
    return anomalyWitnessName == null && anomalyWitnessPhone == null;
  }

}
