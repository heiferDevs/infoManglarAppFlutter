
import '../../../../shared/form/model/option.dart';
import '../../../../util/utility.dart';
import 'file_form.dart';

class PlannedActivity {

  int id;
  String activityDescription;
  double averageDone;

  PlannedActivity({
    this.id,
    this.activityDescription,
    this.averageDone,
  });

  factory PlannedActivity.fromOption(Option o) {
    List<Option> optionsGroup = o.optionsToGroup;
    return PlannedActivity(
      id: o.idForm,
      activityDescription: o.getValueFromOptionsGroup('activityDescription', optionsGroup),
      averageDone: o.getValueFromOptionsGroup('averageDone', optionsGroup),
    );
  }

  factory PlannedActivity.fromJson(Map<String, dynamic> json) {
    return PlannedActivity(
      id: json['id'],
      activityDescription: json['activityDescription'],
      averageDone: json['averageDone'],
    );
  }

  // TO SAVE
  Map<String, dynamic> toJson() {
    Map<String, dynamic>  mapJson = {};
    mapJson['id'] = id;
    mapJson['activityDescription'] = activityDescription;
    mapJson['averageDone'] = averageDone;
    return Utility.removeNull(mapJson);
  }

  isEmpty(){
    return activityDescription == null;
  }

  updateOptionGroup(Option option){
    if (option.optionsToGroup == null) throw 'MOST HAVE OPTIONS TO GROUP TO ADD';
    option.idForm = id;
    option.getOptionFromOptionsGroup('activityDescription').setValueInit(activityDescription);
    option.getOptionFromOptionsGroup('averageDone').setValueInit(averageDone);
  }

}
