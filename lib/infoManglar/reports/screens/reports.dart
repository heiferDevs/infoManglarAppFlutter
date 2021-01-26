import '../../../infoManglar/config/repository/config_repository.dart';
import '../../infoForm/controller/info_form_on_init_controller.dart';
import '../../../infoManglar/reports/screens/filter_utility.dart';
import '../../../shared/form/model/data.dart';
import '../../../shared/form/model/form_config.dart';
import '../../../shared/form/model/option.dart';
import '../../../shared/form/screens/form_screen.dart';
import '../../../shared/form/widgets/input.dart';
import '../../../shared/userType/model/user_type.dart';
import '../../../shared/userType/repository/user_type_repository.dart';
import '../../../util/user.dart';
import '../../../util/utility.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../repository/reports_repository.dart';
import '../model/report.dart';
import '../widgets/item_report.dart';

import '../../../util/style.dart';

class Reports extends StatefulWidget{
  @override
  _State createState() {
    return _State();
  }
}

class _State extends State<Reports> {

  final _filterUtility = FilterUtility();
  final _configRepository = ConfigRepository();
  final _reportsRepository = ReportsRepository();
  final _userTypeRepository = UserTypeRepository();
  final _infoFormOnInitController = InfoFormOnInitController();

  bool _filtersLoaded = false;
  bool _enableSubmit = false;
  bool _isLoadingReports = false;

  List<Report> _reports = [];
  List<UserType> _socios = [];
  List<UserType> _orgs = [];
  List<UserType> _maes = [];
  List<UserType> _inps = [];

  // Custom Filters
  final Option organizationsOption = Option(label: 'Organización', type: 'select', options: []);
  final Option userTypeOption = Option(id: 'userType', label: 'Tipo Usuario', type: 'select', options: []);
  final Option userIdOption = Option(label: 'Usuario', type: 'select', options: []);
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

  _updateReports(){
    setState(() {
      _isLoadingReports = true;
    });
    String start = DateTime.parse(startDate.getValue()).millisecondsSinceEpoch.toString();
    String end = DateTime.parse(endDate.getValue()).add(Duration(days: 1)).subtract(Duration(seconds: 1)).millisecondsSinceEpoch.toString();
    String orgId = _filterUtility.enableFilterOrgs() ? organizationsOption.value.id : User.organizationManglarId;
    String form = formTypeOption.value.id;
    String userType = userTypeOption.value.id;
    String userId = userIdOption.value.id;
    _reportsRepository.reports(form, userType, userId, orgId, start, end).then( (List<Report> reports) {
      setState(() {
        _reports = reports;
        _enableSubmit = false;
        _isLoadingReports = false;
      });
    });
  }

  _downloadCsv() {
    String start = DateTime.parse(startDate.getValue()).millisecondsSinceEpoch.toString();
    String end = DateTime.parse(endDate.getValue()).add(Duration(days: 1)).subtract(Duration(seconds: 1)).millisecondsSinceEpoch.toString();
    String orgId = _filterUtility.enableFilterOrgs() ? organizationsOption.value.id : User.organizationManglarId;
    String form = formTypeOption.value.id;
    String userType = userTypeOption.value.id;
    String userId = userIdOption.value.id;
    _reportsRepository.reportsCsv(form, userType, userId, orgId, start, end).then( (bool success) {
      if (!success){
        Utility.showToast(context, 'ERROR No se pudo descargar el archivo geojson');
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    final headerTitle = Container(
      padding: EdgeInsets.fromLTRB(10, 30, 10, 30),
      child: Center(
        child: Text(
          'REPORTES',
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
          Input(config: userTypeOption),
          //_isAllUserType() ? SizedBox() : Input(config: userIdOption),
          Input(config: formTypeOption),
          Input(config: startDate),
          Input(config: endDate),
          _enableSubmit ? submitButton : SizedBox(),
          _isLoadingReports ? Container(height: 200, child: Utility.getCircularProgress()) : _getReports(_reports),
        ],
      ),
    );
  }

  Widget _getReports(List<Report> reports){
    if (!_filtersLoaded || _enableSubmit) return SizedBox();

    List<Widget> items = [
      StyleApp.getTitle('RESULTADOS: ${reports.length}', padding: 8),
    ];

    List<Widget> downloadReports = [
      StyleApp.getButton('DESCARGAR DATOS (CSV)', () => _downloadCsv()),
      // StyleApp.getButton('DESCARGAR RESUMEN (PDF)', () => print('download pdf')),
      // StyleApp.getButton('DESCARGAR FICHA HEIFER (PDF)', () => print('download pdf')),
    ];

    List<Widget> _reportsItems = reports.map<Widget>( (Report report) {
      bool canEdit = User.canEditForms(report);
      String textSubmit = canEdit ? 'VER/EDITAR' : 'VER';
      return ItemReport(report: report, textSubmit: textSubmit, onPressed: () {
        _infoFormOnInitController.onInitFormFromReport(report, context).then((FormConfig formConfig){
          formConfig.enableSubmit = canEdit;
          Utility.navTo(context, FormScreen(formConfig: formConfig));
        });
      },);
    }).toList();

    if (reports.length > 0 && _filterUtility.enableDownloadsReports()) items.addAll(downloadReports);

    items.addAll(_reportsItems);

    return Container(
      child: Column(
        children: items,
      ),
    );
  }

  bool _isAllUserType(){
    if (userTypeOption.value == null) return true;
    return userTypeOption.value.id == 'all';
  }

  Future<bool> _loadData() async {
    if (!User.hasInternetConnection) return false;
    _socios = await _userTypeRepository.usersType('socio');
    _orgs = await _userTypeRepository.usersType('org');
    _maes = await _userTypeRepository.usersType('mae');
    _inps = await _userTypeRepository.usersType('inp');
    // Date
    startDate.setValueInit(DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 7))));
    endDate.setValueInit(DateFormat('yyyy-MM-dd').format(DateTime.now()));
    startDate.onClick = (value) => _addActionCalendar(startDate, value);
    endDate.onClick = (value) => _addActionCalendar(endDate, value);
    // Organizations
    List<Data> organizations = await _configRepository.getOrganizationsByType("org");
    organizations.insert(0, Data(id: 'all', state: 'Todos'));
    organizationsOption.options = organizations;
    organizationsOption.value = organizationsOption.options.asMap()[0];
    organizationsOption.onClick = (value) => _addActionSelect(organizationsOption, value);
    // UserType
    userTypeOption.options = _filterUtility.userType.map<Data>( (d) => Data(id: d['id'], state: d['label'])).toList();
    userTypeOption.value = userTypeOption.options.asMap()[0];
    userTypeOption.onClick = (value) => _addActionSelect(userTypeOption, value);
    // Forms
    List<Data> allForms = _filterUtility.getFormsAll()
        .map<Data>( (d) => Data(id: d['id'], state: d['label'])).toList();
    if (!_filterUtility.enableDownloadsReports()) allForms.insert(0, Data(id: 'all', state: 'Todos'));
    formTypeOption.options = allForms;
    formTypeOption.value = formTypeOption.options.asMap()[0];
    formTypeOption.onClick = (value) => _addActionSelect(formTypeOption, value);
    // UserId
    userIdOption.options = [Data(id: 'all', state: 'Todos')];
    userIdOption.value = userIdOption.options.asMap()[0];
    userIdOption.onClick = (value) => _addActionSelect(userIdOption, value);
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
        if (option.id == 'userType') {
          _applyChangeUserId(value);
          _applyChangeFormType(value);
        }
      });
    });
  }

  _applyChangeFormType(String value) {
    List<Data> options = [];
    if (value == 'socio') {
      options = _filterUtility.getFormsSocio()
          .map<Data>( (d) => Data(id: d['id'], state: d['label'])).toList();
    }
    if (value == 'org') {
      options = _filterUtility.getFormsOrg()
          .map<Data>( (d) => Data(id: d['id'], state: d['label'])).toList();
    }
    if (value == 'mae') {
      options = _filterUtility.getFormsMae()
          .map<Data>( (d) => Data(id: d['id'], state: d['label'])).toList();
    }
    if (value == 'inp') {
      options = _filterUtility.getFormsInp()
          .map<Data>( (d) => Data(id: d['id'], state: d['label'])).toList();
    }
    if (value == 'all') {
      options = _filterUtility.getFormsAll()
          .map<Data>( (d) => Data(id: d['id'], state: d['label'])).toList();
    }
    if (!_filterUtility.enableDownloadsReports()) options.insert(0, Data(id: 'all', state: 'Todos'));
    formTypeOption.options = options;
    formTypeOption.value = formTypeOption.options.asMap()[0];
  }

  _applyChangeUserId(String value) {
    List<Data> options = [];
    if (value == 'socio') {
      options = _socios
          .map<Data>( (UserType u) => Data(id: u.userId.toString(), state: u.userName)).toList();
    }
    if (value == 'org') {
      options = _orgs
          .map<Data>( (UserType u) => Data(id: u.userId.toString(), state: u.userName)).toList();
    }
    if (value == 'mae') {
      options = _maes
          .map<Data>( (UserType u) => Data(id: u.userId.toString(), state: u.userName)).toList();
    }
    if (value == 'inp') {
      options = _inps
          .map<Data>( (UserType u) => Data(id: u.userId.toString(), state: u.userName)).toList();
    }
    options.insert(0, Data(id: 'all', state: 'Todos'));
    userIdOption.options = options;
    userIdOption.value = userIdOption.options.asMap()[0];
  }

}
