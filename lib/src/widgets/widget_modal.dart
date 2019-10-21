import 'package:flutter/material.dart';

void mostrarModal(BuildContext context, String mensaje){
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context){
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title:Text('Ayuda'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(mensaje),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Aceptar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      }
    );
  }