import '../../form/model/form_config.dart';

class FormMenu {

  String id;
  String title;
  String subTitle;
  String type;
  List<FormConfig> forms;

  FormMenu({
    this.id,
    this.title,
    this.subTitle,
    this.type,
    this.forms,
  });

}
