import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:csv/csv.dart';
import 'package:rex_app/screens/select_files.dart';

import '../widgets_visualize/chart_file.dart';

class PantallaDatosHistoricos extends StatefulWidget {
  @override
  _PantallaDatosHistoricosState createState() =>
      _PantallaDatosHistoricosState();
}

class _PantallaDatosHistoricosState extends State<PantallaDatosHistoricos> {
  List<List<dynamic>>? _datos;
  String? _selectedFilePath;

  Future<void> _cargarArchivoCSV() async {
    final filePath = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => SeleccionarArchivoScreen()),
    );

    if (filePath != null) {
      final input = new File(filePath).openRead();
      final fields = await input
          .transform(utf8.decoder)
          .transform(new CsvToListConverter())
          .toList();

      setState(() {
        _datos = fields;
        _selectedFilePath = filePath;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Visualizar datos históricos')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: _cargarArchivoCSV,
            child: Text('Cargar archivo CSV'),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: _datos != null
                  ? SensorChart(datos: _datos!)
                  : Center(
                      child: Text('Gráfica de datos históricos del sensor'),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
