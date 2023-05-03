import 'package:flutter/material.dart';

class BluetoothValueNotifier extends ChangeNotifier {
  double _bluetoothValue = 0;
  String tempFileName = 'temp_${UniqueKey().toString()}.csv';

  double get bluetoothValue => _bluetoothValue;

  void updateBluetoothValue(double value) {
    _bluetoothValue = value;
    notifyListeners();
  }
}
