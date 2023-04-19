import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../widgets_conection/bluetooth_function.dart';
import '../widgets_conection/body_conect.dart';

class PantallaConexionBluetooth extends StatefulWidget {
  PantallaConexionBluetooth({Key? key}) : super(key: key);

  @override
  _PantallaConexionBluetoothState createState() =>
      _PantallaConexionBluetoothState();
}

class _PantallaConexionBluetoothState extends State<PantallaConexionBluetooth> {
  BluetoothFunctions bluetoothFunctions = BluetoothFunctions();
  List<ScanResult> devices = [];

  void addDevices(Set<ScanResult> foundDevices) {
    setState(() {
      devices.clear();
      devices.addAll(foundDevices);
    });
  }

  void startScanning() {
    bluetoothFunctions.scanDevices(addDevices);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conectar dispositivo'),
      ),
      body: Body(
        isSwitched: bluetoothFunctions.isSwitched,
        toggleBluetooth: (bool value) => bluetoothFunctions.toggleBluetooth(
          context,
          value,
          setState,
        ),
        scanDevices:
            startScanning, // Pasa startScanning en lugar de bluetoothFunctions.scanDevices
        deviceList: devices,
        startScanning: startScanning, // Pasa la función startScanning
      ),
    );
  }
}
