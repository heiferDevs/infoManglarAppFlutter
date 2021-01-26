
import '../../../../shared/form/model/form_config.dart';
import '../../../../util/utility.dart';

import '../shared/file_form.dart';

class OrganizationInfoForm{

  int organizationInfoFormId;
  int userId;
  int organizationManglarId;
  String formType;

  bool cumpleReglaNoEnajenar;
  bool cumpleReglaNoAmpliar;
  bool cumpleReglaBuenaVecindad;
  bool pescadoresIndependientes;
  bool pescadoresDeOtrasOrgs;
  bool denuncioPescadoresNoAutorizados;
  bool todosRecurosBioacuaticos;
  bool pescaFueraDelManglar;
  bool actividadesDeCria;
  bool cumpleNormasCria;
  bool devuelveIndividuosDecomisados;
  bool actividadesTurismo;
  bool normativaTuristica;
  bool cuentaSocioManglar;
  bool actividadesEducacionAmbiental;
  bool actividadesInvestigacion;
  bool cuentaConPermisos;
  bool evidencioMuerteArboles;
  bool evidencioMuerteBioacuaticos;
  bool evidencioMuerteFlora;
  bool evidencioMuerteFauna;
  bool cambiosEnAgua;
  bool cambiosSuelo;
  bool cambiosClima;
  bool cambiosTemperatura;

  String cumpleReglaNoEnajenarDesc;
  String cumpleReglaNoAmpliarDesc;
  String cumpleReglaBuenaVecindadDesc;
  String pescadoresIndependientesDesc;
  String pescadoresDeOtrasOrgsDesc;
  String denuncioPescadoresNoAutorizadosDesc;
  String todosRecurosBioacuaticosDesc;
  String pescaFueraDelManglarDesc;
  String actividadesDeCriaDesc;
  String cumpleNormasCriaDesc;
  String devuelveIndividuosDecomisadosDesc;
  String actividadesTurismoDesc;
  String normativaTuristicaDesc;
  String cuentaSocioManglarDesc;
  String actividadesEducacionAmbientalDesc;
  String actividadesInvestigacionDesc;
  String cuentaConPermisosDesc;
  String evidencioMuerteArbolesDesc;
  String evidencioMuerteBioacuaticosDesc;
  String evidencioMuerteFloraDesc;
  String evidencioMuerteFaunaDesc;
  String cambiosEnAguaDesc;
  String cambiosSueloDesc;
  String cambiosClimaDesc;
  String cambiosTemperaturaDesc;

  List<FileForm> fileForms;

  OrganizationInfoForm({
    this.organizationInfoFormId,
    this.formType,
    this.userId,
    this.organizationManglarId,
    this.fileForms,
    this.cumpleReglaNoEnajenar,
    this.cumpleReglaNoAmpliar,
    this.cumpleReglaBuenaVecindad,
    this.pescadoresIndependientes,
    this.pescadoresDeOtrasOrgs,
    this.denuncioPescadoresNoAutorizados,
    this.todosRecurosBioacuaticos,
    this.pescaFueraDelManglar,
    this.actividadesDeCria,
    this.cumpleNormasCria,
    this.devuelveIndividuosDecomisados,
    this.actividadesTurismo,
    this.normativaTuristica,
    this.cuentaSocioManglar,
    this.actividadesEducacionAmbiental,
    this.actividadesInvestigacion,
    this.cuentaConPermisos,
    this.evidencioMuerteArboles,
    this.evidencioMuerteBioacuaticos,
    this.evidencioMuerteFlora,
    this.evidencioMuerteFauna,
    this.cambiosEnAgua,
    this.cambiosSuelo,
    this.cambiosClima,
    this.cambiosTemperatura,
    this.cumpleReglaNoEnajenarDesc,
    this.cumpleReglaNoAmpliarDesc,
    this.cumpleReglaBuenaVecindadDesc,
    this.pescadoresIndependientesDesc,
    this.pescadoresDeOtrasOrgsDesc,
    this.denuncioPescadoresNoAutorizadosDesc,
    this.todosRecurosBioacuaticosDesc,
    this.pescaFueraDelManglarDesc,
    this.actividadesDeCriaDesc,
    this.cumpleNormasCriaDesc,
    this.devuelveIndividuosDecomisadosDesc,
    this.actividadesTurismoDesc,
    this.normativaTuristicaDesc,
    this.cuentaSocioManglarDesc,
    this.actividadesEducacionAmbientalDesc,
    this.actividadesInvestigacionDesc,
    this.cuentaConPermisosDesc,
    this.evidencioMuerteArbolesDesc,
    this.evidencioMuerteBioacuaticosDesc,
    this.evidencioMuerteFloraDesc,
    this.evidencioMuerteFaunaDesc,
    this.cambiosEnAguaDesc,
    this.cambiosSueloDesc,
    this.cambiosClimaDesc,
    this.cambiosTemperaturaDesc,
  });

  factory OrganizationInfoForm.fromFormConfig(FormConfig formConfig, int userId, int organizationManglarId) {
    List<FileForm> fileForms = [
      FileForm.fromOption(formConfig.getOption('cumpleReglaNoEnajenarEvidencia')),
      FileForm.fromOption(formConfig.getOption('cumpleReglaNoAmpliarEvidencia')),
      FileForm.fromOption(formConfig.getOption('cumpleReglaBuenaVecindadEvidencia')),
      FileForm.fromOption(formConfig.getOption('pescadoresIndependientesEvidencia')),
      FileForm.fromOption(formConfig.getOption('pescadoresDeOtrasOrgsEvidencia')),
      FileForm.fromOption(formConfig.getOption('denuncioPescadoresNoAutorizadosEvidencia')),
      FileForm.fromOption(formConfig.getOption('todosRecurosBioacuaticosEvidencia')),
      FileForm.fromOption(formConfig.getOption('pescaFueraDelManglarEvidencia')),
      FileForm.fromOption(formConfig.getOption('actividadesDeCriaEvidencia')),
      FileForm.fromOption(formConfig.getOption('cumpleNormasCriaEvidencia')),
      FileForm.fromOption(formConfig.getOption('devuelveIndividuosDecomisadosEvidencia')),
      FileForm.fromOption(formConfig.getOption('actividadesTurismoEvidencia')),
      FileForm.fromOption(formConfig.getOption('normativaTuristicaEvidencia')),
      FileForm.fromOption(formConfig.getOption('cuentaSocioManglarEvidencia')),
      FileForm.fromOption(formConfig.getOption('actividadesEducacionAmbientalEvidencia')),
      FileForm.fromOption(formConfig.getOption('actividadesInvestigacionEvidencia')),
      FileForm.fromOption(formConfig.getOption('cuentaConPermisosEvidencia')),
      FileForm.fromOption(formConfig.getOption('evidencioMuerteArbolesEvidencia')),
      FileForm.fromOption(formConfig.getOption('evidencioMuerteBioacuaticosEvidencia')),
      FileForm.fromOption(formConfig.getOption('evidencioMuerteFloraEvidencia')),
      FileForm.fromOption(formConfig.getOption('evidencioMuerteFaunaEvidencia')),
      FileForm.fromOption(formConfig.getOption('cambiosEnAguaEvidencia')),
      FileForm.fromOption(formConfig.getOption('cambiosSueloEvidencia')),
      FileForm.fromOption(formConfig.getOption('cambiosClimaEvidencia')),
      FileForm.fromOption(formConfig.getOption('cambiosTemperaturaEvidencia')),
    ];
    return OrganizationInfoForm(
      organizationInfoFormId: formConfig.idForm,
      formType: formConfig.idReport,
      userId: userId,
      organizationManglarId: organizationManglarId,
      fileForms: Utility.filterNull(fileForms),
      cumpleReglaNoEnajenar: formConfig.getValue('cumpleReglaNoEnajenar'),
      cumpleReglaNoAmpliar: formConfig.getValue('cumpleReglaNoAmpliar'),
      cumpleReglaBuenaVecindad: formConfig.getValue('cumpleReglaBuenaVecindad'),
      pescadoresIndependientes: formConfig.getValue('pescadoresIndependientes'),
      pescadoresDeOtrasOrgs: formConfig.getValue('pescadoresDeOtrasOrgs'),
      denuncioPescadoresNoAutorizados: formConfig.getValue('denuncioPescadoresNoAutorizados'),
      todosRecurosBioacuaticos: formConfig.getValue('todosRecurosBioacuaticos'),
      pescaFueraDelManglar: formConfig.getValue('pescaFueraDelManglar'),
      actividadesDeCria: formConfig.getValue('actividadesDeCria'),
      cumpleNormasCria: formConfig.getValue('cumpleNormasCria'),
      devuelveIndividuosDecomisados: formConfig.getValue('devuelveIndividuosDecomisados'),
      actividadesTurismo: formConfig.getValue('actividadesTurismo'),
      normativaTuristica: formConfig.getValue('normativaTuristica'),
      cuentaSocioManglar: formConfig.getValue('cuentaSocioManglar'),
      actividadesEducacionAmbiental: formConfig.getValue('actividadesEducacionAmbiental'),
      actividadesInvestigacion: formConfig.getValue('actividadesInvestigacion'),
      cuentaConPermisos: formConfig.getValue('cuentaConPermisos'),
      evidencioMuerteArboles: formConfig.getValue('evidencioMuerteArboles'),
      evidencioMuerteBioacuaticos: formConfig.getValue('evidencioMuerteBioacuaticos'),
      evidencioMuerteFlora: formConfig.getValue('evidencioMuerteFlora'),
      evidencioMuerteFauna: formConfig.getValue('evidencioMuerteFauna'),
      cambiosEnAgua: formConfig.getValue('cambiosEnAgua'),
      cambiosSuelo: formConfig.getValue('cambiosSuelo'),
      cambiosClima: formConfig.getValue('cambiosClima'),
      cambiosTemperatura: formConfig.getValue('cambiosTemperatura'),
      cumpleReglaNoEnajenarDesc: formConfig.getValue('cumpleReglaNoEnajenarDesc'),
      cumpleReglaNoAmpliarDesc: formConfig.getValue('cumpleReglaNoAmpliarDesc'),
      cumpleReglaBuenaVecindadDesc: formConfig.getValue('cumpleReglaBuenaVecindadDesc'),
      pescadoresIndependientesDesc: formConfig.getValue('pescadoresIndependientesDesc'),
      pescadoresDeOtrasOrgsDesc: formConfig.getValue('pescadoresDeOtrasOrgsDesc'),
      denuncioPescadoresNoAutorizadosDesc: formConfig.getValue('denuncioPescadoresNoAutorizadosDesc'),
      todosRecurosBioacuaticosDesc: formConfig.getValue('todosRecurosBioacuaticosDesc'),
      pescaFueraDelManglarDesc: formConfig.getValue('pescaFueraDelManglarDesc'),
      actividadesDeCriaDesc: formConfig.getValue('actividadesDeCriaDesc'),
      cumpleNormasCriaDesc: formConfig.getValue('cumpleNormasCriaDesc'),
      devuelveIndividuosDecomisadosDesc: formConfig.getValue('devuelveIndividuosDecomisadosDesc'),
      actividadesTurismoDesc: formConfig.getValue('actividadesTurismoDesc'),
      normativaTuristicaDesc: formConfig.getValue('normativaTuristicaDesc'),
      cuentaSocioManglarDesc: formConfig.getValue('cuentaSocioManglarDesc'),
      actividadesEducacionAmbientalDesc: formConfig.getValue('actividadesEducacionAmbientalDesc'),
      actividadesInvestigacionDesc: formConfig.getValue('actividadesInvestigacionDesc'),
      cuentaConPermisosDesc: formConfig.getValue('cuentaConPermisosDesc'),
      evidencioMuerteArbolesDesc: formConfig.getValue('evidencioMuerteArbolesDesc'),
      evidencioMuerteBioacuaticosDesc: formConfig.getValue('evidencioMuerteBioacuaticosDesc'),
      evidencioMuerteFloraDesc: formConfig.getValue('evidencioMuerteFloraDesc'),
      evidencioMuerteFaunaDesc: formConfig.getValue('evidencioMuerteFaunaDesc'),
      cambiosEnAguaDesc: formConfig.getValue('cambiosEnAguaDesc'),
      cambiosSueloDesc: formConfig.getValue('cambiosSueloDesc'),
      cambiosClimaDesc: formConfig.getValue('cambiosClimaDesc'),
      cambiosTemperaturaDesc: formConfig.getValue('cambiosTemperaturaDesc'),
    );
  }

  factory OrganizationInfoForm.fromJson(Map<String, dynamic> json) {
    List<FileForm> fileFormsFromJson = json['fileForms'].map<FileForm>( (f) => FileForm.fromJson(f)).toList();
    return OrganizationInfoForm(
      organizationInfoFormId: json['organizationInfoFormId'],
      formType: json['formType'],
      userId: json['userId'],
      organizationManglarId: json['organizationManglarId'],
      fileForms: fileFormsFromJson,
      cumpleReglaNoEnajenar: json['cumpleReglaNoEnajenar'],
      cumpleReglaNoAmpliar: json['cumpleReglaNoAmpliar'],
      cumpleReglaBuenaVecindad: json['cumpleReglaBuenaVecindad'],
      pescadoresIndependientes: json['pescadoresIndependientes'],
      pescadoresDeOtrasOrgs: json['pescadoresDeOtrasOrgs'],
      denuncioPescadoresNoAutorizados: json['denuncioPescadoresNoAutorizados'],
      todosRecurosBioacuaticos: json['todosRecurosBioacuaticos'],
      pescaFueraDelManglar: json['pescaFueraDelManglar'],
      actividadesDeCria: json['actividadesDeCria'],
      cumpleNormasCria: json['cumpleNormasCria'],
      devuelveIndividuosDecomisados: json['devuelveIndividuosDecomisados'],
      actividadesTurismo: json['actividadesTurismo'],
      normativaTuristica: json['normativaTuristica'],
      cuentaSocioManglar: json['cuentaSocioManglar'],
      actividadesEducacionAmbiental: json['actividadesEducacionAmbiental'],
      actividadesInvestigacion: json['actividadesInvestigacion'],
      cuentaConPermisos: json['cuentaConPermisos'],
      evidencioMuerteArboles: json['evidencioMuerteArboles'],
      evidencioMuerteBioacuaticos: json['evidencioMuerteBioacuaticos'],
      evidencioMuerteFlora: json['evidencioMuerteFlora'],
      evidencioMuerteFauna: json['evidencioMuerteFauna'],
      cambiosEnAgua: json['cambiosEnAgua'],
      cambiosSuelo: json['cambiosSuelo'],
      cambiosClima: json['cambiosClima'],
      cambiosTemperatura: json['cambiosTemperatura'],
      cumpleReglaNoEnajenarDesc: json['cumpleReglaNoEnajenarDesc'],
      cumpleReglaNoAmpliarDesc: json['cumpleReglaNoAmpliarDesc'],
      cumpleReglaBuenaVecindadDesc: json['cumpleReglaBuenaVecindadDesc'],
      pescadoresIndependientesDesc: json['pescadoresIndependientesDesc'],
      pescadoresDeOtrasOrgsDesc: json['pescadoresDeOtrasOrgsDesc'],
      denuncioPescadoresNoAutorizadosDesc: json['denuncioPescadoresNoAutorizadosDesc'],
      todosRecurosBioacuaticosDesc: json['todosRecurosBioacuaticosDesc'],
      pescaFueraDelManglarDesc: json['pescaFueraDelManglarDesc'],
      actividadesDeCriaDesc: json['actividadesDeCriaDesc'],
      cumpleNormasCriaDesc: json['cumpleNormasCriaDesc'],
      devuelveIndividuosDecomisadosDesc: json['devuelveIndividuosDecomisadosDesc'],
      actividadesTurismoDesc: json['actividadesTurismoDesc'],
      normativaTuristicaDesc: json['normativaTuristicaDesc'],
      cuentaSocioManglarDesc: json['cuentaSocioManglarDesc'],
      actividadesEducacionAmbientalDesc: json['actividadesEducacionAmbientalDesc'],
      actividadesInvestigacionDesc: json['actividadesInvestigacionDesc'],
      cuentaConPermisosDesc: json['cuentaConPermisosDesc'],
      evidencioMuerteArbolesDesc: json['evidencioMuerteArbolesDesc'],
      evidencioMuerteBioacuaticosDesc: json['evidencioMuerteBioacuaticosDesc'],
      evidencioMuerteFloraDesc: json['evidencioMuerteFloraDesc'],
      evidencioMuerteFaunaDesc: json['evidencioMuerteFaunaDesc'],
      cambiosEnAguaDesc: json['cambiosEnAguaDesc'],
      cambiosSueloDesc: json['cambiosSueloDesc'],
      cambiosClimaDesc: json['cambiosClimaDesc'],
      cambiosTemperaturaDesc: json['cambiosTemperaturaDesc'],
    );
  }


  // TO SAVE
  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> fileFormsJson = fileForms
      .map<Map<String, dynamic>>( (FileForm f) => f.toJson() ).toList();
    Map<String, dynamic>  mapJson = {};
    mapJson['organizationInfoFormId'] = organizationInfoFormId;
    mapJson['formType'] = formType;
    mapJson['userId'] = userId;
    mapJson['organizationManglarId'] = organizationManglarId;
    mapJson['fileForms'] = Utility.filterNull(fileFormsJson);
    mapJson['cumpleReglaNoEnajenar'] = cumpleReglaNoEnajenar;
    mapJson['cumpleReglaNoAmpliar'] = cumpleReglaNoAmpliar;
    mapJson['cumpleReglaBuenaVecindad'] = cumpleReglaBuenaVecindad;
    mapJson['pescadoresIndependientes'] = pescadoresIndependientes;
    mapJson['pescadoresDeOtrasOrgs'] = pescadoresDeOtrasOrgs;
    mapJson['denuncioPescadoresNoAutorizados'] = denuncioPescadoresNoAutorizados;
    mapJson['todosRecurosBioacuaticos'] = todosRecurosBioacuaticos;
    mapJson['pescaFueraDelManglar'] = pescaFueraDelManglar;
    mapJson['actividadesDeCria'] = actividadesDeCria;
    mapJson['cumpleNormasCria'] = cumpleNormasCria;
    mapJson['devuelveIndividuosDecomisados'] = devuelveIndividuosDecomisados;
    mapJson['actividadesTurismo'] = actividadesTurismo;
    mapJson['normativaTuristica'] = normativaTuristica;
    mapJson['cuentaSocioManglar'] = cuentaSocioManglar;
    mapJson['actividadesEducacionAmbiental'] = actividadesEducacionAmbiental;
    mapJson['actividadesInvestigacion'] = actividadesInvestigacion;
    mapJson['cuentaConPermisos'] = cuentaConPermisos;
    mapJson['evidencioMuerteArboles'] = evidencioMuerteArboles;
    mapJson['evidencioMuerteBioacuaticos'] = evidencioMuerteBioacuaticos;
    mapJson['evidencioMuerteFlora'] = evidencioMuerteFlora;
    mapJson['evidencioMuerteFauna'] = evidencioMuerteFauna;
    mapJson['cambiosEnAgua'] = cambiosEnAgua;
    mapJson['cambiosSuelo'] = cambiosSuelo;
    mapJson['cambiosClima'] = cambiosClima;
    mapJson['cambiosTemperatura'] = cambiosTemperatura;
    mapJson['cumpleReglaNoEnajenarDesc'] = cumpleReglaNoEnajenarDesc;
    mapJson['cumpleReglaNoAmpliarDesc'] = cumpleReglaNoAmpliarDesc;
    mapJson['cumpleReglaBuenaVecindadDesc'] = cumpleReglaBuenaVecindadDesc;
    mapJson['pescadoresIndependientesDesc'] = pescadoresIndependientesDesc;
    mapJson['pescadoresDeOtrasOrgsDesc'] = pescadoresDeOtrasOrgsDesc;
    mapJson['denuncioPescadoresNoAutorizadosDesc'] = denuncioPescadoresNoAutorizadosDesc;
    mapJson['todosRecurosBioacuaticosDesc'] = todosRecurosBioacuaticosDesc;
    mapJson['pescaFueraDelManglarDesc'] = pescaFueraDelManglarDesc;
    mapJson['actividadesDeCriaDesc'] = actividadesDeCriaDesc;
    mapJson['cumpleNormasCriaDesc'] = cumpleNormasCriaDesc;
    mapJson['devuelveIndividuosDecomisadosDesc'] = devuelveIndividuosDecomisadosDesc;
    mapJson['actividadesTurismoDesc'] = actividadesTurismoDesc;
    mapJson['normativaTuristicaDesc'] = normativaTuristicaDesc;
    mapJson['cuentaSocioManglarDesc'] = cuentaSocioManglarDesc;
    mapJson['actividadesEducacionAmbientalDesc'] = actividadesEducacionAmbientalDesc;
    mapJson['actividadesInvestigacionDesc'] = actividadesInvestigacionDesc;
    mapJson['cuentaConPermisosDesc'] = cuentaConPermisosDesc;
    mapJson['evidencioMuerteArbolesDesc'] = evidencioMuerteArbolesDesc;
    mapJson['evidencioMuerteBioacuaticosDesc'] = evidencioMuerteBioacuaticosDesc;
    mapJson['evidencioMuerteFloraDesc'] = evidencioMuerteFloraDesc;
    mapJson['evidencioMuerteFaunaDesc'] = evidencioMuerteFaunaDesc;
    mapJson['cambiosEnAguaDesc'] = cambiosEnAguaDesc;
    mapJson['cambiosSueloDesc'] = cambiosSueloDesc;
    mapJson['cambiosClimaDesc'] = cambiosClimaDesc;
    mapJson['cambiosTemperaturaDesc'] = cambiosTemperaturaDesc;
    return Utility.removeNull(mapJson);
  }

  FormConfig updateFormConfig(FormConfig formConfig){
    formConfig.getOption('cumpleReglaNoEnajenar').setValueInit(cumpleReglaNoEnajenar);
    formConfig.getOption('cumpleReglaNoAmpliar').setValueInit(cumpleReglaNoAmpliar);
    formConfig.getOption('cumpleReglaBuenaVecindad').setValueInit(cumpleReglaBuenaVecindad);
    formConfig.getOption('pescadoresIndependientes').setValueInit(pescadoresIndependientes);
    formConfig.getOption('pescadoresDeOtrasOrgs').setValueInit(pescadoresDeOtrasOrgs);
    formConfig.getOption('denuncioPescadoresNoAutorizados').setValueInit(denuncioPescadoresNoAutorizados);
    formConfig.getOption('todosRecurosBioacuaticos').setValueInit(todosRecurosBioacuaticos);
    formConfig.getOption('pescaFueraDelManglar').setValueInit(pescaFueraDelManglar);
    formConfig.getOption('actividadesDeCria').setValueInit(actividadesDeCria);
    formConfig.getOption('cumpleNormasCria').setValueInit(cumpleNormasCria);
    formConfig.getOption('devuelveIndividuosDecomisados').setValueInit(devuelveIndividuosDecomisados);
    formConfig.getOption('actividadesTurismo').setValueInit(actividadesTurismo);
    formConfig.getOption('normativaTuristica').setValueInit(normativaTuristica);
    formConfig.getOption('cuentaSocioManglar').setValueInit(cuentaSocioManglar);
    formConfig.getOption('actividadesEducacionAmbiental').setValueInit(actividadesEducacionAmbiental);
    formConfig.getOption('actividadesInvestigacion').setValueInit(actividadesInvestigacion);
    formConfig.getOption('cuentaConPermisos').setValueInit(cuentaConPermisos);
    formConfig.getOption('evidencioMuerteArboles').setValueInit(evidencioMuerteArboles);
    formConfig.getOption('evidencioMuerteBioacuaticos').setValueInit(evidencioMuerteBioacuaticos);
    formConfig.getOption('evidencioMuerteFlora').setValueInit(evidencioMuerteFlora);
    formConfig.getOption('evidencioMuerteFauna').setValueInit(evidencioMuerteFauna);
    formConfig.getOption('cambiosEnAgua').setValueInit(cambiosEnAgua);
    formConfig.getOption('cambiosSuelo').setValueInit(cambiosSuelo);
    formConfig.getOption('cambiosClima').setValueInit(cambiosClima);
    formConfig.getOption('cambiosTemperatura').setValueInit(cambiosTemperatura);

    if (formConfig.getOption('cumpleReglaNoEnajenarDesc') != null)
      formConfig.getOption('cumpleReglaNoEnajenarDesc').setValueInit(cumpleReglaNoEnajenarDesc);
    if (formConfig.getOption('cumpleReglaNoAmpliarDesc') != null)
      formConfig.getOption('cumpleReglaNoAmpliarDesc').setValueInit(cumpleReglaNoAmpliarDesc);
    if (formConfig.getOption('cumpleReglaBuenaVecindadDesc') != null)
    formConfig.getOption('cumpleReglaBuenaVecindadDesc').setValueInit(cumpleReglaBuenaVecindadDesc);
    if (formConfig.getOption('pescadoresIndependientesDesc') != null)
    formConfig.getOption('pescadoresIndependientesDesc').setValueInit(pescadoresIndependientesDesc);
    if (formConfig.getOption('pescadoresDeOtrasOrgsDesc') != null)
    formConfig.getOption('pescadoresDeOtrasOrgsDesc').setValueInit(pescadoresDeOtrasOrgsDesc);
    if (formConfig.getOption('denuncioPescadoresNoAutorizadosDesc') != null)
    formConfig.getOption('denuncioPescadoresNoAutorizadosDesc').setValueInit(denuncioPescadoresNoAutorizadosDesc);
    if (formConfig.getOption('todosRecurosBioacuaticosDesc') != null)
    formConfig.getOption('todosRecurosBioacuaticosDesc').setValueInit(todosRecurosBioacuaticosDesc);
    if (formConfig.getOption('pescaFueraDelManglarDesc') != null)
    formConfig.getOption('pescaFueraDelManglarDesc').setValueInit(pescaFueraDelManglarDesc);
    if (formConfig.getOption('actividadesDeCriaDesc') != null)
    formConfig.getOption('actividadesDeCriaDesc').setValueInit(actividadesDeCriaDesc);
    if (formConfig.getOption('cumpleNormasCriaDesc') != null)
    formConfig.getOption('cumpleNormasCriaDesc').setValueInit(cumpleNormasCriaDesc);
    if (formConfig.getOption('devuelveIndividuosDecomisadosDesc') != null)
    formConfig.getOption('devuelveIndividuosDecomisadosDesc').setValueInit(devuelveIndividuosDecomisadosDesc);
    if (formConfig.getOption('actividadesTurismoDesc') != null)
    formConfig.getOption('actividadesTurismoDesc').setValueInit(actividadesTurismoDesc);
    if (formConfig.getOption('normativaTuristicaDesc') != null)
    formConfig.getOption('normativaTuristicaDesc').setValueInit(normativaTuristicaDesc);
    if (formConfig.getOption('cuentaSocioManglarDesc') != null)
    formConfig.getOption('cuentaSocioManglarDesc').setValueInit(cuentaSocioManglarDesc);
    if (formConfig.getOption('actividadesEducacionAmbientalDesc') != null)
    formConfig.getOption('actividadesEducacionAmbientalDesc').setValueInit(actividadesEducacionAmbientalDesc);
    if (formConfig.getOption('actividadesInvestigacionDesc') != null)
    formConfig.getOption('actividadesInvestigacionDesc').setValueInit(actividadesInvestigacionDesc);
    if (formConfig.getOption('cuentaConPermisosDesc') != null)
    formConfig.getOption('cuentaConPermisosDesc').setValueInit(cuentaConPermisosDesc);
    if (formConfig.getOption('evidencioMuerteArbolesDesc') != null)
    formConfig.getOption('evidencioMuerteArbolesDesc').setValueInit(evidencioMuerteArbolesDesc);
    if (formConfig.getOption('evidencioMuerteBioacuaticosDesc') != null)
    formConfig.getOption('evidencioMuerteBioacuaticosDesc').setValueInit(evidencioMuerteBioacuaticosDesc);
    if (formConfig.getOption('evidencioMuerteFloraDesc') != null)
    formConfig.getOption('evidencioMuerteFloraDesc').setValueInit(evidencioMuerteFloraDesc);
    if (formConfig.getOption('evidencioMuerteFaunaDesc') != null)
    formConfig.getOption('evidencioMuerteFaunaDesc').setValueInit(evidencioMuerteFaunaDesc);
    if (formConfig.getOption('cambiosEnAguaDesc') != null)
    formConfig.getOption('cambiosEnAguaDesc').setValueInit(cambiosEnAguaDesc);
    if (formConfig.getOption('cambiosSueloDesc') != null)
    formConfig.getOption('cambiosSueloDesc').setValueInit(cambiosSueloDesc);
    if (formConfig.getOption('cambiosClimaDesc') != null)
    formConfig.getOption('cambiosClimaDesc').setValueInit(cambiosClimaDesc);
    if (formConfig.getOption('cambiosTemperaturaDesc') != null)
    formConfig.getOption('cambiosTemperaturaDesc').setValueInit(cambiosTemperaturaDesc);

    formConfig.idForm = organizationInfoFormId;

    // Fill files
    fileForms.forEach( (FileForm fileForm) {
      formConfig.getOption(fileForm.idOption).setValueInit(fileForm);
    });
    return formConfig;
  }

}
