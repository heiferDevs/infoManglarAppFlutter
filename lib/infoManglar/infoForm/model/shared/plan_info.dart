
import '../../../../shared/form/model/option.dart';
import '../../../../util/utility.dart';

class PlanInfo {

  int id;
  String info;
  String typeInfo;
  List<PlanInfo> plansInfo;

  PlanInfo({
    this.id,
    this.info,
    this.typeInfo,
    this.plansInfo,
  });

  // TO SAVE
  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> plansInfoJson = plansInfo
        .map<Map<String, dynamic>>( (PlanInfo f) => f.toJson() ).toList();
    Map<String, dynamic>  mapJson = {};
    mapJson['info'] = info;
    mapJson['typeInfo'] = typeInfo;
    mapJson['plansInfo'] = plansInfoJson;
    return Utility.removeNull(mapJson);
  }


  factory PlanInfo.fromJson(Map<String, dynamic> json) {
    List<PlanInfo> plansInfoFromJson = json['plansInfo'].map<PlanInfo>( (f) => PlanInfo.fromJson(f) ).toList();
    return PlanInfo(
      id: json['id'],
      info: json['info'],
      typeInfo: json['typeInfo'],
      plansInfo: plansInfoFromJson,
    );
  }

  isEmpty(){
    return plansInfo.length == 0;
  }

  updateOptionGroupProgram(Option option){
    option.getOptionFromOptionsGroup('program').setValueInit(info);
  }

  updateOptionGroupObjective(Option option){
    option.getOptionFromOptionsGroup('objective').setValueInit(info);
  }

  updateOptionGroupActivity(Option option){
    option.getOptionFromOptionsGroup('activity').setValueInit(info);
  }

  updateOptionGroupIndicator(Option option){
    option.setValueInit(info);
  }

}
