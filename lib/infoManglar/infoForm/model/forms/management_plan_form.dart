
import '../../model/shared/plan_info.dart';
import '../../../../shared/form/model/form_config.dart';
import '../../../../shared/form/model/option.dart';
import '../../../../util/utility.dart';

class ManagementPlanForm{

  int managementPlanFormId;
  int userId;
  int organizationManglarId;
  String formType;

  List<PlanInfo> plansInfo;

  ManagementPlanForm({
    this.managementPlanFormId,
    this.formType,
    this.userId,
    this.organizationManglarId,
    this.plansInfo,
  });

  factory ManagementPlanForm.fromFormConfig(FormConfig formConfig, int userId, int organizationManglarId) {
    List<PlanInfo> plansInfo = getPlansInfoProgram(formConfig);
    return ManagementPlanForm(
      formType: formConfig.idReport,
      managementPlanFormId: formConfig.idForm,
      userId: userId,
      organizationManglarId: organizationManglarId,
      plansInfo: Utility.filterNull(plansInfo),
    );
  }

  static List<PlanInfo> getPlansInfoProgram(FormConfig formConfig){
    List<PlanInfo> result = [];
    formConfig.getOptions('programsGroup').forEach( (Option optionGroup) {
      Option optionFromGroup = optionGroup.getOptionFromOptionsGroup('program');
      PlanInfo planInfo = PlanInfo(
        info: optionFromGroup.getValue(),
        typeInfo: 'program',
        plansInfo: getPlansInfoObjective(FormConfig.fromOptionGroup(optionGroup)),
      );
      if (optionFromGroup.hasValue()) {
        result.add(planInfo);
      }
    });
    return Utility.filterNull(result);
  }

  static List<PlanInfo> getPlansInfoObjective(FormConfig formConfigProgram){
    List<PlanInfo> result = [];
    formConfigProgram.getOptions('objectivesGroup').forEach( (Option optionGroup) {
      Option optionFromGroup = optionGroup.getOptionFromOptionsGroup('objective');
      PlanInfo planInfo = PlanInfo(
        info: optionFromGroup.getValue(),
        typeInfo: 'objective',
        plansInfo: getPlansInfoActivity(FormConfig.fromOptionGroup(optionGroup)),
      );
      if (optionFromGroup.hasValue()) {
        result.add(planInfo);
      }
    });
    return Utility.filterNull(result);
  }

  static List<PlanInfo> getPlansInfoActivity(FormConfig formConfigProgram){
    List<PlanInfo> result = [];
    formConfigProgram.getOptions('activitiesGroup').forEach( (Option optionGroup) {
      Option optionFromGroup = optionGroup.getOptionFromOptionsGroup('activity');
      PlanInfo planInfo = PlanInfo(
        info: optionFromGroup.getValue(),
        typeInfo: 'activity',
        plansInfo: getPlansInfoIndicator(FormConfig.fromOptionGroup(optionGroup)),
      );
      if (optionFromGroup.hasValue()) {
        result.add(planInfo);
      }
    });
    return Utility.filterNull(result);
  }

  static List<PlanInfo> getPlansInfoIndicator(FormConfig formConfigProgram){
    List<PlanInfo> result = [];
    formConfigProgram.getOptions('indicator').forEach( (Option option) {
      PlanInfo planInfo = PlanInfo(
        info: option.getValue(),
        typeInfo: 'indicator',
        plansInfo: [],
      );
      if (option.hasValue()) {
        result.add(planInfo);
      }
    });
    return Utility.filterNull(result);
  }

  // TO SAVE
  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> plansInfoJson = plansInfo
        .map<Map<String, dynamic>>( (PlanInfo p) => p.toJson() ).toList();
    Map<String, dynamic>  mapJson = {};
    mapJson['managementPlanFormId'] = managementPlanFormId;
    mapJson['formType'] = formType;
    mapJson['userId'] = userId;
    mapJson['organizationManglarId'] = organizationManglarId;
    mapJson['plansInfo'] = plansInfoJson;
    return Utility.removeNull(mapJson);
  }

  factory ManagementPlanForm.fromJson(Map<String, dynamic> json) {
    List<PlanInfo> plansInfoJson = json['plansInfo'].map<PlanInfo>( (f) => PlanInfo.fromJson(f) ).toList();

    return ManagementPlanForm(
      managementPlanFormId: json['managementPlanFormId'],
      formType: json['formType'],
      userId: json['userId'],
      organizationManglarId: json['organizationManglarId'],
      plansInfo: plansInfoJson,
    );
  }

  FormConfig updateFormConfig(FormConfig formConfig){
    Option base = formConfig.getOption('programs'); // most have optionsToAdd
    formConfig.idForm = managementPlanFormId;

    // PROGRAM
    plansInfo.forEach( (PlanInfo program) {
      Option objectiveOptionGroup = formConfig.updateOptionGroup(base, program.updateOptionGroupProgram);
      // OBJECTIVE
      program.plansInfo.forEach( (PlanInfo objective) {
        FormConfig objectiveFormConfig = FormConfig.fromOptionGroup(objectiveOptionGroup);
        Option baseObjective = objectiveFormConfig.getOption('objectives'); // most have optionsToAdd
        Option activityOptionGroup = objectiveFormConfig.updateOptionGroup(baseObjective, objective.updateOptionGroupObjective);
        // ACTIVITY
        objective.plansInfo.forEach( (PlanInfo activity) {
          FormConfig activityFormConfig = FormConfig.fromOptionGroup(activityOptionGroup);
          Option baseActivity = activityFormConfig.getOption('activities'); // most have optionsToAdd
          Option indicatorOptionGroup = activityFormConfig.updateOptionGroup(baseActivity, activity.updateOptionGroupActivity);
          // INDICATOR
          activity.plansInfo.forEach( (PlanInfo indicator) {
            FormConfig indicatorFormConfig = FormConfig.fromOptionGroup(indicatorOptionGroup);
            Option baseIndicator = indicatorFormConfig.getOption('indicators'); // most have optionsToAdd
            indicatorFormConfig.updateOptionGroup(baseIndicator, indicator.updateOptionGroupIndicator);
          });
        });
      });
    });
    return formConfig;
  }

}

