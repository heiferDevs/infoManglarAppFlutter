import '../model/forms/fishing_effort_form.dart';
import '../model/forms/limits_form.dart';
import '../model/forms/semi_annual_report_form.dart';
import '../model/forms/technical_report_form.dart';

import '../../infoForm/model/history/history_change.dart';

import '../model/forms/control_form.dart';
import '../model/forms/crab_collection_form.dart';
import '../model/forms/crab_size_form.dart';
import '../model/forms/deforestation_form.dart';
import '../model/forms/desc_projects_form.dart';
import '../model/forms/economic_indicators_form.dart';
import '../model/forms/evidence_form.dart';
import '../model/forms/info_veda_form.dart';
import '../model/forms/investments_orgs_form.dart';
import '../model/forms/management_plan_form.dart';
import '../model/forms/mapping_form.dart';
import '../model/forms/official_docs_form.dart';
import '../model/forms/plan_tracking_form.dart';
import '../model/forms/prices_form.dart';
import '../model/forms/reforestation_form.dart';
import '../model/forms/shell_collection_form.dart';
import '../model/forms/shell_size_form.dart';
import '../model/forms/social_indicators_form.dart';
import '../model/forms/organization_info_form.dart';
import '../model/forms/pdf_report_form.dart';

import '../../../infoManglar/reports/model/report.dart';

import '../../../util/web_client.dart';
import '../../../util/user.dart';
import '../../../shared/form/model/data.dart';

class InfoFormApi {
  final WebClient _webClient = new WebClient();

  // SAVE FORMS
  Future<Data> saveOfficialDocs(String data) async {
    dynamic result =
        await _webClient.post('rest/official-docs-form/save', data);
    return Data.fromJson(result);
  }

  Future<Data> saveDescProjects(String data) async {
    dynamic result =
        await _webClient.post('rest/desc-projects-form/save', data);
    return Data.fromJson(result);
  }

  Future<Data> saveEconomicIndicators(String data) async {
    dynamic result =
        await _webClient.post('rest/economic-indicators-form/save', data);
    return Data.fromJson(result);
  }

  Future<Data> saveInvestmentsOrgs(String data) async {
    dynamic result =
        await _webClient.post('rest/investments-orgs-form/save', data);
    return Data.fromJson(result);
  }

  Future<Data> savePricesForm(String data) async {
    dynamic result = await _webClient.post('rest/prices-form/save', data);
    return Data.fromJson(result);
  }

  Future<Data> savePlanTracking(String data) async {
    dynamic result =
        await _webClient.post('rest/plan-tracking-form/save', data);
    return Data.fromJson(result);
  }

  Future<Data> saveInfoVeda(String data) async {
    dynamic result = await _webClient.post('rest/info-veda-form/save', data);
    return Data.fromJson(result);
  }

  Future<Data> saveShellSize(String data) async {
    dynamic result = await _webClient.post('rest/shell-size-form/save', data);
    return Data.fromJson(result);
  }

  Future<Data> saveCrabSize(String data) async {
    dynamic result = await _webClient.post('rest/crab-size-form/save', data);
    return Data.fromJson(result);
  }

  Future<Data> saveDeforestation(String data) async {
    dynamic result =
        await _webClient.post('rest/deforestation-form/save', data);
    return Data.fromJson(result);
  }

  Future<Data> saveReforestation(String data) async {
    dynamic result =
        await _webClient.post('rest/reforestation-form/save', data);
    return Data.fromJson(result);
  }

  Future<Data> saveControl(String data) async {
    dynamic result = await _webClient.post('rest/control-form/save', data);
    return Data.fromJson(result);
  }

  Future<Data> saveOrganizationInfo(String data) async {
    dynamic result =
        await _webClient.post('rest/organization-info-form/save', data);
    return Data.fromJson(result);
  }

  Future<Data> saveShellCollection(String data) async {
    dynamic result =
        await _webClient.post('rest/shell-collection-form/save', data);
    return Data.fromJson(result);
  }

  Future<Data> saveCrabCollection(String data) async {
    dynamic result =
        await _webClient.post('rest/crab-collection-form/save', data);
    return Data.fromJson(result);
  }

  Future<Data> saveEvidence(String data) async {
    dynamic result = await _webClient.post('rest/evidence-form/save', data);
    return Data.fromJson(result);
  }

  Future<Data> saveManagementPlan(String data) async {
    dynamic result =
        await _webClient.post('rest/management-plan-form/save', data);
    return Data.fromJson(result);
  }

  Future<Data> saveSocialIndicators(String data) async {
    dynamic result =
        await _webClient.post('rest/social-indicators-form/save', data);
    return Data.fromJson(result);
  }

  Future<Data> saveSemiAnnualReport(String data) async {
    dynamic result =
        await _webClient.post('rest/semi-annual-report-form/save', data);
    return Data.fromJson(result);
  }

  Future<Data> saveTechnicalReport(String data) async {
    dynamic result =
        await _webClient.post('rest/technical-report-form/save', data);
    return Data.fromJson(result);
  }

  Future<Data> saveFishingEffort(String data) async {
    dynamic result =
        await _webClient.post('rest/fishing-effort-form/save', data);
    return Data.fromJson(result);
  }

  Future<Data> saveMappingForm(String data) async {
    dynamic result = await _webClient.post('rest/mapping-form/save', data);
    return Data.fromJson(result);
  }

  Future<Data> saveLimitsForm(String data) async {
    dynamic result = await _webClient.post('rest/limits-form/save', data);
    return Data.fromJson(result);
  }

  Future<Data> savePdfReportForm(String data) async {
    dynamic result = await _webClient.post('rest/pdf-report-form/save', data);
    return Data.fromJson(result);
  }

  // LAST FORMS
  Future<ControlForm> getLastControl() async {
    dynamic result = await _webClient
        .get('rest/control-form/get-last/${User.organizationManglarId}');
    return ControlForm.fromJson(result);
  }

  Future<OrganizationInfoForm> getLastOrganizationInfo() async {
    dynamic result = await _webClient.get(
        'rest/organization-info-form/get-last/${User.organizationManglarId}');
    return OrganizationInfoForm.fromJson(result);
  }

  Future<CrabSizeForm> getLastCrabSize() async {
    dynamic result = await _webClient
        .get('rest/crab-size-form/get-last/${User.organizationManglarId}');
    return CrabSizeForm.fromJson(result);
  }

  Future<DeforestationForm> getLastDeforestation() async {
    dynamic result = await _webClient
        .get('rest/deforestation-form/get-last/${User.organizationManglarId}');
    return DeforestationForm.fromJson(result);
  }

  Future<DescProjectsForm> getLastDescProjects() async {
    dynamic result = await _webClient
        .get('rest/desc-projects-form/get-last/${User.organizationManglarId}');
    return DescProjectsForm.fromJson(result);
  }

  Future<EconomicIndicatorsForm> getLastEconomicIndicators() async {
    dynamic result = await _webClient.get(
        'rest/economic-indicators-form/get-last/${User.organizationManglarId}');
    return EconomicIndicatorsForm.fromJson(result);
  }

  Future<InfoVedaForm> getLastInfoVeda() async {
    dynamic result = await _webClient
        .get('rest/info-veda-form/get-last/${User.organizationManglarId}');
    return InfoVedaForm.fromJson(result);
  }

  Future<InvestmentsOrgsForm> getLastInvestmentsOrgs() async {
    dynamic result = await _webClient.get(
        'rest/investments-orgs-form/get-last/${User.organizationManglarId}');
    return InvestmentsOrgsForm.fromJson(result);
  }

  Future<OfficialDocsForm> getLastOfficialDocs() async {
    dynamic result = await _webClient
        .get('rest/official-docs-form/get-last/${User.organizationManglarId}');
    return OfficialDocsForm.fromJson(result);
  }

  Future<PlanTrackingForm> getLastPlanTracking() async {
    dynamic result = await _webClient
        .get('rest/plan-tracking-form/get-last/${User.organizationManglarId}');
    return PlanTrackingForm.fromJson(result);
  }

  Future<PricesForm> getLastPrices() async {
    dynamic result = await _webClient
        .get('rest/prices-form/get-last/${User.organizationManglarId}');
    return PricesForm.fromJson(result);
  }

  Future<ReforestationForm> getLastReforestation() async {
    dynamic result = await _webClient
        .get('rest/reforestation-form/get-last/${User.organizationManglarId}');
    return ReforestationForm.fromJson(result);
  }

  Future<ShellSizeForm> getLastShellSize() async {
    dynamic result = await _webClient
        .get('rest/shell-size-form/get-last/${User.organizationManglarId}');
    return ShellSizeForm.fromJson(result);
  }

  Future<ManagementPlanForm> getLastManagementPlan() async {
    dynamic result = await _webClient.get(
        'rest/management-plan-form/get-last/${User.organizationManglarId}');
    return ManagementPlanForm.fromJson(result);
  }

  Future<MappingForm> getLastMapping() async {
    dynamic result = await _webClient
        .get('rest/mapping-form/get-last/${User.organizationManglarId}');
    return MappingForm.fromJson(result);
  }

  Future<LimitsForm> getLastLimits() async {
    dynamic result = await _webClient
        .get('rest/limits-form/get-last/${User.organizationManglarId}');
    return LimitsForm.fromJson(result);
  }

  Future<SemiAnnualReportForm> getLastSemiAnnualReport() async {
    dynamic result = await _webClient.get(
        'rest/semi-annual-report-form/get-last/${User.organizationManglarId}');
    return SemiAnnualReportForm.fromJson(result);
  }

  Future<TechnicalReportForm> getLastTechnicalReport() async {
    dynamic result = await _webClient.get(
        'rest/technical-report-form/get-last/${User.organizationManglarId}');
    return TechnicalReportForm.fromJson(result);
  }

  Future<FishingEffortForm> getLastFishingEffortForm() async {
    dynamic result = await _webClient
        .get('rest/fishing-effort-form/get-last/${User.organizationManglarId}');
    return FishingEffortForm.fromJson(result);
  }

  // SOCIO FORMS ORG_ID AND USER_ID
  Future<ShellCollectionForm> getLastShellCollection() async {
    dynamic result = await _webClient.get(
        'rest/shell-collection-form/get-last/${User.organizationManglarId}/${User.userId}');
    return ShellCollectionForm.fromJson(result);
  }

  Future<CrabCollectionForm> getLastCrabCollection() async {
    dynamic result = await _webClient.get(
        'rest/crab-collection-form/get-last/${User.organizationManglarId}/${User.userId}');
    return CrabCollectionForm.fromJson(result);
  }

  Future<EvidenceForm> getLastEvidence() async {
    dynamic result = await _webClient.get(
        'rest/evidence-form/get-last/${User.organizationManglarId}/${User.userId}');
    return EvidenceForm.fromJson(result);
  }

  Future<SocialIndicatorsForm> getLastSocialIndicators() async {
    dynamic result = await _webClient.get(
        'rest/social-indicators-form/get-last/${User.organizationManglarId}/${User.userId}');
    return SocialIndicatorsForm.fromJson(result);
  }

  // ID FORMS
  Future<ControlForm> getControlById(int idForm) async {
    dynamic result = await _webClient.get('rest/control-form/get/$idForm');
    return ControlForm.fromJson(result);
  }

  Future<OrganizationInfoForm> getOrganizationInfoById(int idForm) async {
    dynamic result =
        await _webClient.get('rest/organization-info-form/get/$idForm');
    return OrganizationInfoForm.fromJson(result);
  }

  Future<CrabCollectionForm> getCrabCollectionById(int idForm) async {
    dynamic result =
        await _webClient.get('rest/crab-collection-form/get/$idForm');
    return CrabCollectionForm.fromJson(result);
  }

  Future<CrabSizeForm> getCrabSizeById(int idForm) async {
    dynamic result = await _webClient.get('rest/crab-size-form/get/$idForm');
    return CrabSizeForm.fromJson(result);
  }

  Future<DeforestationForm> getDeforestationById(int idForm) async {
    dynamic result =
        await _webClient.get('rest/deforestation-form/get/$idForm');
    return DeforestationForm.fromJson(result);
  }

  Future<DescProjectsForm> getDescProjectsById(int idForm) async {
    dynamic result =
        await _webClient.get('rest/desc-projects-form/get/$idForm');
    return DescProjectsForm.fromJson(result);
  }

  Future<EconomicIndicatorsForm> getEconomicIndicatorsById(int idForm) async {
    dynamic result =
        await _webClient.get('rest/economic-indicators-form/get/$idForm');
    return EconomicIndicatorsForm.fromJson(result);
  }

  Future<EvidenceForm> getEvidenceById(int idForm) async {
    dynamic result = await _webClient.get('rest/evidence-form/get/$idForm');
    return EvidenceForm.fromJson(result);
  }

  Future<InfoVedaForm> getInfoVedaById(int idForm) async {
    dynamic result = await _webClient.get('rest/info-veda-form/get/$idForm');
    return InfoVedaForm.fromJson(result);
  }

  Future<InvestmentsOrgsForm> getInvestmentsOrgsById(int idForm) async {
    dynamic result =
        await _webClient.get('rest/investments-orgs-form/get/$idForm');
    return InvestmentsOrgsForm.fromJson(result);
  }

  Future<OfficialDocsForm> getOfficialDocsById(int idForm) async {
    dynamic result =
        await _webClient.get('rest/official-docs-form/get/$idForm');
    return OfficialDocsForm.fromJson(result);
  }

  Future<PlanTrackingForm> getPlanTrackingById(int idForm) async {
    dynamic result =
        await _webClient.get('rest/plan-tracking-form/get/$idForm');
    return PlanTrackingForm.fromJson(result);
  }

  Future<PricesForm> getPricesById(int idForm) async {
    dynamic result = await _webClient.get('rest/prices-form/get/$idForm');
    return PricesForm.fromJson(result);
  }

  Future<ReforestationForm> getReforestationById(int idForm) async {
    dynamic result =
        await _webClient.get('rest/reforestation-form/get/$idForm');
    return ReforestationForm.fromJson(result);
  }

  Future<ShellCollectionForm> getShellCollectionById(int idForm) async {
    dynamic result =
        await _webClient.get('rest/shell-collection-form/get/$idForm');
    return ShellCollectionForm.fromJson(result);
  }

  Future<ShellSizeForm> getShellSizeById(int idForm) async {
    dynamic result = await _webClient.get('rest/shell-size-form/get/$idForm');
    return ShellSizeForm.fromJson(result);
  }

  Future<ManagementPlanForm> getManagementPlanById(int idForm) async {
    dynamic result =
        await _webClient.get('rest/management-plan-form/get/$idForm');
    return ManagementPlanForm.fromJson(result);
  }

  Future<SocialIndicatorsForm> getSocialIndicatorsById(int idForm) async {
    dynamic result =
        await _webClient.get('rest/social-indicators-form/get/$idForm');
    return SocialIndicatorsForm.fromJson(result);
  }

  Future<SemiAnnualReportForm> getSemiAnnualReportById(int idForm) async {
    dynamic result =
        await _webClient.get('rest/semi-annual-report-form/get/$idForm');
    return SemiAnnualReportForm.fromJson(result);
  }

  Future<TechnicalReportForm> getTechnicalReportById(int idForm) async {
    dynamic result =
        await _webClient.get('rest/technical-report-form/get/$idForm');
    return TechnicalReportForm.fromJson(result);
  }

  Future<FishingEffortForm> getFishingEffortById(int idForm) async {
    dynamic result =
        await _webClient.get('rest/fishing-effort-form/get/$idForm');
    return FishingEffortForm.fromJson(result);
  }

  Future<MappingForm> getMappingById(int idForm) async {
    dynamic result = await _webClient.get('rest/mapping-form/get/$idForm');
    return MappingForm.fromJson(result);
  }

  Future<LimitsForm> getLimitsById(int idForm) async {
    dynamic result = await _webClient.get('rest/limits-form/get/$idForm');
    return LimitsForm.fromJson(result);
  }

  // SELECTS FROM API
  Future<List<String>> sectorsFromApi(int idOrganization) async {
    dynamic result =
        await _webClient.get('rest/mapping/sectors/$idOrganization');
    return result.map<String>((o) => o.toString()).toList();
  }

  Future<List<String>> activitiesFromApi(int idOrganization) async {
    dynamic result = await _webClient
        .get('rest/management-plan-form/activities/$idOrganization');
    return result.map<String>((o) => o.toString()).toList();
  }

  // REPORTS
  Future<List<Report>> getReports(String formType, String userType,
      String userId, String orgId, String startTs, String endTs) async {
    dynamic result = await _webClient
        .get('rest/reports/$formType/$userType/$userId/$orgId/$startTs/$endTs');
    return result.map<Report>((o) => Report.fromJson(o)).toList();
  }

  // HISTORY
  Future<List<HistoryChange>> getHistory(String formType, int formId) async {
    dynamic result =
        await _webClient.get('rest/history-changes/filter/$formType/$formId');
    return result.map<HistoryChange>((o) => HistoryChange.fromJson(o)).toList();
  }

  Future<List<PdfReportForm>> getPdfReports(String orgId) async {
    dynamic result =
        await _webClient.get('rest/pdf-report-form/get-by-org/$orgId');
    return result.map<PdfReportForm>((o) => PdfReportForm.fromJson(o)).toList();
  }

  Future<List<PdfReportForm>> getPdfReportsPublished(String orgId) async {
    dynamic result = await _webClient
        .get('rest/pdf-report-form/get-by-org-published/$orgId');
    return result.map<PdfReportForm>((o) => PdfReportForm.fromJson(o)).toList();
  }

  // REMOVE
  Future<Data> removePdfReportForm(int formId) async {
    dynamic result = await _webClient.get('rest/pdf-report-form/rm/$formId');
    return Data.fromJson(result);
  }
}
