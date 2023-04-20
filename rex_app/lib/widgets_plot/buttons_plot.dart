import 'package:flutter/material.dart';

import '../screens/home.dart';
import '../screens/visualize.dart';

class RecordingButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            // Implementar función para iniciar grabación
          },
          child: Text('Iniciar grabación'),
        ),
        ElevatedButton(
          onPressed: () {
            // Implementar función para detener grabación
          },
          child: Text('Detener grabación'),
        ),
        ElevatedButton(
          onPressed: () {
            // Navegar a pantalla de carga y visualización de datos históricos
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PantallaDatosHistoricos(),
              ),
            );
          },
          child: Text('Cargar datos históricos'),
        ),
      ],
    );
  }
}
