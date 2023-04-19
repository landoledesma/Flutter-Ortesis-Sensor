import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothFunctions {
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;
  bool isSwitched = false;
  List<ScanResult> deviceList = [];

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

  void scanDevices(Function(ScanResult) onDeviceFound) {
    flutterBlue.startScan(timeout: Duration(seconds: 4));

    var subscription = flutterBlue.scanResults.listen((results) {
      for (ScanResult r in results) {
        onDeviceFound(r);
      }
    });

    flutterBlue.stopScan();
  }
}
