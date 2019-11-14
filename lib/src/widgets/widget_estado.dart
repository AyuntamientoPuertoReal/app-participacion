import 'package:flutter/material.dart';

Widget estado(String estado){
  
  Color color;
  Color colorTexto=Colors.white;
  Color colorBorde=Colors.black;
  String texto='';

  switch(estado){
    case '1': color=Colors.white;colorTexto=Colors.black;colorBorde=colorTexto;texto='Enviada';break;
    case '2': color=Colors.orangeAccent;colorTexto=Colors.black;colorBorde=color;texto='En proceso';break;
    case '3': color=Colors.redAccent[700];colorBorde=color;texto='Desestimada';break;
    case '4': color=Colors.green;colorBorde=color;texto='Finalizada';break;
  }

  return Container(
    padding: EdgeInsets.all(4),
    //color: color,
    child: Text(texto, style: TextStyle(color: colorTexto),),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: color,
      border: Border.all(
        width: 1,
        color: colorBorde
      )
    ),
  );
}