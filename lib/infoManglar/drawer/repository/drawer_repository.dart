
import '../model/drawer_config.dart';

import 'drawer_api.dart';

class DrawerRepository {

  final _drawerApi = DrawerApi();

  Future<DrawerConfig> getDrawerConfig() => _drawerApi.getDrawerConfig();

}
