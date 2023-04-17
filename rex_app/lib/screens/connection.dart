import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:rex_app/screens/plot.dart';

class PantallaConexionBluetooth extends StatefulWidget {
  @override
  _PantallaConexionBluetoothState createState() =>
      _PantallaConexionBluetoothState();
}

class _PantallaConexionBluetoothState extends State<PantallaConexionBluetooth> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  bool isSwitched = false;
  List<ScanResult> deviceList = [];

  void _toggleBluetooth(bool value) {
    setState(() {
      isSwitched = value;
    });
    if (value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Por favor, habilite manualmente el Bluetooth'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Por favor, deshabilite manualmente el Bluetooth'),
      ));
    }
  }

  void _scanDevices() {
    deviceList.clear();
    flutterBlue.startScan(timeout: Duration(seconds: 50));
    // Listen to scan results
    var subscription = flutterBlue.scanResults.listen((results) {
      // do something with scan results
      for (ScanResult r in results) {
        print('${r.device.name} found! ');
      }
    });

    flutterBlue.stopScan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conectar dispositivo'),
      ),
      body: SingleChildScrollView(
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
                _toggleBluetooth(value);
              },
            ),
            SizedBox(height: 24),
            Text(
              'Estado de conexión:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: isSwitched
                  ? () {
                      _scanDevices();
                    }
                  : null,
              child:
                  Text('Escanear dispositivos', style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50)),
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
            ElevatedButton(
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
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50)),
            ),
          ],
        ),
      ),
    );
  }
}
