import 'package:flutter/material.dart';

void showModal(BuildContext context, String mensaje){
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context){
        return AlertDialog(
          contentPadding: EdgeInsets.all(14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          title:Text('Ayuda'),
          content: Scrollbar(
            child: SingleChildScrollView(
              child: Column( 
                children:<Widget>[
                  Text(mensaje),
                ],
              ),
            ),
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