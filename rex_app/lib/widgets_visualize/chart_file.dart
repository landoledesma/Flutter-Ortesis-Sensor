import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SensorData {
  final double x;
  final double y;

  SensorData({required this.x, required this.y});
}

class SensorChart extends StatelessWidget {
  final List<List<dynamic>> datos;

  SensorChart({required this.datos});

  List<SensorData> _procesarDatos() {
    List<SensorData> data = [];
    for (var fila in datos) {
      data.add(SensorData(
          x: double.parse(fila[0].toString()),
          y: double.parse(fila[0].toString())));
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    List<SensorData> datosProcesados = _procesarDatos();

    return SfCartesianChart(
      primaryXAxis: NumericAxis(),
      primaryYAxis: NumericAxis(),
      series: <ChartSeries>[
        LineSeries<SensorData, double>(
          dataSource: datosProcesados,
          xValueMapper: (SensorData data, _) => data.x,
          yValueMapper: (SensorData data, _) => data.y,
        ),
      ],
    );
  }
}
