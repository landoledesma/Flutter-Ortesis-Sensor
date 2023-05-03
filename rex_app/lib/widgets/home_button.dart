import 'package:flutter/material.dart';
import '../screens/home.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({super.key});

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
      child: const Icon(Icons.home),
      tooltip: 'Ir al inicio',
    );
  }
}
