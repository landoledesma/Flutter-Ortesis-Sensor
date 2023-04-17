import 'package:flutter/material.dart';

import '../widgets/app_bar.dart';
import '../widgets_plot/body.dart';

class PantallaDatosTiempoReal extends StatefulWidget {
  @override
  _PantallaDatosTiempoRealState createState() =>
      _PantallaDatosTiempoRealState();
}

class _PantallaDatosTiempoRealState extends State<PantallaDatosTiempoReal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Datos en tiempo real'),
      body: Body(),
    );
  }
}
