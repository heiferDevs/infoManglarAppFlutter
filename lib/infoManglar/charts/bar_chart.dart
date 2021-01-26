import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import '../stats/model/chart_data.dart';

class BarChart extends StatelessWidget {

  final String id;
  final List<charts.Series> seriesList;
  final bool animate;
  final bool vertical;

  BarChart(
    this.seriesList,
    this.id,
    {
      this.animate,
      this.vertical,
    }
  );

  factory BarChart.fromBarChartData(ChartData data){
    List<charts.Series<OrdinalData, String>> series = [
      new charts.Series<OrdinalData, String>(
        id: data.id,
        domainFn: (OrdinalData ordinal, _) => ordinal.label,
        measureFn: (OrdinalData ordinal, _) => ordinal.value,
        data: data.ordinalList,
      )
    ];
    return BarChart(series, data.id, animate: data.animate, vertical: data.vertical,);
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
      vertical: vertical,
    );
  }

}
