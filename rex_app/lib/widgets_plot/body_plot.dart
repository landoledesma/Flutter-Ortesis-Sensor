import 'package:flutter/material.dart';
import 'dart:async';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../widgets/home_button.dart';
import '../widgets_conection/bluedvicemod.dart';
import 'buttons_plot.dart';

class Body extends StatefulWidget {
  final BluetoothDeviceModel deviceModel;

  Body({required this.deviceModel, Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<double> chartData = [];
  final int maxDataSize = 60000;
  late final StreamController<double> _streamController =
      StreamController<double>();

  StreamSubscription<double>? _streamSubscription;

  @override
  void initState() {
    super.initState();
    _streamSubscription = _streamController.stream.listen((double value) {
      setState(() {
        if (chartData.length >= maxDataSize) {
          chartData.removeAt(
              0); // Elimina el dato más antiguo si se alcanza el tamaño máximo
        }
        chartData.add(value); // Actualiza la lista de datos con el nuevo valor
      });
    });
  }

  @override
  void dispose() {
    _streamSubscription?.cancel(); // Cancela la suscripción
    _streamController.close(); // Cierra el StreamController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 200,
                child: Center(child: Text('Gráfica de datos en tiempo real')),
              ),
              Text(
                  'Valor del sensor: ${chartData.isNotEmpty ? chartData.last.toStringAsFixed(2) : "--"}'),
              SizedBox(height: 10),
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
              SizedBox(height: 10),
              Expanded(child: Container()),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: RecordingButtons(
                  deviceModel: widget.deviceModel,
                  streamController:
                      _streamController, // Utiliza widget.deviceModel
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
        Positioned(
            right: 10,
            top: MediaQuery.of(context).size.height * 0.75,
            child: HomeButton()),
      ],
    );
  }
}
