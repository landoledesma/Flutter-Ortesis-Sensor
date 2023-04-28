import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:rex_app/widgets_plot/send_data.dart';
import '../screens/home.dart';
import '../screens/visualize.dart';
import '../widgets_conection/bluedvicemod.dart';

class RecordingButtons extends StatelessWidget {
  final BluetoothDeviceModel deviceModel;
  final StreamController<double>? streamController;

  RecordingButtons({
    required this.deviceModel,
    this.streamController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FloatingActionButton(
          child: Icon(Icons.play_arrow),
          onPressed: () => startRecording(deviceModel, streamController),
        ),
        FloatingActionButton(
          heroTag: 'start',
          child: Icon(Icons.pause),
          onPressed: () => stopRecording(deviceModel),
        ),
        FloatingActionButton(
          heroTag: 'save',
          child: Icon(Icons.file_copy),
          onPressed: () {
            // Navegar a pantalla de carga y visualización de datos históricos
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PantallaDatosHistoricos(),
              ),
            );
          },
        ),
      ],
    );
  }
}
