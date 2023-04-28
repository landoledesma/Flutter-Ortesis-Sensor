import 'package:flutter/material.dart';
import 'package:rex_app/widgets_plot/save_files.dart';

Future<void> showSaveDialog(BuildContext context, String tempFileName) async {
  TextEditingController textFieldController = TextEditingController();

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Guardar archivo CSV'),
        content: TextField(
          controller: textFieldController,
          decoration: InputDecoration(hintText: 'Nombre del archivo'),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Aceptar'),
            onPressed: () {
              saveFinalCsvFile(textFieldController.text, tempFileName, context);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
