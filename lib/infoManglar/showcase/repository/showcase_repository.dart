import '../model/org.dart';
import '../repository/showcase_api.dart';

class ShowcaseRepository {

  final _showcaseApi = ShowcaseApi();

  Future<List<Org>> orgs() => _showcaseApi.orgs();

}
