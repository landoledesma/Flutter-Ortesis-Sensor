import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class SeleccionarArchivoScreen extends StatelessWidget {
  const SeleccionarArchivoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Seleccionar archivo CSV')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['csv'],
            );
            if (result != null) {
              Navigator.pop(context, result.files.single.path);
            }
          },
          child: const Text('Seleccionar archivo'),
        ),
      ),
    );
  }
}
