import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
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

  double processData(List<int> data) {
    // Convierte los bytes en una cadena
    String dataString = String.fromCharCodes(data);

    // Extrae el valor numérico de la cadena
    RegExp regex = RegExp(r'El número aleatorio generado es: (\d+)\.');
    Match? match = regex.firstMatch(dataString);

    if (match == null) {
      throw Exception('No se pudo encontrar el valor numérico en la cadena');
    }

    // Convierte la parte numérica de la cadena en un valor double
    double doubleValue = double.parse(match.group(1)!);

    return doubleValue;
  }

  void _startRecording() async {
    deviceModel.isTransmitting = true;

    // Descubrir servicios
    List<BluetoothService> services =
        await deviceModel.device.discoverServices();

    // Obtener servicio por UUID
    var service = services.firstWhere((s) => s.uuid == Guid("serviceUuid"));

    // Obtener característica por UUID
    var characteristic = service.characteristics
        .firstWhere((c) => c.uuid == Guid("characteristicUuid"));

    // Ejemplo de cómo escribir en una característica específica
    List<int> startCommand = [
      0x01
    ]; // Comando para iniciar la transmisión, adaptar según tu dispositivo
    await characteristic.write(startCommand);

    // Ejemplo de cómo escuchar las notificaciones de una característica específica
    await characteristic.setNotifyValue(true);
    characteristic.value.listen((data) {
      if (deviceModel.isTransmitting) {
        // Aquí se reciben los datos del dispositivo BLE
        // Convierte los datos en un valor numérico (ejemplo: double)
        double value = processData(data); // Implementa la función processData

        // Añade el valor al StreamController
        streamController?.add(value);
      }
    });
  }

  void _stopRecording() async {
    deviceModel.isTransmitting = false;

    // Descubrir servicios
    List<BluetoothService> services =
        await deviceModel.device.discoverServices();

    // Obtener servicio por UUID
    var service = services.firstWhere((s) => s.uuid == Guid("serviceUuid"));

    // Obtener característica por UUID
    var characteristic = service.characteristics
        .firstWhere((c) => c.uuid == Guid("characteristicUuid"));

    // Ejemplo de cómo escribir en una característica específica
    List<int> stopCommand = [
      0x00
    ]; // Comando para detener la transmisión, adaptar según tu dispositivo
    await characteristic.write(stopCommand);

    // Detiene la escucha de notificaciones para la característica
    await characteristic.setNotifyValue(false);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: _startRecording,
          child: Text('Iniciar grabación'),
        ),
        ElevatedButton(
          onPressed: _stopRecording,
          child: Text('Detener grabación'),
        ),
        ElevatedButton(
          onPressed: () {
            // Navegar a pantalla de carga y visualización de datos históricos
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PantallaDatosHistoricos(),
              ),
            );
          },
          child: Text('Cargar datos históricos'),
        ),
      ],
    );
  }
}
