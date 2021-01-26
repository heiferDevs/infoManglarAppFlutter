
import '../../../shared/formMenu/model/form_menu.dart';

class DrawerOption {

  String id, title, type, image;

  List<DrawerOption> subOptions = [];

  FormMenu formMenu;

  DrawerOption({
    this.id,
    this.title,
    this.type,
    this.image,
  });

}
