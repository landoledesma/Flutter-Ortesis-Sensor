import 'package:flutter/material.dart';
import 'package:rex_app/screens/connection.dart';

import '../screens/plot.dart';
import 'bluedvicemod.dart';

class StartReadingDeviceButton extends StatelessWidget {
  final bool isSwitched;
  final BluetoothDeviceModel? connectedDeviceModel;

  StartReadingDeviceButton(
      {required this.isSwitched, this.connectedDeviceModel});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isSwitched && connectedDeviceModel != null
          ? () {
              // Navegar a la pantalla "PantallaDatosTiempoReal"
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PantallaDatosTiempoReal()),
              );
            }
          : null,
      child: Text('Iniciar lectura del dispositivo',
          style: TextStyle(fontSize: 16)),
      style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
    );
  }
}
