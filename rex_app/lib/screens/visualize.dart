import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:rex_app/screens/select_files.dart';

import '../widgets_visualize/csv_graph.dart';

class PantallaDatosHistoricos extends StatefulWidget {
  @override
  _PantallaDatosHistoricosState createState() =>
      _PantallaDatosHistoricosState();
}

class _PantallaDatosHistoricosState extends State<PantallaDatosHistoricos> {
  String? _selectedFilePath;

  Future<void> _cargarArchivoCSV() async {
    final filePath = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => SeleccionarArchivoScreen()),
    );

    if (filePath != null) {
      setState(() {
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
              child: _selectedFilePath != null
                  ? CsvGraph(filePath: _selectedFilePath)
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
