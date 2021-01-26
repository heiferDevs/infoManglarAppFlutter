import '../../../infoManglar/config/repository/config_repository.dart';
import '../../../plugins/geojson.dart';
import '../../../shared/form/model/data.dart';
import '../../../shared/form/model/option.dart';
import '../../../shared/form/widgets/input.dart';
import '../../../util/user.dart';
import '../../../util/utility.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../repository/reports_repository.dart';

import '../../../util/style.dart';
import '../../../constants.dart';
import 'filter_utility.dart';

class Geoportal extends StatefulWidget{
  @override
  _State createState() { return _State();}
}

class _State extends State<Geoportal> {

  final _reportsRepository = ReportsRepository();
  final _configRepository = ConfigRepository();
  final _filterUtility = FilterUtility();

  bool _filtersLoaded = false;
  bool _enableSubmit = false;
  bool _isLoadingReports = false;
  bool _hasDataGeoJson = false;

  Map<String, dynamic> _geojson = {};

  // Custom Filters
  final Option organizationsOption = Option(label: 'Organización', type: 'select', options: []);
  final Option formTypeOption = Option(label: 'Formulario', type: 'select', options: []);
  final Option startDate = Option(label: 'Fecha inicio', type: 'calendar', typeInput: 'date');
  final Option endDate = Option(label: 'Fecha fin', type: 'calendar', typeInput: 'date');

  @override
  void initState() {
    super.initState();
    _loadData().then( (bool success) {
      if (!success) return;
      setState(() {
        _filtersLoaded = true;
        _enableSubmit = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    final double cWidth = MediaQuery.of(context).size.width * 0.5;

    final headerTitle = Container(
      padding: EdgeInsets.fromLTRB(10, 30, 10, 30),
      child: Center(
        child: Text(
          'GEOPORTAL',
          style: StyleApp.getStyleTitle(22),
        ),
      ),
    );

    final submitButton = StyleApp.getButton('CONSULTAR', () => _updateReports(), margin: 12);

    return !_filtersLoaded ?
    (User.hasInternetConnection ? Utility.getCircularProgress() : Utility.getErrorMessage()) :
    Container(
      child: ListView(
        children: <Widget>[
          headerTitle,
          _filterUtility.enableFilterOrgs() ? Input(config: organizationsOption) : SizedBox(),
          Input(config: formTypeOption),
          Input(config: startDate),
          Input(config: endDate),
          _enableSubmit ? submitButton : SizedBox(),
          _isLoadingReports ? Container(height: 200, child: Utility.getCircularProgress()) : _map(_geojson, cWidth),
          _downloadButtons(),
        ],
      ),
    );
  }


  Widget _downloadButtons(){
    if (!_filtersLoaded || _enableSubmit || !_hasDataGeoJson) return SizedBox();

    return Container(
      child: Column(
        children: <Widget>[
          //StyleApp.getButton('DESCARGAR RESUMEN(PDF)', () => print('descargar resumen')),
          //StyleApp.getButton('DESCARGAR DATOS(CSV)', () => print('descargar datos csv')),
          StyleApp.getButton('DESCARGAR ARCHIVO(GEOJSON)', () => _downloadGeojson() ),
        ],
      ),
    );
  }

  _updateReports(){
    setState(() {
      _isLoadingReports = true;
    });
    String start = DateTime.parse(startDate.getValue()).millisecondsSinceEpoch.toString();
    String end = DateTime.parse(endDate.getValue()).add(Duration(days: 1)).subtract(Duration(seconds: 1)).millisecondsSinceEpoch.toString();
    String orgId = _filterUtility.enableFilterOrgs() ? organizationsOption.value.id : User.organizationManglarId;
    String form = formTypeOption.value.id;
    _reportsRepository.mapping(form, 'all', 'all', orgId, start, end).then( (Map<String, dynamic> geojson) {
      setState(() {
        _geojson = geojson;
        _hasDataGeoJson = geojson['features'].length > 0;
        _enableSubmit = false;
        _isLoadingReports = false;
      });
    });
  }

  _downloadGeojson() {
    String start = DateTime.parse(startDate.getValue()).millisecondsSinceEpoch.toString();
    String end = DateTime.parse(endDate.getValue()).add(Duration(days: 1)).subtract(Duration(seconds: 1)).millisecondsSinceEpoch.toString();
    String orgId = _filterUtility.enableFilterOrgs() ? organizationsOption.value.id : User.organizationManglarId;
    String form = formTypeOption.value.id;
    _reportsRepository.mappingFile(form, 'all', 'all', orgId, start, end).then( (bool success) {
      if (!success){
        Utility.showToast(context, 'ERROR No se pudo descargar el archivo geojson');
      }
    });
  }

  Widget _map(Map<String, dynamic> geojson, double width){
    if (!_filtersLoaded || _enableSubmit) return SizedBox();

    if (!_hasDataGeoJson) {
      return Container(
        height: 100,
        child: Center(
          child: Text('NO TENEMOS RESULTADOS', style: StyleApp.getStyleTitle(16),),
        ),
      );
    }
    return Container(
      margin: EdgeInsets.fromLTRB(16, 4, 16, 16),
      width: width,
      height: 340,
      decoration: BoxDecoration(
          border: Border.all(color: Color(Constants.colorPrimary))
      ),
      child: GeoJsonPage(geojson: geojson,),
    );
  }

  Future<bool> _loadData() async {
    if (!User.hasInternetConnection) return false;
    // Forms
    formTypeOption.options = _filterUtility.formsGeoportal
        .map<Data>( (d) => Data(id: d['id'], state: d['label'])).toList();
    formTypeOption.value = formTypeOption.options.asMap()[0];
    formTypeOption.onClick = (value) => _addActionSelect(formTypeOption, value);
    // Dates
    startDate.setValueInit(DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 7))));
    endDate.setValueInit(DateFormat('yyyy-MM-dd').format(DateTime.now()));
    startDate.onClick = (value) => _addActionCalendar(startDate, value);
    endDate.onClick = (value) => _addActionCalendar(endDate, value);
    // Organizations
    List<Data> organizations = await _configRepository.getOrganizationsByType("org");
    organizationsOption.options = organizations;
    organizationsOption.value = organizationsOption.options.asMap()[0];
    organizationsOption.onClick = (value) => _addActionSelect(organizationsOption, value);
    return true;
  }

  _addActionCalendar(Option option, String value){
    option.setValue(value, ({idOptionChange = ''}){
      setState(() {
        _enableSubmit = true;
      });
    });
  }

  _addActionSelect(Option option, String value){
    option.setValueByIdOption(value, ({idOptionChange = ''}){
      setState(() {
        _enableSubmit = true;
      });
    });
  }

}
