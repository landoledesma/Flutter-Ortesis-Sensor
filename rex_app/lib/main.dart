// main.dart
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rex_app/widgets_plot/notifier.dart';
import 'screens/home.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => BluetoothValueNotifier(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mi Aplicación',
      theme: ThemeData(primarySwatch: Colors.lightBlue),
      home: InicioPantalla(),
    );
  }
}
