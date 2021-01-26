import '../../../util/web_client.dart';

import '../model/org.dart';

class ShowcaseApi {

  final WebClient _webClient = new WebClient();

  Future<List<Org>> orgs() async {
    dynamic result = await _webClient.get('rest/showcase/orgs');
    return result.map<Org>( (o) => Org.fromJson(o) ).toList();
  }

}
