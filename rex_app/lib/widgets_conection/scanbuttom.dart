import 'package:flutter/material.dart';
import 'package:rex_app/screens/connection.dart';
import 'package:rex_app/widgets_conection/bluetooth_function.dart';

class ScanDevicesButton extends StatelessWidget {
  //final Function? onPressed;
  final bool isSwitched;

  ScanDevicesButton({required this.isSwitched});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isSwitched
          ? () async {
              // Navega a PantallaConexionBluetooth primero
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PantallaConexionBluetooth(),
                ),
              );

              // Comienza el escaneo después de que la pantalla de conexión se haya abierto
              BluetoothFunctions().scanDevices((foundDevice) {
                PantallaConexionBluetooth.of(context).addDevice(foundDevice);
              });
            }
          : null,
      child: Text('Escanear dispositivos', style: TextStyle(fontSize: 16)),
      style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
    );
  }
}
