import 'package:flutter/material.dart';

import '../screens/connection.dart';
import '../screens/visualize.dart';

class ConectarDispositivoButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PantallaConexionBluetooth(
                    devices: [],
                  )),
        );
      },
      child: Text('Conectar dispositivo'),
    );
  }
}

class CargarDatosButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PantallaDatosHistoricos()),
        );
      },
      child: Text('Cargar Datos'),
    );
  }
}
