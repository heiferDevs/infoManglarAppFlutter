import '../../../util/user.dart';

class FilterUtility {
  enableFilterOrgs() {
    return User.role == 'mae' || User.role == 'inp';
  }

  enableDownloadsReports() {
    return User.role == 'mae' || User.role == 'inp';
  }

  getFormsSocio() {
    if (User.role == 'inp') return _formsSocioINP;
    return _formsSocio;
  }

  getFormsOrg() {
    if (User.role == 'inp') return _formsOrgINP;
    return _formsOrg;
  }

  getFormsMae() {
    return _formsMae;
  }

  getFormsInp() {
    return _formsInp;
  }

  getFormsAll() {
    List<Map<String, dynamic>> _formsOrg = _addPrefix(getFormsOrg(), 'ORG');
    List<Map<String, dynamic>> _formsSocio =
        _addPrefix(getFormsSocio(), 'SOCIO');
    List<Map<String, dynamic>> _formsMae = _addPrefix(getFormsMae(), 'MAE');
    List<Map<String, dynamic>> _formsInp = _addPrefix(getFormsInp(), 'IPIAP');
    List<Map<String, dynamic>> result = [];
    return result
      ..addAll(_formsMae)
      ..addAll(_formsInp)
      ..addAll(_formsSocio)
      ..addAll(_formsOrg);
  }

  _addPrefix(List<Map<String, dynamic>> forms, String prefix) {
    return forms.map<Map<String, dynamic>>((formInfo) {
      return {
        'label': '($prefix) ${formInfo['label']}',
        'id': formInfo['id'],
      };
    }).toList();
  }

  List<Map<String, dynamic>> formsGeoportal = [
    {
      'label': 'Talla de Conchas',
      'id': 'shell-size-form',
    },
    {
      'label': 'Talla de Cangrejos',
      'id': 'crab-size-form',
    },
    {
      'label': 'Recolección de conchas',
      'id': 'shell-collection-form',
    },
    {
      'label': 'Recolección de cangrejos',
      'id': 'crab-collection-form',
    },
    {
      'label': 'Información de Veda',
      'id': 'info-veda-form',
    },
  ];

  List<Map<String, dynamic>> userType = [
    {
      'label': 'Todos',
      'id': 'all',
    },
    {
      'label': 'Socio',
      'id': 'socio',
    },
    {
      'label': 'Organización',
      'id': 'org',
    },
    {
      'label': 'MAE',
      'id': 'mae',
    },
    {
      'label': 'IPIAP',
      'id': 'inp',
    },
  ];

  final List<Map<String, dynamic>> optionsStats = [
    {
      'id': 'proyectos',
      'label': 'Proyectos',
    },
    {
      'id': 'indicadores_economicos',
      'label': 'Indicadores económicos',
    },
    {
      'id': 'bioemprendimientos',
      'label': 'Bioemprendimientos',
    },
    {
      'id': 'reforestación',
      'label': 'Reforestación',
    },
    {
      'id': 'control_vigilancia',
      'label': 'Control y vigilancia',
    },
    {
      'id': 'indicadores_sociales',
      'label': 'Indicadores sociales',
    },
    {
      'id': 'fishing_effort_shell',
      'label': 'Esfuerzo pesquero Conchas',
    },
    {
      'id': 'fishing_effort_crab',
      'label': 'Esfuerzo pesquero Cangrejos',
    },
  ];

  List<Map<String, dynamic>> _formsSocioINP = [
    {
      'label': 'Recolección de conchas',
      'id': 'shell-collection-form',
    },
    {
      'label': 'Recolección de cangrejos',
      'id': 'crab-collection-form',
    },
    {
      'label': 'Talla de Conchas',
      'id': 'shell-size-form',
    },
    {
      'label': 'Talla de Cangrejos',
      'id': 'crab-size-form',
    },
  ];

  List<Map<String, dynamic>> _formsOrgINP = [
    {
      'label': 'Información de Veda',
      'id': 'info-veda-form',
    },
  ];

  List<Map<String, dynamic>> _formsMae = [
    {
      'label': 'Informe semestral',
      'id': 'semi-annual-report-form',
    },
  ];

  List<Map<String, dynamic>> _formsInp = [
    {
      'label': 'Informe técnico',
      'id': 'technical-report-form',
    },
  ];

  List<Map<String, dynamic>> _formsSocio = [
    {
      'label': 'Recolección de cangrejos',
      'id': 'crab-collection-form',
    },
    {
      'label': 'Recolección de conchas',
      'id': 'shell-collection-form',
    },
    {
      'label': 'Talla de Cangrejos',
      'id': 'crab-size-form',
    },
    {
      'label': 'Talla de Conchas',
      'id': 'shell-size-form',
    },
  ];

  List<Map<String, dynamic>> _formsOrg = [
    {
      'label': 'Esfuerzo pesquero',
      'id': 'fishing-effort-form',
    },
    {
      'label': 'Evidencias de informe semestral',
      'id': 'evidence-form',
    },
    {
      'label': 'Control',
      'id': 'control-form',
    },
    {
      'label': 'Deforestación',
      'id': 'deforestation-form',
    },
    {
      'label': 'Indicadores económicos',
      'id': 'economic-indicators-form',
    },
    {
      'label': 'Información de Veda',
      'id': 'info-veda-form',
    },
    {
      'label': 'Inversiones de Organización',
      'id': 'investments-orgs-form',
    },
    {
      'label': 'Seguimiento Actividades',
      'id': 'plan-tracking-form',
    },
    {
      'label': 'Proyectos',
      'id': 'desc-projects-form',
    },
    {
      'label': 'Reforestación',
      'id': 'reforestation-form',
    },
  ];
}
