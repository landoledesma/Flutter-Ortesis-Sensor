import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothDeviceModel {
  BluetoothDevice device;
  bool isTransmitting;
  BuildContext context; // Declara la propiedad context de tipo BuildContext

  // Actualiza el constructor para aceptar el BuildContext como argumento
  BluetoothDeviceModel(
      {required this.device,
      required this.context,
      this.isTransmitting = false});
}
