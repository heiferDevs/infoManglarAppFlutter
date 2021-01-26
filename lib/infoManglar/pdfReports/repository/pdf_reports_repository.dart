
import '../repository/pdf_reports_api.dart';
import '../../../shared/form/model/data.dart';

class PdfReportsRepository {

  final _reportsApi = PdfReportsApi();

  Future<Data> generatePdfReport(String data) => _reportsApi.generatePdfReport(data);

}
