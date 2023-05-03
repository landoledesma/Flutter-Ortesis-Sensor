import 'dart:async';
import 'package:flutter/material.dart';
//import 'package:rex_app/widgets_plot/buttons_plot.dart';
import '../widgets/app_bar.dart';
import '../widgets_plot/body_plot.dart';
import '../widgets_conection/bluedvicemod.dart';

class PantallaDatosTiempoReal extends StatefulWidget {
  final BluetoothDeviceModel deviceModel;

  const PantallaDatosTiempoReal({super.key, required this.deviceModel});
  @override
  _PantallaDatosTiempoRealState createState() =>
      _PantallaDatosTiempoRealState();
}

class _PantallaDatosTiempoRealState extends State<PantallaDatosTiempoReal> {
  late final StreamController<double> streamController =
      StreamController<double>();
  StreamSubscription<double>? streamSubscription;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Datos en tiempo real'),
      body: Body(deviceModel: widget.deviceModel),
      /* bottomNavigationBar: Padding(
        padding: EdgeInsets.all(8.0),
        child: RecordingButtons(
          deviceModel: widget.deviceModel,
          streamController: streamController,
        ),
      ),*/
    );
  }
}
