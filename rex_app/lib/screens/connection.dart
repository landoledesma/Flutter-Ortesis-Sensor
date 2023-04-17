import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import '../widgets_conection/body_conect.dart';

class PantallaConexionBluetooth extends StatefulWidget {
  @override
  _PantallaConexionBluetoothState createState() =>
      _PantallaConexionBluetoothState();
}

class _PantallaConexionBluetoothState extends State<PantallaConexionBluetooth> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  bool isSwitched = false;
  List<ScanResult> deviceList = [];

  void _toggleBluetooth(bool value) {
    setState(() {
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

  void _scanDevices() {
    // Implementar lógica para escanear dispositivos Bluetooth
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conectar dispositivo'),
      ),
      body: Body(
        isSwitched: isSwitched,
        toggleBluetooth: _toggleBluetooth,
        scanDevices: _scanDevices,
        deviceList: deviceList,
      ),
    );
  }
}
