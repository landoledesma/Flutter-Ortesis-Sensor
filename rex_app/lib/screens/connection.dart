import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../widgets_conection/bluetooth_function.dart';
import '../widgets_conection/body_conect.dart';

class PantallaConexionBluetooth extends StatefulWidget {
  final List<ScanResult> devices;

  PantallaConexionBluetooth({required this.devices});

  @override
  _PantallaConexionBluetoothState createState() =>
      _PantallaConexionBluetoothState();
}

class _PantallaConexionBluetoothState extends State<PantallaConexionBluetooth> {
  BluetoothFunctions bluetoothFunctions = BluetoothFunctions();

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
        scanDevices: bluetoothFunctions.scanDevices,
        deviceList: widget.devices, // Cambia esto para usar la lista recibida
      ),
    );
  }
}
