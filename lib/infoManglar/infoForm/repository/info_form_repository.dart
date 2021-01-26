
import '../model/forms/fishing_effort_form.dart';
import '../model/forms/limits_form.dart';
import '../model/forms/semi_annual_report_form.dart';
import '../model/forms/technical_report_form.dart';

import '../../../infoManglar/infoForm/model/history/history_change.dart';

import '../model/forms/control_form.dart';
import '../model/forms/crab_collection_form.dart';
import '../model/forms/crab_size_form.dart';
import '../model/forms/deforestation_form.dart';
import '../model/forms/desc_projects_form.dart';
import '../model/forms/economic_indicators_form.dart';
import '../model/forms/evidence_form.dart';
import '../model/forms/info_veda_form.dart';
import '../model/forms/organization_info_form.dart';
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
import '../model/forms/pdf_report_form.dart';
import '../../../infoManglar/reports/model/report.dart';

import '../repository/info_form_api.dart';
import '../../../shared/form/model/data.dart';

class InfoFormRepository {

  final _infoFormApi = InfoFormApi();

  // SAVE FORMS
  Future<Data> saveOfficialDocs(String data) => _infoFormApi.saveOfficialDocs(data);
  Future<Data> saveDescProjects(String data) => _infoFormApi.saveDescProjects(data);
  Future<Data> saveEconomicIndicators(String data) => _infoFormApi.saveEconomicIndicators(data);
  Future<Data> saveInvestmentsOrgs(String data) => _infoFormApi.saveInvestmentsOrgs(data);
  Future<Data> savePlanTracking(String data) => _infoFormApi.savePlanTracking(data);
  Future<Data> savePricesForm(String data) => _infoFormApi.savePricesForm(data);
  Future<Data> saveInfoVeda(String data) => _infoFormApi.saveInfoVeda(data);
  Future<Data> saveShellSize(String data) => _infoFormApi.saveShellSize(data);
  Future<Data> saveCrabSize(String data) => _infoFormApi.saveCrabSize(data);
  Future<Data> saveDeforestation(String data) => _infoFormApi.saveDeforestation(data);
  Future<Data> saveReforestation(String data) => _infoFormApi.saveReforestation(data);
  Future<Data> saveControl(String data) => _infoFormApi.saveControl(data);
  Future<Data> saveOrganizationInfo(String data) => _infoFormApi.saveOrganizationInfo(data);
  Future<Data> saveShellCollection(String data) => _infoFormApi.saveShellCollection(data);
  Future<Data> saveCrabCollection(String data) => _infoFormApi.saveCrabCollection(data);
  Future<Data> saveEvidence(String data) => _infoFormApi.saveEvidence(data);
  Future<Data> saveManagementPlan(String data) => _infoFormApi.saveManagementPlan(data);
  Future<Data> saveSocialIndicators(String data) => _infoFormApi.saveSocialIndicators(data);
  Future<Data> saveSemiAnnualReport(String data) => _infoFormApi.saveSemiAnnualReport(data);
  Future<Data> saveTechnicalReport(String data) => _infoFormApi.saveTechnicalReport(data);
  Future<Data> saveFishingEffort(String data) => _infoFormApi.saveFishingEffort(data);
  Future<Data> saveMappingForm(String data) => _infoFormApi.saveMappingForm(data);
  Future<Data> saveLimitsForm(String data) => _infoFormApi.saveLimitsForm(data);
  Future<Data> savePdfReportForm(String data) => _infoFormApi.savePdfReportForm(data);

  // LAST FORMS
  Future<ControlForm> getLastControl() => _infoFormApi.getLastControl();
  Future<OrganizationInfoForm> getLastOrganizationInfo() => _infoFormApi.getLastOrganizationInfo();
  Future<CrabCollectionForm> getLastCrabCollection() => _infoFormApi.getLastCrabCollection();
  Future<CrabSizeForm> getLastCrabSize() => _infoFormApi.getLastCrabSize();
  Future<DeforestationForm> getLastDeforestation() => _infoFormApi.getLastDeforestation();
  Future<DescProjectsForm> getLastDescProjects() => _infoFormApi.getLastDescProjects();
  Future<EconomicIndicatorsForm> getLastEconomicIndicators() => _infoFormApi.getLastEconomicIndicators();
  Future<EvidenceForm> getLastEvidence() => _infoFormApi.getLastEvidence();
  Future<InfoVedaForm> getLastInfoVeda() => _infoFormApi.getLastInfoVeda();
  Future<InvestmentsOrgsForm> getLastInvestmentsOrgs() => _infoFormApi.getLastInvestmentsOrgs();
  Future<OfficialDocsForm> getLastOfficialDocs() => _infoFormApi.getLastOfficialDocs();
  Future<PlanTrackingForm> getLastPlanTracking() => _infoFormApi.getLastPlanTracking();
  Future<PricesForm> getLastPrices() => _infoFormApi.getLastPrices();
  Future<ReforestationForm> getLastReforestation() => _infoFormApi.getLastReforestation();
  Future<ShellCollectionForm> getLastShellCollection() => _infoFormApi.getLastShellCollection();
  Future<ShellSizeForm> getLastShellSize() => _infoFormApi.getLastShellSize();
  Future<ManagementPlanForm> getLastManagementPlan() => _infoFormApi.getLastManagementPlan();
  Future<SocialIndicatorsForm> getLastSocialIndicators() => _infoFormApi.getLastSocialIndicators();
  Future<SemiAnnualReportForm> getLastSemiAnnualReport() => _infoFormApi.getLastSemiAnnualReport();
  Future<TechnicalReportForm> getLastTechnicalReport() => _infoFormApi.getLastTechnicalReport();
  Future<FishingEffortForm> getLastFishingEffort() => _infoFormApi.getLastFishingEffortForm();
  Future<MappingForm> getLastMapping() => _infoFormApi.getLastMapping();
  Future<LimitsForm> getLastLimits() => _infoFormApi.getLastLimits();

  // ID FORMS
  Future<ControlForm> getControlById(int idForm) => _infoFormApi.getControlById(idForm);
  Future<OrganizationInfoForm> getOrganizationInfoById(int idForm) => _infoFormApi.getOrganizationInfoById(idForm);
  Future<CrabCollectionForm> getCrabCollectionById(int idForm) => _infoFormApi.getCrabCollectionById(idForm);
  Future<CrabSizeForm> getCrabSizeById(int idForm) => _infoFormApi.getCrabSizeById(idForm);
  Future<DeforestationForm> getDeforestationById(int idForm) => _infoFormApi.getDeforestationById(idForm);
  Future<DescProjectsForm> getDescProjectsById(int idForm) => _infoFormApi.getDescProjectsById(idForm);
  Future<EconomicIndicatorsForm> getEconomicIndicatorsById(int idForm) => _infoFormApi.getEconomicIndicatorsById(idForm);
  Future<EvidenceForm> getEvidenceById(int idForm) => _infoFormApi.getEvidenceById(idForm);
  Future<InfoVedaForm> getInfoVedaById(int idForm) => _infoFormApi.getInfoVedaById(idForm);
  Future<InvestmentsOrgsForm> getInvestmentsOrgsById(int idForm) => _infoFormApi.getInvestmentsOrgsById(idForm);
  Future<OfficialDocsForm> getOfficialDocsById(int idForm) => _infoFormApi.getOfficialDocsById(idForm);
  Future<PlanTrackingForm> getPlanTrackingById(int idForm) => _infoFormApi.getPlanTrackingById(idForm);
  Future<PricesForm> getPricesById(int idForm) => _infoFormApi.getPricesById(idForm);
  Future<ReforestationForm> getReforestationById(int idForm) => _infoFormApi.getReforestationById(idForm);
  Future<ShellCollectionForm> getShellCollectionById(int idForm) => _infoFormApi.getShellCollectionById(idForm);
  Future<ShellSizeForm> getShellSizeById(int idForm) => _infoFormApi.getShellSizeById(idForm);
  Future<ManagementPlanForm> getManagementPlanById(int idForm) => _infoFormApi.getManagementPlanById(idForm);
  Future<SocialIndicatorsForm> getSocialIndicatorsById(int idForm) => _infoFormApi.getSocialIndicatorsById(idForm);
  Future<SemiAnnualReportForm> getSemiAnnualReportById(int idForm) => _infoFormApi.getSemiAnnualReportById(idForm);
  Future<TechnicalReportForm> getTechnicalReportById(int idForm) => _infoFormApi.getTechnicalReportById(idForm);
  Future<FishingEffortForm> getFishingEffortById(int idForm) => _infoFormApi.getFishingEffortById(idForm);
  Future<MappingForm> getMappingById(int idForm) => _infoFormApi.getMappingById(idForm);
  Future<LimitsForm> getLimitsById(int idForm) => _infoFormApi.getLimitsById(idForm);

  Future<List<String>> sectorsFromApi(int idOrganization) => _infoFormApi.sectorsFromApi(idOrganization);
  Future<List<String>> activitiesFromApi(int idOrganization) => _infoFormApi.activitiesFromApi(idOrganization);

  // REPORTS
  Future<List<Report>> getReports(String formType, String userType, String userId, String orgId, String startTs, String endTs) =>
      _infoFormApi.getReports(formType, userType, userId, orgId, startTs, endTs);

  // HISTORY
  Future<List<HistoryChange>> getHistory(String formType, int formId) => _infoFormApi.getHistory(formType, formId);

  Future<List<PdfReportForm>> getPdfReports(String orgId) => _infoFormApi.getPdfReports(orgId);
  Future<List<PdfReportForm>> getPdfReportsPublished(String orgId) => _infoFormApi.getPdfReportsPublished(orgId);

  // REMOVE
  Future<Data> removePdfReportForm(int formId) => _infoFormApi.removePdfReportForm(formId);

}
