import '../model/anomaly_evidence.dart';
import '../model/anomaly_witness.dart';

import 'anomaly_offender.dart';

class AnomalyForm{

  int userId;
  int anomalyFormId;
  bool anomalyFormStatus;
  String anomalyFormType;
  String anomalyFormTypeId;
  String anomalyFormState;
  dynamic createdAt;

  // The value is dynamic since the type is determined according to the type Input
  dynamic animalsStrandedCount;
  dynamic feelDanger;
  dynamic hideIdentity;
  dynamic area;
  dynamic industrialType;
  dynamic artesanalType;
  dynamic fishingType;
  dynamic fishingTypeOthers;
  dynamic date;
  dynamic beachingReason;
  dynamic animalsStrandedSize;
  dynamic seaConditions;
  dynamic anomalyFormSubtype;
  dynamic type;
  dynamic custody;
  dynamic protectedArea;
  dynamic description;
  dynamic individualsRequisitionedInfo;
  dynamic individuals;
  dynamic individualsRequisitioned;
  dynamic province;
  dynamic canton;
  dynamic location;
  dynamic latlong;
  dynamic address;
  dynamic estuary;
  dynamic community;

  List<AnomalyOffender> anomaliesOffenders;
  List<AnomalyWitness> anomaliesWitnesses;
  List<AnomalyEvidence> anomaliesEvidences;

  AnomalyForm({
    this.userId,
    this.anomalyFormId,
    this.anomalyFormType,
    this.anomalyFormTypeId,
    this.anomalyFormStatus,
    this.anomalyFormState,
    this.createdAt,
    this.area,
    this.industrialType,
    this.artesanalType,
    this.fishingType,
    this.fishingTypeOthers,
    this.date,
    this.beachingReason,
    this.animalsStrandedCount,
    this.animalsStrandedSize,
    this.seaConditions,
    this.anomalyFormSubtype,
    this.type,
    this.custody,
    this.protectedArea,
    this.description,
    this.individualsRequisitionedInfo,
    this.individuals,
    this.individualsRequisitioned,
    this.province,
    this.canton,
    this.location,
    this.latlong,
    this.address,
    this.estuary,
    this.community,
    this.feelDanger,
    this.hideIdentity,
    this.anomaliesOffenders,
    this.anomaliesWitnesses,
    this.anomaliesEvidences,
  });

  // FROM API
  factory AnomalyForm.fromJson(Map<String, dynamic> json) {

    List<AnomalyOffender> anomaliesOffenders = [];
    List<AnomalyWitness> anomaliesWitnesses = [];
    List<AnomalyEvidence> anomaliesEvidences = [];

    // Parse anomaliesOffenders
    if ( json['anomaliesOffenders'] != null && json['anomaliesOffenders'].length > 0 ) {
      anomaliesOffenders = json['anomaliesOffenders'].map<AnomalyOffender>(
        (jsonAnomaly) => AnomalyOffender.fromJson(jsonAnomaly)
      ).toList();
    }

    // Parse anomaliesWitnesses
    if ( json['anomaliesWitnesses'] != null && json['anomaliesWitnesses'].length > 0 ) {
      anomaliesWitnesses = json['anomaliesWitnesses'].map<AnomalyWitness>(
        (jsonAnomaly) => AnomalyWitness.fromJson(jsonAnomaly)
      ).toList();
    }

    // Parse anomaliesEvidences
    if ( json['anomaliesEvidences'] != null && json['anomaliesEvidences'].length > 0 ) {
      anomaliesEvidences = json['anomaliesEvidences'].map<AnomalyEvidence>(
        (jsonAnomaly) => AnomalyEvidence.fromJson(jsonAnomaly)
      ).toList();
    }

    return AnomalyForm(
      anomalyFormId: json['anomalyFormId'],
      userId: json['userId'],
      anomalyFormType: json['anomalyFormType'],
      anomalyFormTypeId:  json['anomalyFormTypeId'],
      anomalyFormStatus: json['anomalyFormStatus'],
      anomalyFormState: json['anomalyFormState'],
      createdAt: json['createdAt'],
      area: json['area'],
      industrialType: json['industrialType'],
      artesanalType: json['artesanalType'],
      fishingType: json['fishingType'],
      fishingTypeOthers: json['fishingTypeOthers'],
      date: json['date'],
      beachingReason: json['beachingReason'],
      animalsStrandedCount: json['animalsStrandedCount'],
      animalsStrandedSize: json['animalsStrandedSize'],
      seaConditions: json['seaConditions'],
      anomalyFormSubtype: json['anomalyFormSubtype'],
      type: json['type'],
      custody: json['custody'],
      protectedArea: json['protectedArea'],
      description: json['description'],
      individualsRequisitionedInfo: json['individualsRequisitionedInfo'],
      individuals: json['individuals'],
      individualsRequisitioned: json['individualsRequisitioned'],
      province: json['province'],
      canton: json['canton'],
      location: json['location'],
      latlong: json['latlong'],
      address: json['address'],
      estuary: json['estuary'],
      community: json['community'],
      feelDanger: json['feelDanger'],
      hideIdentity: json['hideIdentity'],
      anomaliesOffenders: anomaliesOffenders,
      anomaliesWitnesses: anomaliesWitnesses,
      anomaliesEvidences: anomaliesEvidences,
    );
  }

  // TO SAVE
  Map<String, dynamic> toJson() {

    List<Map<String, dynamic>> anomaliesOffendersJson = anomaliesOffenders
      .where((anomaly) => !anomaly.isEmpty() ).toList()
      .map<Map<String, dynamic>>( (AnomalyOffender anomaly) => anomaly.toJson() )
      .toList();

    List<Map<String, dynamic>> anomaliesWitnessesJson = anomaliesWitnesses
      .where((anomaly) => !anomaly.isEmpty() ).toList()
      .map<Map<String, dynamic>>( (AnomalyWitness anomaly) => anomaly.toJson() )
      .toList();

    List<Map<String, dynamic>> anomaliesEvidencesJson = anomaliesEvidences
      .where((anomaly) => !anomaly.isEmpty() ).toList()
      .map<Map<String, dynamic>>( (AnomalyEvidence anomaly) => anomaly.toJson() )
      .toList();

    Map<String, dynamic>  mapJson = {};
    if ( userId != null) mapJson['userId'] = userId;
    if ( anomalyFormType != null ) mapJson['anomalyFormType'] = anomalyFormType;
    if ( anomalyFormStatus != null ) mapJson['anomalyFormStatus'] = anomalyFormStatus;
    if ( anomalyFormState != null ) mapJson['anomalyFormState'] = anomalyFormState;
    if ( area != null ) mapJson['area'] = area;
    if ( industrialType != null ) mapJson['industrialType'] = industrialType;
    if ( artesanalType != null ) mapJson['artesanalType'] = artesanalType;
    if ( fishingType != null ) mapJson['fishingType'] = fishingType;
    if ( fishingTypeOthers != null ) mapJson['fishingTypeOthers'] = fishingTypeOthers;
    if ( date != null ) mapJson['date'] = date;
    if ( beachingReason != null ) mapJson['beachingReason'] = beachingReason;
    if ( animalsStrandedCount != null ) mapJson['animalsStrandedCount'] = animalsStrandedCount;
    if ( animalsStrandedSize != null ) mapJson['animalsStrandedSize'] = animalsStrandedSize;
    if ( seaConditions != null ) mapJson['seaConditions'] = seaConditions;
    if ( anomalyFormSubtype != null ) mapJson['anomalyFormSubtype'] = anomalyFormSubtype;
    if ( type != null ) mapJson['type'] = type;
    if ( custody != null ) mapJson['custody'] = custody;
    if ( protectedArea != null ) mapJson['protectedArea'] = protectedArea;
    if ( description != null ) mapJson['description'] = description;
    if ( individualsRequisitionedInfo != null ) mapJson['individualsRequisitionedInfo'] = individualsRequisitionedInfo;
    if ( individuals != null ) mapJson['individuals'] = individuals;
    if ( individualsRequisitioned != null ) mapJson['individualsRequisitioned'] = individualsRequisitioned;
    if ( province != null ) mapJson['province'] = province;
    if ( canton != null ) mapJson['canton'] = canton;
    if ( location != null ) mapJson['location'] = location;
    if ( latlong != null ) mapJson['latlong'] = latlong;
    if ( address != null ) mapJson['address'] = address;
    if ( estuary != null ) mapJson['estuary'] = estuary;
    if ( community != null ) mapJson['community'] = community;
    if ( feelDanger != null ) mapJson['feelDanger'] = feelDanger;
    if ( hideIdentity != null ) mapJson['hideIdentity'] = hideIdentity;
    mapJson['anomaliesOffenders'] = anomaliesOffendersJson;
    mapJson['anomaliesWitnesses'] = anomaliesWitnessesJson;
    mapJson['anomaliesEvidences'] = anomaliesEvidencesJson;
    return mapJson;
  }

}

