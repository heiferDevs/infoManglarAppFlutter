
import '../model/chart_data.dart';
import '../repository/stats_api.dart';

class StatsRepository {

  final _statsApi = StatsApi();

  Future<ChartData> montoInvertidoOrg(String userId, String orgId, String start, String end) => _statsApi.montoInvertidoOrg(userId, orgId, start, end);

  Future<ChartData> bioemprendimiento(String userId, String orgId, String start, String end) => _statsApi.bioemprendimiento(userId, orgId, start, end);

  Future<ChartData> projectsByType(String userId, String orgId, String start, String end) => _statsApi.projectsByType(userId, orgId, start, end);

  Future<ChartData> ingresoActividadPrincipal(String userId, String orgId, String start, String end) => _statsApi.ingresoActividadPrincipal(userId, orgId, start, end);

  Future<ChartData> ingresoActividadSecundaria(String userId, String orgId, String start, String end) => _statsApi.ingresoActividadSecundaria(userId, orgId, start, end);

  Future<ChartData> areaReforestada(String userId, String orgId, String start, String end) => _statsApi.areaReforestada(userId, orgId, start, end);

  Future<ChartData> manglarDependents(String userId, String orgId, String start, String end) => _statsApi.manglarDependents(userId, orgId, start, end);

  Future<ChartData> anomaliesByLocation(String userId, String orgId, String start, String end) => _statsApi.anomaliesByLocation(userId, orgId, start, end);

  Future<ChartData> fishingEffortCrabBySocio(String userId, String orgId, String start, String end) => _statsApi.fishingEffortCrabBySocio(userId, orgId, start, end);

  Future<ChartData> fishingEffortCrabByOrg(String userId, String orgId, String start, String end) => _statsApi.fishingEffortCrabByOrg(userId, orgId, start, end);

  Future<ChartData> fishingEffortCrabBySector(String userId, String orgId, String start, String end) => _statsApi.fishingEffortCrabBySector(userId, orgId, start, end);

  Future<ChartData> fishingEffortShellBySocio(String userId, String orgId, String start, String end) => _statsApi.fishingEffortShellBySocio(userId, orgId, start, end);

  Future<ChartData> fishingEffortShellByOrg(String userId, String orgId, String start, String end) => _statsApi.fishingEffortShellByOrg(userId, orgId, start, end);

  Future<ChartData> fishingEffortShellBySector(String userId, String orgId, String start, String end) => _statsApi.fishingEffortShellBySector(userId, orgId, start, end);

}
