import '../../../util/web_client.dart';

import '../model/chart_data.dart';

class StatsApi {

  final WebClient _webClient = new WebClient();

  Future<ChartData> montoInvertidoOrg(String userId, String orgId, String start, String end) async {
    dynamic result = await _webClient.get('rest/stats/investments-by-orgs/$userId/$orgId/$start/$end');
    final List<OrdinalData> ordinalList = result.map<OrdinalData>( (o) => OrdinalData.fromJson(o) ).toList();
    final ChartData barChartData = ChartData(ordinalList, 'montoInvertidoOrg', animate: true, vertical: false );
    return new Future(() => barChartData);
  }

  Future<ChartData> bioemprendimiento(String userId, String orgId, String start, String end) async {
    dynamic result = await _webClient.get('rest/stats/bioemprendimiento/$userId/$orgId/$start/$end');
    final List<OrdinalData> ordinalList = result.map<OrdinalData>( (o) => OrdinalData.fromJson(o) ).toList();
    final ChartData barChartData = ChartData(ordinalList, 'bioemprendimiento', animate: true, vertical: true );
    return new Future(() => barChartData);
  }

  Future<ChartData> projectsByType(String userId, String orgId, String start, String end) async {
    dynamic result = await _webClient.get('rest/stats/projects-by-type/$userId/$orgId/$start/$end');
    final List<OrdinalData> ordinalList = result.map<OrdinalData>( (o) => OrdinalData.fromJson(o) ).toList();
    final ChartData barChartData = ChartData(ordinalList, 'projectsByType', animate: true, vertical: true );
    return new Future(() => barChartData);
  }

  Future<ChartData> ingresoActividadPrincipal(String userId, String orgId, String start, String end) async {
    dynamic result = await _webClient.get('rest/stats/principal-activity/$userId/$orgId/$start/$end');
    final List<OrdinalData> ordinalList = result.map<OrdinalData>( (o) => OrdinalData.fromJson(o) ).toList();
    final ChartData barChartData = ChartData(ordinalList, 'ingresoActividadPrincipal', animate: true, vertical: false );
    return new Future(() => barChartData);
  }

  Future<ChartData> ingresoActividadSecundaria(String userId, String orgId, String start, String end) async {
    dynamic result = await _webClient.get('rest/stats/secondary-activity/$userId/$orgId/$start/$end');
    final List<OrdinalData> ordinalList = result.map<OrdinalData>( (o) => OrdinalData.fromJson(o) ).toList();
    final ChartData barChartData = ChartData(ordinalList, 'ingresoActividadSecundaria', animate: true, vertical: false );
    return new Future(() => barChartData);
  }

  Future<ChartData> areaReforestada(String userId, String orgId, String start, String end) async {
    dynamic result = await _webClient.get('rest/stats/reforestation-area/$userId/$orgId/$start/$end');
    final List<OrdinalData> ordinalList = result.map<OrdinalData>( (o) => OrdinalData.fromJson(o) ).toList();
    final ChartData barChartData = ChartData(ordinalList, 'areaReforestada', animate: true, vertical: false );
    return new Future(() => barChartData);
  }

  Future<ChartData> manglarDependents(String userId, String orgId, String start, String end) async {
    dynamic result = await _webClient.get('rest/stats/manglar-dependents/$userId/$orgId/$start/$end');
    final List<OrdinalData> ordinalList = result.map<OrdinalData>( (o) => OrdinalData.fromJson(o) ).toList();
    final ChartData barChartData = ChartData(ordinalList, 'manglarDependents', animate: true, vertical: true );
    return new Future(() => barChartData);
  }

  Future<ChartData> anomaliesByLocation(String userId, String orgId, String start, String end) async {
    dynamic result = await _webClient.get('rest/stats/anomalies-by-location/$userId/$orgId/$start/$end');
    final List<OrdinalData> ordinalList = result.map<OrdinalData>( (o) => OrdinalData.fromJson(o) ).toList();
    final ChartData barChartData = ChartData(ordinalList, 'anomaliesByLocation', animate: true, vertical: true );
    return new Future(() => barChartData);
  }

  Future<ChartData> fishingEffortCrabBySocio(String userId, String orgId, String start, String end) async {
    dynamic result = await _webClient.get('rest/stats/fishing-effort-crab-by-socio/$userId/$orgId/$start/$end');
    final List<OrdinalData> ordinalList = result.map<OrdinalData>( (o) => OrdinalData.fromJson(o) ).toList();
    final ChartData barChartData = ChartData(ordinalList, 'fishingEffortCrabBySocio', animate: true, vertical: false );
    return new Future(() => barChartData);
  }

  Future<ChartData> fishingEffortCrabByOrg(String userId, String orgId, String start, String end) async {
    dynamic result = await _webClient.get('rest/stats/fishing-effort-crab-by-org/$userId/$orgId/$start/$end');
    final List<OrdinalData> ordinalList = result.map<OrdinalData>( (o) => OrdinalData.fromJson(o) ).toList();
    final ChartData barChartData = ChartData(ordinalList, 'fishingEffortCrabByOrg', animate: true, vertical: false );
    return new Future(() => barChartData);
  }

  Future<ChartData> fishingEffortCrabBySector(String userId, String orgId, String start, String end) async {
    dynamic result = await _webClient.get('rest/stats/fishing-effort-crab-by-sector/$userId/$orgId/$start/$end');
    final List<OrdinalData> ordinalList = result.map<OrdinalData>( (o) => OrdinalData.fromJson(o) ).toList();
    final ChartData barChartData = ChartData(ordinalList, 'fishingEffortCrabBySector', animate: true, vertical: false );
    return new Future(() => barChartData);
  }

  Future<ChartData> fishingEffortShellBySocio(String userId, String orgId, String start, String end) async {
    dynamic result = await _webClient.get('rest/stats/fishing-effort-shell-by-socio/$userId/$orgId/$start/$end');
    final List<OrdinalData> ordinalList = result.map<OrdinalData>( (o) => OrdinalData.fromJson(o) ).toList();
    final ChartData barChartData = ChartData(ordinalList, 'fishingEffortShellBySocio', animate: true, vertical: false );
    return new Future(() => barChartData);
  }

  Future<ChartData> fishingEffortShellByOrg(String userId, String orgId, String start, String end) async {
    dynamic result = await _webClient.get('rest/stats/fishing-effort-shell-by-org/$userId/$orgId/$start/$end');
    final List<OrdinalData> ordinalList = result.map<OrdinalData>( (o) => OrdinalData.fromJson(o) ).toList();
    final ChartData barChartData = ChartData(ordinalList, 'fishingEffortShellByOrg', animate: true, vertical: false );
    return new Future(() => barChartData);
  }

  Future<ChartData> fishingEffortShellBySector(String userId, String orgId, String start, String end) async {
    dynamic result = await _webClient.get('rest/stats/fishing-effort-shell-by-sector/$userId/$orgId/$start/$end');
    final List<OrdinalData> ordinalList = result.map<OrdinalData>( (o) => OrdinalData.fromJson(o) ).toList();
    final ChartData barChartData = ChartData(ordinalList, 'fishingEffortShellBySector', animate: true, vertical: false );
    return new Future(() => barChartData);
  }

}
