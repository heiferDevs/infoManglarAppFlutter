import '../../../infoManglar/config/repository/config_repository.dart';
import '../../../infoManglar/reports/screens/filter_utility.dart';
import '../../../shared/form/model/data.dart';
import '../../../shared/form/model/option.dart';
import '../../../shared/form/widgets/input.dart';
import '../../../util/user.dart';
import '../../../util/utility.dart';
import 'package:intl/intl.dart';
import '../widgets/stat_chart.dart';
import 'package:flutter/material.dart';
import '../../../util/style.dart';

class Stats extends StatefulWidget{

  @override
  _State createState() {
    return _State();
  }

}

class _State extends State<Stats> {

  bool _isLoading = true;

  String categorySelected = 'proyectos'; // By default
  final _configRepository = ConfigRepository();
  final _filterUtility = FilterUtility();

  // Custom Filters
  final Option organizationsOption = Option(label: 'Organización', type: 'select', options: []);
  final Option statOption = Option(label: 'Estadística', type: 'select', options: []);
  final Option startDate = Option(label: 'Fecha inicio', type: 'calendar', typeInput: 'date');
  final Option endDate = Option(label: 'Fecha fin', type: 'calendar', typeInput: 'date');

  @override
  void initState() {
    super.initState();
    loadData().then( (bool success){
      if (!success) return;
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    final headerTitle = Container(
      padding: EdgeInsets.fromLTRB(10, 30, 10, 30),
      child: Center(
        child: Text(
          'ESTADÍSTICAS',
          style: StyleApp.getStyleTitle(22),
        ),
      ),
    );

    return _isLoading ?
    (User.hasInternetConnection ? Utility.getCircularProgress() : Utility.getErrorMessage()) :
    Container(
      child: ListView(
        children: <Widget>[
          headerTitle,
          _filterUtility.enableFilterOrgs() ? Input(config: organizationsOption) : SizedBox(),
          Input(config: statOption),
          Input(config: startDate),
          Input(config: endDate),
          Container(
            child: Column(
              children: _charts(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _charts(){
    switch (categorySelected) {
      case 'bioemprendimientos':
        return [
          _chart('bioemprendimiento', 'barChart', 'BIOEMPRENDIMIENTOS'),
        ];
      case 'proyectos':
        return [
          _chart('montoInvertidoOrg', 'barChart', 'MONTO INVERTIDO POR INSTITUCIÓN'),
          _chart('projectsByType', 'pieChart', 'PORCENTAJE DE PROYECTOS POR TIPO DE INSTITUCIÓN'),
        ];
      case 'indicadores_economicos':
        return [
          _chart('ingresoActividadPrincipal', 'barChart', 'FRECUENCIA DE INGRESO PROMEDIO POR ACTIVIDAD PRINCIPAL'),
          _chart('ingresoActividadSecundaria', 'barChart', 'FRECUENCIA DE INGRESO PROMEDIO POR ACTIVIDAD SECUNDARIA'),
        ];
      case 'reforestación':
        return [
          _chart('areaReforestada', 'barChart', 'ÁREA REFORESTADA (en hectáreas)'),
        ];
      case 'control_vigilancia':
        return [
          _chart('anomaliesByLocation', 'pieChart', 'PORCENTAJE ANOMALIAS SECTOR'),
        ];
      case 'indicadores_sociales':
        return [
          _chart('manglarDependents', 'barChart', 'DEPENDIENTES DE ACTIVIDAD PESQUERA'),
        ];
      case 'fishing_effort_crab':
        return [
          _chart('fishingEffortCrabBySocio', 'barChart', 'ESFUERZO PESQUERO SOCIO'),
          _chart('fishingEffortCrabByOrg', 'barChart', 'ESFUERZO PESQUERO ORGANIZACIÓN'),
          _chart('fishingEffortCrabBySector', 'barChart', 'ESFUERZO PESQUERO SECTOR'),
        ];
      case 'fishing_effort_shell':
        return [
          _chart('fishingEffortShellBySocio', 'barChart', 'ESFUERZO PESQUERO SOCIO'),
          _chart('fishingEffortShellByOrg', 'barChart', 'ESFUERZO PESQUERO ORGANIZACIÓN'),
          _chart('fishingEffortShellBySector', 'barChart', 'ESFUERZO PESQUERO SECTOR'),
        ];
    }
    return [];
  }

  _chart(String idChart, String typeChart, String title) {
    String start = DateTime.parse(startDate.getValue()).millisecondsSinceEpoch.toString();
    String end = DateTime.parse(endDate.getValue()).add(Duration(days: 1)).subtract(Duration(seconds: 1)).millisecondsSinceEpoch.toString();
    String orgId = _filterUtility.enableFilterOrgs() ? organizationsOption.value.id : User.organizationManglarId;
    return StatChart(idChart: idChart, typeChart: typeChart, title: title, start: start, end: end, orgId: orgId,);
  }

  Future<bool> loadData() async {
    if (!User.hasInternetConnection) return false;
    // Date
    startDate.setValueInit(DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 7))));
    endDate.setValueInit(DateFormat('yyyy-MM-dd').format(DateTime.now()));
    startDate.onClick = (value) => _addActionCalendar(startDate, value);
    endDate.onClick = (value) => _addActionCalendar(endDate, value);
    // Organizations
    List<Data> organizations = await _configRepository.getOrganizationsByType("org");
    organizationsOption.options = organizations;
    organizationsOption.value = organizationsOption.options.asMap()[0];
    organizationsOption.onClick = (value) => _addActionSelect(organizationsOption, value);
    // Stats
    statOption.options = _filterUtility.optionsStats.map<Data>( (d) => Data(id: d['id'], state: d['label'])).toList();
    statOption.value = statOption.options.asMap()[0];
    statOption.onClick = (value) => _addActionSelectStat(statOption, value);
    return true;
  }

  _addActionCalendar(Option option, String value){
    option.setValue(value, ({idOptionChange = ''}){
      setState(() {});
    });
  }

  _addActionSelect(Option option, String value){
    option.setValueByIdOption(value, ({idOptionChange = ''}){
      setState(() {});
    });
  }

  _addActionSelectStat(Option option, String value){
    option.setValueByIdOption(value, ({idOptionChange = ''}){
      setState(() {
        categorySelected = value;
      });
    });
  }

}
