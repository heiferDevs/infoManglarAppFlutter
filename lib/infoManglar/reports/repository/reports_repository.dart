
import '../repository/reports_api.dart';
import '../model/report.dart';

class ReportsRepository {

  final _reportsApi = ReportsApi();

  Future<List<Report>> reports(String formType, String userType, String userId, String orgId, String startTs, String endTs) =>
      _reportsApi.reports(formType, userType, userId, orgId, startTs, endTs);

  Future<bool> reportsCsv(String formType, String userType, String userId, String orgId, String startTs, String endTs) =>
      _reportsApi.reportsCsv(formType, userType, userId, orgId, startTs, endTs);

  Future<Map<String, dynamic>> mapping(String formType, String userType, String userId, String orgId, String startTs, String endTs) =>
      _reportsApi.mapping(formType, userType, userId, orgId, startTs, endTs);

  Future<bool> mappingFile(String formType, String userType, String userId, String orgId, String startTs, String endTs) =>
      _reportsApi.mappingDownloadGeojson(formType, userType, userId, orgId, startTs, endTs);

}
