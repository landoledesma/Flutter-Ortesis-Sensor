import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:rex_app/widgets_conection/buttoms_conect.dart';
import 'package:rex_app/widgets_conection/scanbuttom.dart';

class Body extends StatelessWidget {
  final bool isSwitched;
  final Function(bool) toggleBluetooth;
  final Function scanDevices;
  final List<ScanResult> deviceList;
  final VoidCallback startScanning;
  final Function(BuildContext, BluetoothDevice) connectAndShowAlert;

  Body({
    required this.isSwitched,
    required this.toggleBluetooth,
    required this.scanDevices,
    required this.deviceList,
    required this.startScanning,
    required this.connectAndShowAlert, // Agrega esto también
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SwitchListTile(
            title: Text(
              'Habilitar/Desabilitar Bluetooth',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            value: isSwitched,
            onChanged: (bool value) {
              toggleBluetooth(value);
            },
          ),
          SizedBox(height: 24),
          Text(
            'Estado de conexión:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 24),
          ScanDevicesButton(
            isSwitched: isSwitched,
            onPressed: startScanning,
          ),
          SizedBox(height: 24),
          Text(
            'Dispositivos encontrados:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          // Muestra la lista de dispositivos usando ListTile
          ...deviceList.map((device) => ListTile(
                title: Text(device.device.name),
                subtitle: Text(device.device.id.toString()),
                onTap: () => connectAndShowAlert(
                    context, device.device), // Agrega el callback aquí
              )),
          SizedBox(height: 24),
          StartReadingDeviceButton(isSwitched: isSwitched),
        ],
      ),
    );
  }
}
