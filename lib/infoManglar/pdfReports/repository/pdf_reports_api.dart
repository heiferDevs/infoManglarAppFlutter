
import '../../../util/web_client.dart';
import '../../../shared/form/model/data.dart';

class PdfReportsApi {

  final WebClient _webClient = new WebClient();

  Future<Data> generatePdfReport(String data) async {
    dynamic result = await _webClient.post('rest/reports/pdf-report/save', data);
    return Data.fromJson(result);
  }

}
