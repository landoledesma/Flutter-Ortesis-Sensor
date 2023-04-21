import 'package:flutter/material.dart';

import '../widgets/app_bar.dart';
import '../widgets_plot/body_plot.dart';
import '../widgets_conection/bluedvicemod.dart';

class PantallaDatosTiempoReal extends StatefulWidget {
  final BluetoothDeviceModel deviceModel;

  PantallaDatosTiempoReal({required this.deviceModel});

  @override
  _PantallaDatosTiempoRealState createState() =>
      _PantallaDatosTiempoRealState();
}

class _PantallaDatosTiempoRealState extends State<PantallaDatosTiempoReal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Datos en tiempo real'),
      body: Body(deviceModel: widget.deviceModel),
    );
  }
}
