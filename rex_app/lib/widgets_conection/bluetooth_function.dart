import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothFunctions {
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  bool isSwitched = false;
  Set<ScanResult> deviceSet = {}; // Cambiado a Set para evitar duplicados

  void toggleBluetooth(BuildContext context, bool value, Function updateState) {
    updateState(() {
      isSwitched = value;
    });
    if (value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Por favor, habilite manualmente el Bluetooth'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Por favor, deshabilite manualmente el Bluetooth'),
      ));
    }
  }

  void scanDevices(Function(Set<ScanResult>) onDevicesFound) async {
    // Iniciar el escaneo
    await flutterBlue.startScan(timeout: Duration(seconds: 4));

    // Suscribirse a los resultados del escaneo
    StreamSubscription<List<ScanResult>> subscription;
    subscription = flutterBlue.scanResults.listen((results) {
      for (ScanResult r in results) {
        deviceSet.add(r); // Agrega el dispositivo al Set en lugar de la lista
      }
    });

    // Detener el escaneo después del tiempo de espera y cancelar la suscripción
    await Future.delayed(Duration(seconds: 4));
    await flutterBlue.stopScan();
    subscription.cancel();

    // Llamar a la función de devolución de llamada con el conjunto de dispositivos actualizado
    onDevicesFound(deviceSet);
  }
}
