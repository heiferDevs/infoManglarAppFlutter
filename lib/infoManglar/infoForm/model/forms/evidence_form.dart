
import '../../model/shared/evidence_activity.dart';
import '../../../../shared/form/model/form_config.dart';
import '../../../../shared/form/model/option.dart';
import '../../../../util/utility.dart';

class EvidenceForm{

  int evidenceFormId;
  int userId;
  int organizationManglarId;
  String formType;

  String activity;
  String activityDate;
  String activityDesc;
  String activityResults;

  List<EvidenceActivity> evidenceActivities;

  EvidenceForm({
    this.evidenceFormId,
    this.formType,
    this.userId,
    this.organizationManglarId,
    this.evidenceActivities,
    this.activity,
    this.activityDate,
    this.activityDesc,
    this.activityResults,
  });

  factory EvidenceForm.fromFormConfig(FormConfig formConfig, int userId, int organizationManglarId) {
    List<EvidenceActivity> evidenceActivities = formConfig.getOptions('evidenceGroup')
      .map<EvidenceActivity>( (Option o) {
        return EvidenceActivity.fromOption(o);
    }).toList();
    return EvidenceForm(
      formType: formConfig.idReport,
      evidenceFormId: formConfig.idForm,
      userId: userId,
      organizationManglarId: organizationManglarId,
      evidenceActivities: evidenceActivities,
      activity: formConfig.getValue('activity'),
      activityDate: formConfig.getValue('activityDate'),
      activityDesc: formConfig.getValue('activityDesc'),
      activityResults: formConfig.getValue('activityResults'),
    );
  }

  factory EvidenceForm.fromJson(Map<String, dynamic> json) {
    List<EvidenceActivity> evidenceActivitiesJson = json['evidenceActivities'].map<EvidenceActivity>( (f) => EvidenceActivity.fromJson(f) ).toList();
    return EvidenceForm(
      evidenceFormId: json['evidenceFormId'],
      formType: json['formType'],
      userId: json['userId'],
      organizationManglarId: json['organizationManglarId'],
      evidenceActivities: evidenceActivitiesJson,
      activity: json['activity'],
      activityDate: json['activityDate'],
      activityDesc: json['activityDesc'],
      activityResults: json['activityResults'],
    );
  }

  // TO SAVE
  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> evidenceActivitiesJson = evidenceActivities
        .where((EvidenceActivity activity) => !activity.isEmpty()).toList()
        .map<Map<String, dynamic>>( (EvidenceActivity activity) => activity.toJson() )
        .toList();
    Map<String, dynamic>  mapJson = {};
    mapJson['evidenceFormId'] = evidenceFormId;
    mapJson['formType'] = formType;
    mapJson['userId'] = userId;
    mapJson['organizationManglarId'] = organizationManglarId;
    mapJson['evidenceActivities'] = Utility.filterNull( evidenceActivitiesJson);
    mapJson['activity'] = activity;
    mapJson['activityDate'] = activityDate;
    mapJson['activityDesc'] = activityDesc;
    mapJson['activityResults'] = activityResults;
    return Utility.removeNull(mapJson);
  }

  FormConfig updateFormConfig(FormConfig formConfig){
    formConfig.getOption('activity').setValueInit(activity);
    formConfig.getOption('activityDate').setValueInit(activityDate);
    formConfig.getOption('activityDesc').setValueInit(activityDesc);
    formConfig.getOption('activityResults').setValueInit(activityResults);
    formConfig.idForm = evidenceFormId;

    Option baseSize = formConfig.getOption('evidences'); // most have optionsToAdd
    evidenceActivities.sort( (a, b) => a.id.compareTo(b.id) );
    evidenceActivities.forEach( (EvidenceActivity form) {
      formConfig.updateOptionGroup(baseSize, form.updateOptionGroup);
    });
    return formConfig;
  }

}
