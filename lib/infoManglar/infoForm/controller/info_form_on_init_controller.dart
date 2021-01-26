
import '../model/forms/fishing_effort_form.dart';
import '../model/forms/limits_form.dart';
import '../model/forms/semi_annual_report_form.dart';
import '../model/forms/technical_report_form.dart';
import 'package:flutter/material.dart';

import '../controller/input_api.dart';
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
import '../repository/info_form_repository.dart';
import '../../../infoManglar/reports/model/report.dart';
import '../../../shared/form/model/form_config.dart';
import '../../../util/user.dart';

import 'dart:convert';

import '../../../util/utility.dart';

import '../../../constants.dart';

class InfoFormOnInitController {

  final InfoFormRepository infoFormRepository = InfoFormRepository();
  final InputApi inputApi = InputApi();

  Future<FormConfig> onInitForm(String userType, String typeForm, int idForm, context) async {

    Utility.showLoading(context);

    // Remove image cache in case of image was updated
    PaintingBinding.instance.imageCache.clear();

    // Restart and update formConfig
    FormConfig _formConfig = await getFormConfigBase(userType, typeForm);

    if ( idForm == null && !_formConfig.loadLast ) {
      Utility.dismissLoading(context);
      return _formConfig;
    }

    // ONLY PASS IF HAS TO LOAD DATA OF THE SERVER SO WE NEED TO PREVENT IF NO CONNECTION
    if (!User.hasInternetConnection) {
      Utility.dismissLoading(context);
      return _formConfig;
    }

    FormConfig formConfig;
    switch (_formConfig.idReport) {
      case 'control-form':
        formConfig = await _onInitControl(_formConfig, idForm, context);
        break;
      case 'crab-collection-form':
        formConfig = await _onInitCrabCollection(_formConfig, idForm, context);
        break;
      case 'crab-size-form':
        formConfig = await _onInitCrabSize(_formConfig, idForm, context);
        break;
      case 'deforestation-form':
        formConfig = await _onInitDeforestation(_formConfig, idForm, context);
        break;
      case 'desc-projects-form':
        formConfig = await _onInitDescProjects(_formConfig, idForm, context);
        break;
      case 'economic-indicators-form':
        formConfig = await _onInitEconomicIndicators(_formConfig, idForm, context);
        break;
      case 'evidence-form':
        formConfig = await _onInitEvidence(_formConfig, idForm, context);
        break;
      case 'info-veda-form':
        formConfig = await _onInitInfoVeda(_formConfig, idForm, context);
        break;
      case 'investments-orgs-form':
        formConfig = await _onInitInvestmentsOrgs(_formConfig, idForm, context);
        break;
      case 'official-docs-form':
        formConfig = await _onInitOfficialDocs(_formConfig, idForm, context);
        break;
      case 'plan-tracking-form':
        formConfig = await _onInitPlanTracking(_formConfig, idForm, context);
        break;
      case 'prices-form':
        formConfig = await _onInitPrices(_formConfig, idForm, context);
        break;
      case 'mapping-form':
        formConfig = await _onInitMapping(_formConfig, idForm, context);
        break;
      case 'limits-form':
        formConfig = await _onInitLimits(_formConfig, idForm, context);
        break;
      case 'reforestation-form':
        formConfig = await _onInitReforestation(_formConfig, idForm, context);
        break;
      case 'shell-collection-form':
        formConfig = await _onInitShellCollection(_formConfig, idForm, context);
        break;
      case 'shell-size-form':
        formConfig = await _onInitShellSize(_formConfig, idForm, context);
        break;
      case 'management-plan-form':
        formConfig = await _onInitManagementPlan(_formConfig, idForm, context);
        break;
      case 'social-indicators-form':
        formConfig = await _onInitSocialIndicators(_formConfig, idForm, context);
        break;
      case 'semi-annual-report-form':
        formConfig = await _onInitSemiAnnualReport(_formConfig, idForm, context);
        break;
      case 'technical-report-form':
        formConfig = await _onInitTechnicalReport(_formConfig, idForm, context);
        break;
      case 'fishing-effort-form':
        formConfig = await _onInitFishingEffort(_formConfig, idForm, context);
        break;
      case 'organization-info-form':
        formConfig = await _onInitOrganizationInfo(_formConfig, idForm, context);
        break;
      default:
        throw 'TO LOAD LAST FORM, ADDS INIT CONFIG FOR ${_formConfig.idReport}';
    }
    Utility.dismissLoading(context);

    return formConfig;
  }

  Future<FormConfig> onInitFormFromReport(Report report, context) async {
    return onInitForm(report.userType, report.typeForm, report.idForm, context);
  }

  Future<FormConfig> _onInitControl(FormConfig formConfig, int idForm, context) async {
    ControlForm form;
    if (idForm != null){
      form = await infoFormRepository.getControlById(idForm);
    } else {
      form = await infoFormRepository.getLastControl();
    }
    return form.updateFormConfig(formConfig);
  }

  Future<FormConfig> _onInitOrganizationInfo(FormConfig formConfig, int idForm, context) async {
    OrganizationInfoForm form;
    if (idForm != null){
      form = await infoFormRepository.getOrganizationInfoById(idForm);
    } else {
      form = await infoFormRepository.getLastOrganizationInfo();
    }
    return form.updateFormConfig(formConfig);
  }

  Future<FormConfig> _onInitCrabCollection(FormConfig formConfig, int idForm, context) async {
    CrabCollectionForm form;
    if (idForm != null){
      form = await infoFormRepository.getCrabCollectionById(idForm);
    } else {
      form = await infoFormRepository.getLastCrabCollection();
    }
    return form.updateFormConfig(formConfig);
  }

  Future<FormConfig> _onInitCrabSize(FormConfig formConfig, int idForm, context) async {
    CrabSizeForm form;
    if (idForm != null){
      form = await infoFormRepository.getCrabSizeById(idForm);
    } else {
      form = await infoFormRepository.getLastCrabSize();
    }
    return form.updateFormConfig(formConfig);
  }

  Future<FormConfig> _onInitDeforestation(FormConfig formConfig, int idForm, context) async {
    DeforestationForm form;
    if (idForm != null){
      form = await infoFormRepository.getDeforestationById(idForm);
    } else {
      form = await infoFormRepository.getLastDeforestation();
    }
    return form.updateFormConfig(formConfig);
  }

  Future<FormConfig> _onInitDescProjects(FormConfig formConfig, int idForm, context) async {
    DescProjectsForm form;
    if (idForm != null){
      form = await infoFormRepository.getDescProjectsById(idForm);
    } else {
      form = await infoFormRepository.getLastDescProjects();
    }
    return form.updateFormConfig(formConfig);
  }

  Future<FormConfig> _onInitEconomicIndicators(FormConfig formConfig, int idForm, context) async {
    EconomicIndicatorsForm form;
    if (idForm != null){
      form = await infoFormRepository.getEconomicIndicatorsById(idForm);
    } else {
      form = await infoFormRepository.getLastEconomicIndicators();
    }
    return form.updateFormConfig(formConfig);
  }

  Future<FormConfig> _onInitEvidence(FormConfig formConfig, int idForm, context) async {
    EvidenceForm form;
    if (idForm != null){
      form = await infoFormRepository.getEvidenceById(idForm);
    } else {
      form = await infoFormRepository.getLastEvidence();
    }
    return form.updateFormConfig(formConfig);
  }

  Future<FormConfig> _onInitInfoVeda(FormConfig formConfig, int idForm, context) async {
    InfoVedaForm form;
    if (idForm != null){
      form = await infoFormRepository.getInfoVedaById(idForm);
    } else {
      form = await infoFormRepository.getLastInfoVeda();
    }
    return form.updateFormConfig(formConfig);
  }

  Future<FormConfig> _onInitInvestmentsOrgs(FormConfig formConfig, int idForm, context) async {
    InvestmentsOrgsForm form;
    if (idForm != null){
      form = await infoFormRepository.getInvestmentsOrgsById(idForm);
    } else {
      form = await infoFormRepository.getLastInvestmentsOrgs();
    }
    return form.updateFormConfig(formConfig);
  }

  Future<FormConfig> _onInitOfficialDocs(FormConfig formConfig, int idForm, context) async {
    OfficialDocsForm form;
    if (idForm != null){
      form = await infoFormRepository.getOfficialDocsById(idForm);
    } else {
      form = await infoFormRepository.getLastOfficialDocs();
    }
    return form.updateFormConfig(formConfig);
  }

  Future<FormConfig> _onInitPlanTracking(FormConfig formConfig, int idForm, context) async {
    PlanTrackingForm form;
    if (idForm != null){
      form = await infoFormRepository.getPlanTrackingById(idForm);
    } else {
      form = await infoFormRepository.getLastPlanTracking();
    }
    return form.updateFormConfig(formConfig);
  }

  Future<FormConfig> _onInitPrices(FormConfig formConfig, int idForm, context) async {
    PricesForm form;
    if (idForm != null){
      form = await infoFormRepository.getPricesById(idForm);
    } else {
      form = await infoFormRepository.getLastPrices();
    }
    return form.updateFormConfig(formConfig);
  }

  Future<FormConfig> _onInitReforestation(FormConfig formConfig, int idForm, context) async {
    ReforestationForm form;
    if (idForm != null){
      form = await infoFormRepository.getReforestationById(idForm);
    } else {
      form = await infoFormRepository.getLastReforestation();
    }
    return form.updateFormConfig(formConfig);
  }

  Future<FormConfig> _onInitShellCollection(FormConfig formConfig, int idForm, context) async {
    ShellCollectionForm form;
    if (idForm != null){
      form = await infoFormRepository.getShellCollectionById(idForm);
    } else {
      form = await infoFormRepository.getLastShellCollection();
    }
    return form.updateFormConfig(formConfig);
  }

  Future<FormConfig> _onInitShellSize(FormConfig formConfig, int idForm, context) async {
    ShellSizeForm form;
    if (idForm != null){
      form = await infoFormRepository.getShellSizeById(idForm);
    } else {
      form = await infoFormRepository.getLastShellSize();
    }
    return form.updateFormConfig(formConfig);
  }

  Future<FormConfig> _onInitManagementPlan(FormConfig formConfig, int idForm, context) async {
    ManagementPlanForm form;
    if (idForm != null){
      form = await infoFormRepository.getManagementPlanById(idForm);
    } else {
      form = await infoFormRepository.getLastManagementPlan();
    }
    return form.updateFormConfig(formConfig);
  }

  Future<FormConfig> _onInitSocialIndicators(FormConfig formConfig, int idForm, context) async {
    SocialIndicatorsForm form;
    if (idForm != null){
      form = await infoFormRepository.getSocialIndicatorsById(idForm);
    } else {
      form = await infoFormRepository.getLastSocialIndicators();
    }
    return form.updateFormConfig(formConfig);
  }

  Future<FormConfig> _onInitSemiAnnualReport(FormConfig formConfig, int idForm, context) async {
    SemiAnnualReportForm form;
    if (idForm != null){
      form = await infoFormRepository.getSemiAnnualReportById(idForm);
    } else {
      form = await infoFormRepository.getLastSemiAnnualReport();
    }
    return form.updateFormConfig(formConfig);
  }

  Future<FormConfig> _onInitTechnicalReport(FormConfig formConfig, int idForm, context) async {
    TechnicalReportForm form;
    if (idForm != null){
      form = await infoFormRepository.getTechnicalReportById(idForm);
    } else {
      form = await infoFormRepository.getLastTechnicalReport();
    }
    return form.updateFormConfig(formConfig);
  }

  Future<FormConfig> _onInitFishingEffort(FormConfig formConfig, int idForm, context) async {
    FishingEffortForm form;
    if (idForm != null){
      form = await infoFormRepository.getFishingEffortById(idForm);
    } else {
      form = await infoFormRepository.getLastFishingEffort();
    }
    return form.updateFormConfig(formConfig);
  }

  Future<FormConfig> _onInitMapping(FormConfig formConfig, int idForm, context) async {
    MappingForm form;
    if (idForm != null){
      form = await infoFormRepository.getMappingById(idForm);
    } else {
      form = await infoFormRepository.getLastMapping();
    }
    return form.updateFormConfig(formConfig);
  }

  Future<FormConfig> _onInitLimits(FormConfig formConfig, int idForm, context) async {
    LimitsForm form;
    if (idForm != null){
      form = await infoFormRepository.getLimitsById(idForm);
    } else {
      form = await infoFormRepository.getLastLimits();
    }
    return form.updateFormConfig(formConfig);
  }

  // userType mae inp socio org ...
  // typeForm shell-collection-form control-form ...
  Future<FormConfig> getFormConfigBase(String userType, String typeForm) async {
    Map<String, dynamic> formsJson = await Utility.loadConfigForms(userType);
    Map<String, dynamic> config = await inputApi.updateApiInputs(formsJson);
    Map<String, dynamic> formJson = config[typeForm];
    return FormConfig.fromJson(formJson);
  }

}
