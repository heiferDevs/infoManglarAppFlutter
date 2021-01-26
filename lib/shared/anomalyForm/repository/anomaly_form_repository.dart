
import '../repository/anomaly_form_api.dart';
import '../../form/model/data.dart';

class AnomalyFormRepository {

  final _anomalyFormApi = AnomalyFormApi();

  Future<Data> save(String data) => _anomalyFormApi.save(data);

}
