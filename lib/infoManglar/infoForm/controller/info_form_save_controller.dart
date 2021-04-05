import 'dart:io';
import 'dart:convert';

import '../model/forms/fishing_effort_form.dart';
import '../model/forms/limits_form.dart';
import '../model/forms/semi_annual_report_form.dart';
import '../model/forms/technical_report_form.dart';
import '../model/shared/agreement.dart';
import 'package:flutter/cupertino.dart';

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
import '../model/forms/organization_info_form.dart';
import '../model/forms/shell_collection_form.dart';
import '../model/forms/shell_size_form.dart';
import '../model/forms/social_indicators_form.dart';
import '../model/shared/document_project.dart';
import '../model/shared/evidence_activity.dart';
import '../model/shared/file_form.dart';
import '../model/shared/org_mapping.dart';
import '../model/shared/planned_activity.dart';
import '../model/shared/price_daily.dart';
import '../repository/info_form_repository.dart';
import '../../../plugins/upload.dart';
import '../../../shared/form/model/data.dart';
import '../../../shared/form/model/form_config.dart';
import '../../../util/user.dart';
import '../../../util/utility.dart';
import '../../../constants.dart';
import '../../../shared/anomalyForm/controller/offline_controller.dart';

class InfoFormSaveController {
  final infoFormRepository = InfoFormRepository();
  final _offlineController = OfflineController();

  BuildContext _context;

  final List<String> _offlineForms = [
    'shell-collection-form',
    'crab-collection-form',
    'evidence-form'
  ];

  Future<bool> save(FormConfig formConfig, context) async {
    _context = context;
    int userId = int.tryParse(User.userId);
    int orgId = int.tryParse(User.organizationManglarId);
    String formType = formConfig.idReport;

    FormToSave formToSave =
        _getData(formType, formConfig, userId, orgId, false);
    if (User.hasInternetConnection) {
      return await _saveOnline(context, formToSave);
    } else {
      return await _saveOffline(context, formType, formToSave.data);
    }
  }

  Future<bool> saveFromLocalStorage(context) async {
    bool success = true;
    for (String formType in _offlineForms) {
      bool successSave =
          await _saveFromLocalStorageByFormType(context, formType);
      if (!successSave) success = false;
    }
    return success;
  }

  Future<bool> _saveOffline(context, String formType, String data) async {
    if (_offlineForms.indexOf(formType) < 0 || !User.hasOfflineMode()) {
      Utility.showToast(
          context, 'Este formulario solo se guarda con conexión a internet');
      return false;
    }
    String msg = 'Se guardará cuando tenga internet';
    bool success = true;
    Utility.showLoading(context);
    try {
      await _offlineController.saveToLocalStorage(formType, data);
    } catch (e) {
      print('Error $e');
      msg = 'Error no se pudo guardar en local';
      success = false;
    }
    Utility.dismissLoading(context);
    Utility.showToast(context, msg);
    return success;
  }

  Future<bool> _saveFromLocalStorageByFormType(context, String formType) async {
    List<String> formsIds = await _offlineController.getFormsOnLocal(formType);
    if (formsIds.length == 0) return true;

    bool success = true;
    int userId = int.tryParse(User.userId);
    int orgId = int.tryParse(User.organizationManglarId);
    for (String formId in formsIds) {
      String formData = await Utility.getLocalStorage(formId);
      if (formData == 'null') {
        await _offlineController.removeFormsOnLocal(formType, formId);
        return success;
      }
      FormToSave formToSave = _getData(formType, formData, userId, orgId, true);
      bool successSaveForm = await _saveOnline(context, formToSave);
      if (!successSaveForm) success = false;
      await _offlineController.removeFormsOnLocal(formType, formId);
    }
    return success;
  }

  Future<bool> _saveOnline(context, FormToSave formToSave) async {
    Utility.showLoading(context,
        msg: 'Guardando formulario por favor no cerrar la app');
    String msg = 'Formulario guardado correctamente';
    bool successSaveFiles = await saveFiles(formToSave.fileForms);
    if (!successSaveFiles) {
      msg = 'Error al guardar los archivos del formulario';
    }
    Data result = await _saveData(context, formToSave);
    bool successSaveForm = result.state == 'OK';
    if (!successSaveForm) {
      msg = 'Error al guardar formulario';
    }
    Utility.dismissLoading(context);
    Utility.showToast(context, msg);
    return successSaveForm;
  }

  Future<Data> _saveData(context, FormToSave formToSave) async {
    String data = formToSave.data;
    switch (formToSave.formType) {
      case 'official-docs-form':
        return await infoFormRepository.saveOfficialDocs(data);
      case 'prices-form':
        return await infoFormRepository.savePricesForm(data);
      case 'desc-projects-form':
        return await infoFormRepository.saveDescProjects(data);
      case 'investments-orgs-form':
        return await infoFormRepository.saveInvestmentsOrgs(data);
      case 'economic-indicators-form':
        return await infoFormRepository.saveEconomicIndicators(data);
      case 'plan-tracking-form':
        return await infoFormRepository.savePlanTracking(data);
      case 'info-veda-form':
        return await infoFormRepository.saveInfoVeda(data);
      case 'shell-size-form':
        return await infoFormRepository.saveShellSize(data);
      case 'crab-size-form':
        return await infoFormRepository.saveCrabSize(data);
      case 'deforestation-form':
        return await infoFormRepository.saveDeforestation(data);
      case 'reforestation-form':
        return await infoFormRepository.saveReforestation(data);
      case 'control-form':
        return await infoFormRepository.saveControl(data);
      case 'organization-info-form':
        return await infoFormRepository.saveOrganizationInfo(data);
      case 'shell-collection-form':
        return await infoFormRepository.saveShellCollection(data);
      case 'crab-collection-form':
        return await infoFormRepository.saveCrabCollection(data);
      case 'evidence-form':
        return await infoFormRepository.saveEvidence(data);
      case 'management-plan-form':
        return await infoFormRepository.saveManagementPlan(data);
      case 'mapping-form':
        return await infoFormRepository.saveMappingForm(data);
      case 'limits-form':
        return await infoFormRepository.saveLimitsForm(data);
      case 'social-indicators-form':
        return await infoFormRepository.saveSocialIndicators(data);
      case 'semi-annual-report-form':
        return await infoFormRepository.saveSemiAnnualReport(data);
      case 'technical-report-form':
        return await infoFormRepository.saveTechnicalReport(data);
      case 'fishing-effort-form':
        return await infoFormRepository.saveFishingEffort(data);
      default:
        throw 'Add save config for ${formToSave.formType}';
    }
  }

  FormToSave _getData(String formType, dynamic formConfig, int userId,
      int orgId, bool fromString) {
    switch (formType) {
      case 'official-docs-form':
        OfficialDocsForm form = fromString
            ? OfficialDocsForm.fromJson(json.decode(formConfig))
            : OfficialDocsForm.fromFormConfig(formConfig, userId, orgId);
        List<FileForm> fileForms = [];
        for (Agreement agreement in form.agreements) {
          fileForms.addAll(agreement.fileForms);
        }
        fileForms.addAll(form.fileForms);
        return FormToSave(
            data: json.encode(form.toJson()),
            fileForms: fileForms,
            formType: formType);
      case 'prices-form':
        PricesForm form = fromString
            ? PricesForm.fromJson(json.decode(formConfig))
            : PricesForm.fromFormConfig(formConfig, userId, orgId);
        List<FileForm> fileForms = [];
        for (PriceDaily priceDaily in form.priceDailies) {
          fileForms.addAll(priceDaily.fileForms);
        }
        return FormToSave(
            data: json.encode(form.toJson()),
            fileForms: fileForms,
            formType: formType);
      case 'desc-projects-form':
        DescProjectsForm form = fromString
            ? DescProjectsForm.fromJson(json.decode(formConfig))
            : DescProjectsForm.fromFormConfig(formConfig, userId, orgId);
        List<FileForm> fileForms = [];
        for (DocumentProject documentProject in form.documentProjects) {
          fileForms.addAll(documentProject.fileForms);
        }
        return FormToSave(
            data: json.encode(form.toJson()),
            fileForms: fileForms,
            formType: formType);
      case 'investments-orgs-form':
        InvestmentsOrgsForm form = fromString
            ? InvestmentsOrgsForm.fromJson(json.decode(formConfig))
            : InvestmentsOrgsForm.fromFormConfig(formConfig, userId, orgId);
        return FormToSave(
            data: json.encode(form.toJson()),
            fileForms: [],
            formType: formType);
      case 'economic-indicators-form':
        EconomicIndicatorsForm form = fromString
            ? EconomicIndicatorsForm.fromJson(json.decode(formConfig))
            : EconomicIndicatorsForm.fromFormConfig(formConfig, userId, orgId);
        return FormToSave(
            data: json.encode(form.toJson()),
            fileForms: [],
            formType: formType);
      case 'plan-tracking-form':
        PlanTrackingForm form = fromString
            ? PlanTrackingForm.fromJson(json.decode(formConfig))
            : PlanTrackingForm.fromFormConfig(formConfig, userId, orgId);
        return FormToSave(
            data: json.encode(form.toJson()),
            fileForms: [],
            formType: formType);
      case 'info-veda-form':
        InfoVedaForm form = fromString
            ? InfoVedaForm.fromJson(json.decode(formConfig))
            : InfoVedaForm.fromFormConfig(formConfig, userId, orgId);
        return FormToSave(
            data: json.encode(form.toJson()),
            fileForms: [],
            formType: formType);
      case 'shell-size-form':
        ShellSizeForm form = fromString
            ? ShellSizeForm.fromJson(json.decode(formConfig))
            : ShellSizeForm.fromFormConfig(formConfig, userId, orgId);
        return FormToSave(
            data: json.encode(form.toJson()),
            fileForms: [],
            formType: formType);
      case 'crab-size-form':
        CrabSizeForm form = fromString
            ? CrabSizeForm.fromJson(json.decode(formConfig))
            : CrabSizeForm.fromFormConfig(formConfig, userId, orgId);
        return FormToSave(
            data: json.encode(form.toJson()),
            fileForms: [],
            formType: formType);
      case 'deforestation-form':
        DeforestationForm form = fromString
            ? DeforestationForm.fromJson(json.decode(formConfig))
            : DeforestationForm.fromFormConfig(formConfig, userId, orgId);
        return FormToSave(
            data: json.encode(form.toJson()),
            fileForms: [],
            formType: formType);
      case 'reforestation-form':
        ReforestationForm form = fromString
            ? ReforestationForm.fromJson(json.decode(formConfig))
            : ReforestationForm.fromFormConfig(formConfig, userId, orgId);
        return FormToSave(
            data: json.encode(form.toJson()),
            fileForms: [],
            formType: formType);
      case 'control-form':
        ControlForm form = fromString
            ? ControlForm.fromJson(json.decode(formConfig))
            : ControlForm.fromFormConfig(formConfig, userId, orgId);
        return FormToSave(
            data: json.encode(form.toJson()),
            fileForms: form.fileForms,
            formType: formType);
      case 'organization-info-form':
        OrganizationInfoForm form = fromString
            ? OrganizationInfoForm.fromJson(json.decode(formConfig))
            : OrganizationInfoForm.fromFormConfig(formConfig, userId, orgId);
        return FormToSave(
            data: json.encode(form.toJson()),
            fileForms: form.fileForms,
            formType: formType);
      case 'shell-collection-form':
        ShellCollectionForm form = fromString
            ? ShellCollectionForm.fromJson(json.decode(formConfig))
            : ShellCollectionForm.fromFormConfig(formConfig, userId, orgId);
        return FormToSave(
            data: json.encode(form.toJson()),
            fileForms: [],
            formType: formType);
      case 'crab-collection-form':
        CrabCollectionForm form = fromString
            ? CrabCollectionForm.fromJson(json.decode(formConfig))
            : CrabCollectionForm.fromFormConfig(formConfig, userId, orgId);
        return FormToSave(
            data: json.encode(form.toJson()),
            fileForms: [],
            formType: formType);
      case 'evidence-form':
        EvidenceForm form = fromString
            ? EvidenceForm.fromJson(json.decode(formConfig))
            : EvidenceForm.fromFormConfig(formConfig, userId, orgId);
        List<FileForm> fileForms = [];
        for (EvidenceActivity subForm in form.evidenceActivities) {
          fileForms.addAll(subForm.fileForms);
        }
        return FormToSave(
            data: json.encode(form.toJson()),
            fileForms: fileForms,
            formType: formType);
      case 'management-plan-form':
        ManagementPlanForm form = fromString
            ? ManagementPlanForm.fromJson(json.decode(formConfig))
            : ManagementPlanForm.fromFormConfig(formConfig, userId, orgId);
        return FormToSave(
            data: json.encode(form.toJson()),
            fileForms: [],
            formType: formType);
      case 'mapping-form':
        MappingForm form = fromString
            ? MappingForm.fromJson(json.decode(formConfig))
            : MappingForm.fromFormConfig(formConfig, userId, orgId);
        List<FileForm> fileForms = [];
        for (OrgMapping f in form.orgsMapping) {
          fileForms.addAll(f.fileForms);
        }
        return FormToSave(
            data: json.encode(form.toJson()),
            fileForms: fileForms,
            formType: formType);
      case 'limits-form':
        LimitsForm form = fromString
            ? LimitsForm.fromJson(json.decode(formConfig))
            : LimitsForm.fromFormConfig(formConfig, userId, orgId);
        List<FileForm> fileForms = [];
        for (OrgMapping f in form.orgsMapping) {
          fileForms.addAll(f.fileForms);
        }
        return FormToSave(
            data: json.encode(form.toJson()),
            fileForms: fileForms,
            formType: formType);
      case 'semi-annual-report-form':
        SemiAnnualReportForm form = fromString
            ? SemiAnnualReportForm.fromJson(json.decode(formConfig))
            : SemiAnnualReportForm.fromFormConfig(formConfig, userId, orgId);
        return FormToSave(
            data: json.encode(form.toJson()),
            fileForms: form.fileForms,
            formType: formType);
      case 'technical-report-form':
        TechnicalReportForm form = fromString
            ? TechnicalReportForm.fromJson(json.decode(formConfig))
            : TechnicalReportForm.fromFormConfig(formConfig, userId, orgId);
        return FormToSave(
            data: json.encode(form.toJson()),
            fileForms: form.fileForms,
            formType: formType);
      case 'fishing-effort-form':
        FishingEffortForm form = fromString
            ? FishingEffortForm.fromJson(json.decode(formConfig))
            : FishingEffortForm.fromFormConfig(formConfig, userId, orgId);
        return FormToSave(
            data: json.encode(form.toJson()),
            fileForms: [],
            formType: formType);
      case 'social-indicators-form':
        SocialIndicatorsForm form = fromString
            ? SocialIndicatorsForm.fromJson(json.decode(formConfig))
            : SocialIndicatorsForm.fromFormConfig(formConfig, userId, orgId);
        return FormToSave(
            data: json.encode(form.toJson()),
            fileForms: [],
            formType: formType);
      default:
        throw 'Add save config for ${formConfig.idReport}';
    }
  }

  Future<bool> saveFiles(List<FileForm> fileForms) async {
    if (Constants.isWeb) {
      List<FileForm> filesNotEmpty = fileForms
          .where((FileForm file) => !file.isEmpty() && file.base64 != null)
          .toList();
      return await _saveWeb(filesNotEmpty);
    }
    List<FileForm> filesNotEmpty = fileForms
        .where((FileForm file) => !file.isEmpty() && file.pathOrigin != null)
        .toList();
    return await _saveMovil(filesNotEmpty);
  }

  Future<bool> _saveMovil(List<FileForm> fileForms) async {
    bool success = true;
    for (FileForm file in fileForms) {
      String uploadURL = '${Constants.hostUrl}rest/file/upload';
      String nameFile = file.name;
      String imagePath = file.pathOrigin;
      try {
        File imageFile = File(imagePath);
        String stateUpload =
            await Upload.uploadFile(imageFile, uploadURL, nameFile);
        if (stateUpload != 'OK') {
          success = false;
          Utility.showToast(_context, 'ERROR foto $nameFile s:$stateUpload');
        }
      } catch (e) {
        success = false;
        Utility.showToast(_context, 'ERROR foto $nameFile $e');
      }
    }
    return success;
  }

  Future<bool> _saveWeb(List<FileForm> fileForms) async {
    print('save web ${fileForms.length}');
    bool success = true;
    for (FileForm file in fileForms) {
      String uploadURL = '${Constants.hostUrl}rest/file/upload';
      String nameFile = file.name;
      String source = file.base64.split('base64,').asMap()[1];
      try {
        String stateUpload =
            await Upload.uploadFileFromBase64Str(source, uploadURL, nameFile);
        if (stateUpload != 'OK') {
          success = false;
          Utility.showToast(_context, 'ERROR foto $nameFile s:$stateUpload');
        }
      } catch (e) {
        success = false;
        Utility.showToast(_context, 'ERROR foto $nameFile $e');
      }
    }
    return success;
  }
}

class FormToSave {
  final String data;
  final String formType;
  final List<FileForm> fileForms;

  FormToSave({
    @required this.data,
    @required this.formType,
    @required this.fileForms,
  });
}
