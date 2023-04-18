import 'package:flutter/material.dart';
import 'package:rex_app/screens/connection.dart';
import 'package:rex_app/widgets_conection/bluetooth_function.dart';

import '../screens/plot.dart';
// Importa la clase BluetoothFunctions

class ScanDevicesButton extends StatelessWidget {
  //final Function? onPressed;
  final bool isSwitched;

  ScanDevicesButton({required this.isSwitched});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isSwitched
          ? () {
              BluetoothFunctions().scanDevices((foundDevices) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PantallaConexionBluetooth(devices: foundDevices),
                  ),
                );
              });
            }
          : null,
      child: Text('Escanear dispositivos', style: TextStyle(fontSize: 16)),
      style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
    );
  }
}

class StartReadingDeviceButton extends StatelessWidget {
  final bool isSwitched;

  StartReadingDeviceButton({required this.isSwitched});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isSwitched
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
