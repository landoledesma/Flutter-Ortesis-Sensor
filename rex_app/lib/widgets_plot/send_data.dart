import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:rex_app/widgets_plot/notifier.dart';
import 'package:rex_app/widgets_plot/save_files.dart';
import '../widgets_conection/bluedvicemod.dart';

double processData(List<int> data) {
  if (data.isEmpty) {
    // Comprueba si data tiene al menos un elemento
    throw Exception('La lista de datos está vacía');
  }
  // Convierte el primer elemento de la lista en un valor double
  double doubleValue = data[0].toDouble();
  return doubleValue;
}

startRecording(BluetoothDeviceModel deviceModel,
    BluetoothValueNotifier bluetoothValueNotifier) async {
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
  List<int> startCommand = [
    0x01
  ]; // Comando para iniciar la transmisión, adaptar según tu dispositivo
  await characteristic.write(startCommand);
// Habilitar notificaciones para la característica _CHAR_UUID
  await characteristicChar.setNotifyValue(true);
  // Ejemplo de cómo escuchar las notificaciones de una característica específica
  characteristicChar.value.listen((value) {
    // Aquí se reciben los datos del dispositivo BLE
    if (deviceModel.isTransmitting) {
      if (value.isNotEmpty) {
        // Agrega esta condición para asegurarte de que el valor no esté vacío
        // Convierte los datos en un valor numérico (ejemplo: double)
        double valor = processData(value); // Implementa la función processData
        bluetoothValueNotifier.updateBluetoothValue(valor);
        appendDataToTempFile(valor, bluetoothValueNotifier.tempFileName);
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
  List<int> stopCommand = [
    0x00
  ]; // Comando para detener la transmisión, adaptar según tu dispositivo
  await characteristic.write(stopCommand);
  await characteristic.setNotifyValue(false);
}
