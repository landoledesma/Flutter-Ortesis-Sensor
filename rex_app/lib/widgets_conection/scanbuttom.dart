import 'package:flutter/material.dart';

class ScanDevicesButton extends StatelessWidget {
  final bool isSwitched;
  final VoidCallback? onPressed;

  ScanDevicesButton({required this.isSwitched, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isSwitched ? onPressed : null,
      child: Text('Escanear dispositivos', style: TextStyle(fontSize: 16)),
      style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
    );
  }
}
