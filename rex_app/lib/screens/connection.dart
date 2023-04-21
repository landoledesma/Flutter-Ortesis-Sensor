import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../widgets_conection/bluedvicemod.dart';
import '../widgets_conection/bluetooth_function.dart';
import '../widgets_conection/body_conect.dart';

// Importa el modelo BluetoothDeviceModel

class PantallaConexionBluetooth extends StatefulWidget {
  PantallaConexionBluetooth({Key? key}) : super(key: key);

  @override
  _PantallaConexionBluetoothState createState() =>
      _PantallaConexionBluetoothState();
}

class _PantallaConexionBluetoothState extends State<PantallaConexionBluetooth> {
  BluetoothFunctions bluetoothFunctions = BluetoothFunctions();
  List<ScanResult> devices = [];

  // Variable para almacenar el dispositivo conectado y su estado de transmisión
  BluetoothDeviceModel? connectedDeviceModel;

  Future<void> connectAndShowAlert(
      BuildContext context, BluetoothDevice device) async {
    bool isConnected = await bluetoothFunctions.connectToDevice(device);
    if (isConnected) {
      // Almacena el dispositivo conectado en la instancia de BluetoothDeviceModel
      // e incluye el contexto como argumento

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Conexión exitosa'),
            content: Text(
                'Te has conectado exitosamente al dispositivo ${device.name}.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      connectedDeviceModel =
          BluetoothDeviceModel(device: device, context: context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No se pudo conectar al dispositivo ${device.name}.'),
        ),
      );
    }
  }

  void addDevice(ScanResult device) {
    setState(() {
      devices.add(device);
    });
  }

  void startScanning() {
    bluetoothFunctions.scanDevices(addDevice);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conectar dispositivo'),
      ),
      body: Body(
        isSwitched: bluetoothFunctions.isSwitched,
        connectedDeviceModel: connectedDeviceModel,
        toggleBluetooth: (bool value) => bluetoothFunctions.toggleBluetooth(
          context,
          value,
          setState,
        ),
        scanDevices:
            startScanning, // Pasa startScanning en lugar de bluetoothFunctions.scanDevices
        deviceList: devices,
        startScanning: startScanning,
        connectAndShowAlert:
            connectAndShowAlert, // Pasa la función startScanning
      ),
    );
  }
}
