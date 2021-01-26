import '../../../util/utility.dart';

import '../../charts/bar_chart.dart';
import '../../charts/pie_chart.dart';
import '../model/chart_data.dart';
import '../repository/stats_repository.dart';
import '../../../util/style.dart';
import 'package:flutter/material.dart';

class StatChart extends StatelessWidget{

  final String idChart;
  final String typeChart;
  final String title;
  final String userId;
  final String orgId;
  final String start;
  final String end;

  StatChart({
    @required this.idChart,
    @required this.typeChart,
    this.title = '',
    this.userId = 'all',
    this.orgId = 'all',
    this.start = 'all',
    this.end = 'all',
  });

  final _statsRepository = StatsRepository();


  @override
  Widget build(BuildContext context) {

    final double cWidth = MediaQuery.of(context).size.width * 0.9;

    return FutureBuilder(
      future: _loadData(),
      builder: (context, snapshot){
        if (snapshot.hasData) {
          return Column(
            children: <Widget>[
              SizedBox(height: 22,),
              Text(title, textAlign: TextAlign.center,style: StyleApp.getStyleSubTitle(16),),
              Container(
                width: cWidth,
                height: 220,
                child: Center(
                  child: _chart(snapshot.data),
                ),
              )
            ],
          );
        } else if (snapshot.hasError) {
          return Utility.getErrorMessage();
        }
        return Container(height: 160, child: Utility.getCircularProgress(),);
      },
    );
  }

  Widget _chart(ChartData data){
    // prevent load old data
    if (idChart != data.id) return null;

    switch (typeChart) {
      case 'pieChart':
        return PieChart.fromBarChartData(data);
      case 'barChart':
        return BarChart.fromBarChartData(data);
    }
    return null;
  }

  _loadData(){
    switch (idChart) {
      case 'montoInvertidoOrg':
        return _statsRepository.montoInvertidoOrg(userId, orgId, start, end);
      case 'bioemprendimiento':
        return _statsRepository.bioemprendimiento(userId, orgId, start, end);
      case 'projectsByType':
        return _statsRepository.projectsByType(userId, orgId, start, end);
      case 'ingresoActividadPrincipal':
        return _statsRepository.ingresoActividadPrincipal(userId, orgId, start, end);
      case 'ingresoActividadSecundaria':
        return _statsRepository.ingresoActividadSecundaria(userId, orgId, start, end);
      case 'areaReforestada':
        return _statsRepository.areaReforestada(userId, orgId, start, end);
      case 'manglarDependents':
        return _statsRepository.manglarDependents(userId, orgId, start, end);
      case 'anomaliesByLocation':
        return _statsRepository.anomaliesByLocation(userId, orgId, start, end);
      case 'fishingEffortCrabBySocio':
        return _statsRepository.fishingEffortCrabBySocio(userId, orgId, start, end);
      case 'fishingEffortCrabByOrg':
        return _statsRepository.fishingEffortCrabByOrg(userId, orgId, start, end);
      case 'fishingEffortCrabBySector':
        return _statsRepository.fishingEffortCrabBySector(userId, orgId, start, end);
      case 'fishingEffortShellBySocio':
        return _statsRepository.fishingEffortShellBySocio(userId, orgId, start, end);
      case 'fishingEffortShellByOrg':
        return _statsRepository.fishingEffortShellByOrg(userId, orgId, start, end);
      case 'fishingEffortShellBySector':
        return _statsRepository.fishingEffortShellBySector(userId, orgId, start, end);
    }
    return null;
  }

}
