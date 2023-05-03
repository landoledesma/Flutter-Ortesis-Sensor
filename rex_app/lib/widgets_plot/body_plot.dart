import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'dart:async';
import 'package:syncfusion_flutter_charts/charts.dart';
//import '../widgets/home_button.dart';
import '../widgets_conection/bluedvicemod.dart';
import 'buttons_plot.dart';
import 'notifier.dart';

class Body extends StatefulWidget {
  final BluetoothDeviceModel deviceModel;

  const Body({required this.deviceModel, Key? key}) : super(key: key);
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<double> chartData = [];
  final int maxDataSize = 60000;
  /*@override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
*/
  @override
  Widget build(BuildContext context) {
    return Consumer<BluetoothValueNotifier>(
        builder: (context, bluetoothValueNotifier, child) {
      double valor = bluetoothValueNotifier.bluetoothValue;

      if (chartData.length >= maxDataSize) {
        chartData.removeAt(0);
      }
      chartData.add(valor);

      return Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(
                  height: 200,
                  child: Center(child: Text('Gráfica de datos en tiempo real')),
                ),
                Text(
                    'Valor del sensor: ${chartData.isNotEmpty ? chartData.last.toStringAsFixed(2) : "--"}'),
                const SizedBox(height: 10),
                SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  series: <LineSeries<double, int>>[
                    LineSeries<double, int>(
                      dataSource: chartData,
                      xValueMapper: (double value, int index) => index,
                      yValueMapper: (double value, int index) => value,
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(child: Container()),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: RecordingButtons(
                    deviceModel: widget.deviceModel,
                    bluetoothValueNotifier:
                        context.read<BluetoothValueNotifier>(),
                    // Utiliza widget.deviceModel
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      );
    });
  }
}
