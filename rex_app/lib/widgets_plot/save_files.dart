import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
//import 'package:rex_app/screens/plot.dart';
//import '../screens/home.dart';
//import '../screens/visualize.dart';
import '../widgets_conection/bluedvicemod.dart';

late final BluetoothDeviceModel deviceModel;

Future<bool> requestStoragePermission() async {
  final status = await Permission.storage.request();
  return status.isGranted;
}

Future<void> clearTempFile(String tempFileName) async {
  try {
    String? tempDirectoryPath = (await getTemporaryDirectory()).path;
    final tempFile = File('$tempDirectoryPath/$tempFileName');
    if (await tempFile.exists()) {
      await tempFile.delete();
    }
  } on PlatformException catch (e) {
    print("Error al eliminar el archivo temporal: $e");
  }
}

Future<void> appendDataToTempFile(double valor, String tempFileName) async {
  try {
    String? tempDirectoryPath = (await getTemporaryDirectory()).path;
    final tempFile = File('$tempDirectoryPath/$tempFileName');
    String newEntry = valor.toString() + '\n';
    await tempFile.writeAsString(newEntry, mode: FileMode.append);
  } on PlatformException catch (e) {
    print("Error al guardar el archivo temporal: $e");
  }
}

Future<void> saveFinalCsvFile(
    String fileName, String tempFileName, BuildContext context) async {
  try {
    String? tempDirectoryPath = (await getTemporaryDirectory()).path;
    final tempFile = File('$tempDirectoryPath/$tempFileName');

    String? directoryPath = await FilePicker.platform.getDirectoryPath();
    if (directoryPath != null && await tempFile.exists()) {
      final directory = Directory(directoryPath);
      final file = File('${directory.path}/$fileName.csv');
      await tempFile.copy(file.path);
      showSuccessSnackBar(context);
    }
  } on PlatformException catch (e) {
    print("Error al guardar el archivo final: $e");
  }
}

void showSuccessSnackBar(context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Archivo guardado con éxito!'),
      duration: Duration(seconds: 2),
    ),
  );
}
