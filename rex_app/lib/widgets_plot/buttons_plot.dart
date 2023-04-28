import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rex_app/widgets_plot/save_files.dart';
import 'package:rex_app/widgets_plot/send_data.dart';
import 'package:rex_app/widgets_plot/showdialog.dart';
import '../screens/home.dart';
import '../screens/plot.dart';
import '../screens/visualize.dart';
import '../widgets_conection/bluedvicemod.dart';

class RecordingButtons extends StatefulWidget {
  final BluetoothDeviceModel deviceModel;
  final StreamController<double>? streamController;

  RecordingButtons({
    required this.deviceModel,
    this.streamController,
  });

  @override
  State<RecordingButtons> createState() => _RecordingButtonsState();
}

class _RecordingButtonsState extends State<RecordingButtons> {
  late String tempFileName;
  double valor = 0.0;
  late final StreamController<double> stream = StreamController<double>();

  StreamSubscription<double>? streamSubscription;

  void restartScreen(context) {
    final BluetoothDeviceModel deviceModel;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => PantallaDatosTiempoReal(
          deviceModel: widget.deviceModel,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    tempFileName = 'temp_${UniqueKey().toString()}.csv';
    clearTempFile(tempFileName);
    streamSubscription = stream.stream.listen((double value) {
      setState(() async {
        valor = value;
        await appendDataToTempFile(value, tempFileName);
        //chartData.add(value); // Actualiza la lista de datos con el nuevo valor
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FloatingActionButton(
          heroTag: 'start',
          child: Icon(Icons.play_arrow),
          onPressed: () =>
              startRecording(widget.deviceModel, widget.streamController),
        ),
        FloatingActionButton(
          heroTag: 'stop',
          child: Icon(Icons.pause),
          onPressed: () => stopRecording(widget.deviceModel),
        ),
        FloatingActionButton(
          heroTag: 'file',
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
        FloatingActionButton(
            heroTag: 'save',
            child: Icon(Icons.save),
            onPressed: () async {
              await showSaveDialog(context, tempFileName);
            }),
        FloatingActionButton(
            heroTag: 'refresh',
            child: Icon(Icons.refresh),
            onPressed: () => restartScreen(context))
      ],
    );
  }
}
