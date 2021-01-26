import '../../../util/web_client.dart';
import '../../form/model/data.dart';

class AnomalyFormApi {

  final WebClient _webClient = new WebClient();

  Future<Data> save(String data) async {
    dynamic result = await _webClient.post('rest/anomaly-form-reporter/save', data);
    return Data.fromJson(result);
  }

}
