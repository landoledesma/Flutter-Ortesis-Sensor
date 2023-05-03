//import 'dart:async';
//import 'dart:io';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//import 'package:flutter_blue_plus/flutter_blue_plus.dart';
//import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:rex_app/widgets_plot/save_files.dart';
import 'package:rex_app/widgets_plot/send_data.dart';
import 'package:rex_app/widgets_plot/showdialog.dart';
//import '../screens/home.dart';
//import '../screens/plot.dart';
import '../screens/visualize.dart';
import '../widgets_conection/bluedvicemod.dart';
import 'notifier.dart';

class RecordingButtons extends StatefulWidget {
  final BluetoothDeviceModel deviceModel;
  final BluetoothValueNotifier bluetoothValueNotifier;
  const RecordingButtons({
    super.key,
    required this.deviceModel,
    required this.bluetoothValueNotifier,
  });
  @override
  State<RecordingButtons> createState() => _RecordingButtonsState();
}

class _RecordingButtonsState extends State<RecordingButtons> {
  @override
  void initState() {
    super.initState();
    final tempFileName = widget.bluetoothValueNotifier.tempFileName;
    clearTempFile(tempFileName);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BluetoothValueNotifier>(
        builder: (context, bluetoothValueNotifier, child) {
      //double valor = bluetoothValueNotifier.bluetoothValue;
      String tempFileName = bluetoothValueNotifier.tempFileName;
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            heroTag: 'start',
            child: const Icon(Icons.play_arrow),
            onPressed: () => startRecording(
              widget.deviceModel,
              bluetoothValueNotifier,
            ),
          ),
          FloatingActionButton(
            heroTag: 'stop',
            child: const Icon(Icons.pause),
            onPressed: () => stopRecording(widget.deviceModel),
          ),
          FloatingActionButton(
            heroTag: 'file',
            child: const Icon(Icons.file_copy),
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
              child: const Icon(Icons.save),
              onPressed: () async {
                await showSaveDialog(context, tempFileName);
              }),
        ],
      );
    });
  }
}
