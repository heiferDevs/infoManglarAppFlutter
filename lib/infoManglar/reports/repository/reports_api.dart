
import '../../../plugins/url_launcher.dart';
import '../../../util/web_client.dart';
import '../../../constants.dart';
import '../model/report.dart';

class ReportsApi {

  final WebClient _webClient = new WebClient();
  static const String ALL = 'all';

  Future<List<Report>> reports(String formType, String userType, String userId, String orgId, String startTs, String endTs) async {
    dynamic result = await _webClient.get('rest/reports/$formType/$userType/$userId/$orgId/$startTs/$endTs');
    return result.map<Report>( (o) => Report.fromJson(o) ).toList();
  }

  Future<bool> reportsCsv(String formType, String userType, String userId, String orgId, String startTs, String endTs) async {
    String url = '${Constants.hostUrl}rest/reports/csv/$formType/$userType/$userId/$orgId/$startTs/$endTs';
    print('reportsCsv file url $url');
    return await UrlLauncher.launchURL(url);
  }

  Future<Map<String, dynamic>> mapping(String formType, String userType, String userId, String orgId, String startTs, String endTs) async {
    return await _webClient.get('rest/mapping/filter/$formType/$userType/$userId/$orgId/$startTs/$endTs');
  }

  Future<bool> mappingDownloadGeojson(String formType, String userType, String userId, String orgId, String startTs, String endTs) async {
    String url = '${Constants.hostUrl}rest/mapping/filter-file/$formType/$userType/$userId/$orgId/$startTs/$endTs';
    print('mapping file url $url');
    return await UrlLauncher.launchURL(url);
  }

  String getTsStartYear(String year){
    switch (year){
      case '2019':
        return DateTime(2019, 1, 1).millisecondsSinceEpoch.toString();
      case '2020':
        return DateTime(2020, 1, 1).millisecondsSinceEpoch.toString();
    }
    return 'all';
  }

  String getTsEndYear(String year){
    switch (year){
      case '2019':
        return DateTime(2020, 1, 1).millisecondsSinceEpoch.toString();
      case '2020':
        return DateTime(2021, 1, 1).millisecondsSinceEpoch.toString();
    }
    return 'all';
  }

  String getTsStart(String period){
      final now = DateTime.now();
      switch (period){
        case 'today':
          return DateTime(now.year, now.month, now.day).millisecondsSinceEpoch.toString();
        case 'last-month':
          return DateTime(now.year, now.month, 1).millisecondsSinceEpoch.toString();
        case 'last-year':
          return DateTime(now.year, 1, 1).millisecondsSinceEpoch.toString();
      }
      return 'all';
  }

}
