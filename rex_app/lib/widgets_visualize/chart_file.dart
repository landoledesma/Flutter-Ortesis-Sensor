import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SensorData {
  final double x;
  final double y;

  SensorData({required this.x, required this.y});
}

class SensorChart extends StatelessWidget {
  final List<List<dynamic>> datos;
  const SensorChart({super.key, required this.datos});

  List<SensorData> _procesarDatos() {
    List<SensorData> data = [];
    for (int i = 1; i < datos.length; i++) {
      var fila = datos[i];
      double xValue = double.parse(fila[0].toString());
      double yValue = double.parse(fila[1].toString());
      data.add(SensorData(x: xValue, y: yValue));
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
      // Habilitar el zoom y el desplazamiento en la gráfica
      zoomPanBehavior: ZoomPanBehavior(
        enablePinching: true,
        zoomMode: ZoomMode.x,
        enablePanning: true,
      ),
    );
  }
}
