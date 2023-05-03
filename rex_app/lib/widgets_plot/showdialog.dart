import 'package:flutter/material.dart';
import 'package:rex_app/widgets_plot/save_files.dart';

Future<void> showSaveDialog(BuildContext context, String tempFileName) async {
  TextEditingController textFieldController = TextEditingController();

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Guardar archivo CSV'),
        content: TextField(
          controller: textFieldController,
          decoration: const InputDecoration(hintText: 'Nombre del archivo'),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Aceptar'),
            onPressed: () async {
              await saveFinalCsvFile(
                  textFieldController.text, tempFileName, context);
              Navigator.of(context).pop();

              showSuccessSnackBar(context);
            },
          ),
        ],
      );
    },
  );
}
