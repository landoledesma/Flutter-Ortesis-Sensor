// pantalla_datos_historicos.dart
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class PantallaDatosHistoricos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visualizar datos históricos'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
          ),
          ElevatedButton(
            onPressed: () {
              // Aquí irá la lógica para seleccionar y cargar un archivo CSV
            },
            child: Text('Cargar archivo CSV'),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              // Aquí irá la gráfica que muestra los datos históricos del sensor
              child: Center(
                child: Text('Gráfica de datos históricos del sensor'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
