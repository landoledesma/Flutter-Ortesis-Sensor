import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import '../screens/home.dart';
import '../screens/visualize.dart';
import '../widgets_conection/bluedvicemod.dart';

double processData(List<int> data) {
  // Comprueba si data tiene al menos un elemento
  if (data.isEmpty) {
    throw Exception('La lista de datos está vacía');
  }

  // Convierte el primer elemento de la lista en un valor double
  double doubleValue = data[0].toDouble();

  return doubleValue;
}

startRecording(BluetoothDeviceModel deviceModel,
    StreamController<double>? streamController) async {
  deviceModel.isTransmitting = true;

  // Descubrir servicios
  List<BluetoothService> services = await deviceModel.device.discoverServices();

  // Obtener servicio por UUID
  var service = services.firstWhere(
      (s) => s.uuid == Guid("12345678-1234-5678-1234-56789ABCDEF0"));

  // Obtener característica por UUID
  var characteristic = service.characteristics.firstWhere(
      (c) => c.uuid == Guid("12345678-1234-5678-1234-56789ABCDEF2"));

  var characteristicChar = service.characteristics.firstWhere((c) =>
      c.uuid ==
      Guid(
          "12345678-1234-5678-1234-56789ABCDEF1")); // Asegúrate de que este UUID coincida con _CHAR_UUID en el servidor MicroPython
  // Reads all characteristics

  // Ejemplo de cómo escribir en una característica específica
  List<int> startCommand = [
    0x01
  ]; // Comando para iniciar la transmisión, adaptar según tu dispositivo
  await characteristic.write(startCommand);

// Habilitar notificaciones para la característica _CHAR_UUID
  await characteristicChar.setNotifyValue(true);
  // Ejemplo de cómo escuchar las notificaciones de una característica específica
  //await characteristicChar.read();
  characteristicChar.value.listen((value) {
    if (deviceModel.isTransmitting) {
      if (value.isNotEmpty) {
        // Agrega esta condición para asegurarte de que el valor no esté vacío
        // Aquí se reciben los datos del dispositivo BLE
        // Convierte los datos en un valor numérico (ejemplo: double)
        double valor = processData(value); // Implementa la función processData

        // Añade el valor al StreamController
        streamController?.add(valor);
      }
    }
  });
}

void stopRecording(
  BluetoothDeviceModel deviceModel,
) async {
  deviceModel.isTransmitting = false;

  // Descubrir servicios
  List<BluetoothService> services = await deviceModel.device.discoverServices();

  // Obtener servicio por UUID
  var service = services.firstWhere(
      (s) => s.uuid == Guid("12345678-1234-5678-1234-56789ABCDEF0"));

  // Obtener característica por UUID
  var characteristic = service.characteristics.firstWhere(
      (c) => c.uuid == Guid("12345678-1234-5678-1234-56789ABCDEF2"));

  var characteristicChar = service.characteristics.firstWhere((c) =>
      c.uuid ==
      Guid(
          "12345678-1234-5678-1234-56789ABCDEF1")); // Asegúrate de que este UUID coincida con _CHAR_UUID en el servidor MicroPython
  // Reads all characteristics

  // Ejemplo de cómo escribir en una característica específica
  List<int> stopCommand = [
    0x00
  ]; // Comando para iniciar la transmisión, adaptar según tu dispositivo
  await characteristic.write(stopCommand);

  // Detiene la escucha de notificaciones para la característica
  await characteristic.setNotifyValue(false);
}
