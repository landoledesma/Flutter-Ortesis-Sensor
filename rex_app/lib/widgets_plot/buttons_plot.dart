import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rex_app/widgets_plot/save_files.dart';
import 'package:rex_app/widgets_plot/send_data.dart';
import 'package:rex_app/widgets_plot/showdialog.dart';
import '../screens/visualize.dart';
import '../widgets_conection/bluedvicemod.dart';
import 'notifier.dart';
import 'package:restart_app/restart_app.dart';

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
          FloatingActionButton(
            heroTag: 'restart',
            child: const Icon(Icons.restart_alt),
            onPressed: () {
              Restart.restartApp();
            },
          ),
        ],
      );
    });
  }
}
