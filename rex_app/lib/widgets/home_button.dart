import 'package:flutter/material.dart';

import '../screens/home.dart';

class HomeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => InicioPantalla(),
          ),
          (Route<dynamic> route) => false,
        );
      },
      child: Icon(Icons.home),
      tooltip: 'Ir al inicio',
    );
  }
}
