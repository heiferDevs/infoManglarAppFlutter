
import '../../model/shared/planned_activity.dart';
import '../../../../shared/form/model/form_config.dart';
import '../../../../shared/form/model/option.dart';
import '../../../../util/utility.dart';

class PlanTrackingForm{

  int planTrackingFormId;
  int userId;
  int organizationManglarId;
  String formType;

  List<PlannedActivity> plannedActivities;

  PlanTrackingForm({
    this.planTrackingFormId,
    this.formType,
    this.userId,
    this.organizationManglarId,
    this.plannedActivities,
  });

  factory PlanTrackingForm.fromFormConfig(FormConfig formConfig, int userId, int organizationManglarId) {
    List<PlannedActivity> plannedActivities = formConfig.getOptions('plannedActivity')
      .map<PlannedActivity>( (Option o) {
        print('will call with option id ${o.id}');
        return PlannedActivity.fromOption(o);
    }).toList();
    return PlanTrackingForm(
      formType: formConfig.idReport,
      planTrackingFormId: formConfig.idForm,
      userId: userId,
      organizationManglarId: organizationManglarId,
      plannedActivities: plannedActivities,
    );
  }

  factory PlanTrackingForm.fromJson(Map<String, dynamic> json) {
    List<PlannedActivity> plannedActivitiesJson = json['plannedActivities'].map<PlannedActivity>( (f) => PlannedActivity.fromJson(f) ).toList();
    return PlanTrackingForm(
      planTrackingFormId: json['planTrackingFormId'],
      formType: json['formType'],
      userId: json['userId'],
      organizationManglarId: json['organizationManglarId'],
      plannedActivities: plannedActivitiesJson,
    );
  }

  // TO SAVE
  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> plannedActivitiesJson = plannedActivities
        .where((PlannedActivity activity) => !activity.isEmpty()).toList()
        .map<Map<String, dynamic>>( (PlannedActivity activity) => activity.toJson() )
        .toList();
    Map<String, dynamic>  mapJson = {};
    mapJson['planTrackingFormId'] = planTrackingFormId;
    mapJson['formType'] = formType;
    mapJson['userId'] = userId;
    mapJson['organizationManglarId'] = organizationManglarId;
    mapJson['plannedActivities'] =Utility.filterNull( plannedActivitiesJson);
    return Utility.removeNull(mapJson);
  }

  FormConfig updateFormConfig(FormConfig formConfig){
    formConfig.idForm = planTrackingFormId;

    Option baseSize = formConfig.getOption('pannedActivities'); // most have optionsToAdd
    plannedActivities.sort( (a, b) => a.id.compareTo(b.id) );
    plannedActivities.forEach( (PlannedActivity form) {
      formConfig.updateOptionGroup(baseSize, form.updateOptionGroup);
    });
    return formConfig;
  }

}
