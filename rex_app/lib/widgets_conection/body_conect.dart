import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:rex_app/widgets_conection/buttoms_conect.dart';

class Body extends StatelessWidget {
  final bool isSwitched;
  final Function(bool) toggleBluetooth;
  final Function scanDevices;
  final List<ScanResult> deviceList;

  Body({
    required this.isSwitched,
    required this.toggleBluetooth,
    required this.scanDevices,
    required this.deviceList,
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
            onPressed: isSwitched ? scanDevices : null,
          ),
          SizedBox(height: 24),
          Text(
            'Dispositivos encontrados:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          ...deviceList.map((device) => ListTile(
                title: Text(device.device.name),
                subtitle: Text(device.device.id.toString()),
              )),
          SizedBox(height: 24),
          StartReadingDeviceButton(isSwitched: isSwitched),
        ],
      ),
    );
  }
}
