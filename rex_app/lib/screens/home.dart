import 'package:flutter/material.dart';

import '../widgets/app_bar.dart';
import '../widgets_inicio/inicio.dart';

class InicioPantalla extends StatefulWidget {
  @override
  _InicioPantallaState createState() => _InicioPantallaState();
}

class _InicioPantallaState extends State<InicioPantalla> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Inicio',
      ),
      body: Column(
        children: <Widget>[
          Image.asset('assets/logos.jpg'),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/c-brace.jpg'),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ConectarDispositivoButton(),
                      CargarDatosButton(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
