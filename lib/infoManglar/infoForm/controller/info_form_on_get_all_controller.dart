
import '../repository/info_form_repository.dart';
import '../../../infoManglar/reports/model/report.dart';
import '../../../shared/form/model/form_config.dart';
import '../../../util/user.dart';

class InfoFormOnGetAllController {

  final InfoFormRepository infoFormRepository = InfoFormRepository();

  static const String ALL = 'all';

  Future<List<Report>> onGetAllForm(FormConfig formConfig, context) async {
    if ( !formConfig.showListBeforeForm ) return await null;
    return await infoFormRepository.getReports(formConfig.idReport, ALL, User.userId, User.organizationManglarId, ALL, ALL);
  }

}
