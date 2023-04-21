import 'package:flutter/material.dart';
import 'dart:async';
import '../widgets/home_button.dart';
import '../widgets_conection/bluedvicemod.dart';
import 'buttons_plot.dart';

class Body extends StatelessWidget {
  late final BluetoothDeviceModel deviceModel;
  late final StreamController<double> _streamController =
      StreamController<double>();
  StreamSubscription<double>? _streamSubscription;

  Body({super.key});

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
              Text('Valor del sensor: --'),
              SizedBox(height: 10),
              Expanded(child: Container()),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: RecordingButtons(
                  deviceModel: deviceModel,
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
