import '../model/drawer_option.dart';

class DrawerConfig {

  DrawerOption selected;
  List<DrawerOption> options = [];

  DrawerConfig({
    this.selected,
    this.options,
  });

}
