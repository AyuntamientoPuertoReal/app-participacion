import 'package:flutter/material.dart';

Widget estado(String estado){
  
  Color color;
  Color colorTexto=Colors.white;
  Color colorBorde=Colors.black;
  String texto='';

  switch(estado){
    case '1': color=Colors.white;colorTexto=Colors.black;colorBorde=colorTexto;texto='Enviada';break;
    case '2': color=Colors.orangeAccent;colorTexto=Colors.black;colorBorde=color;texto='En proceso';break;
    case '3': color=Colors.green;colorBorde=color;texto='Finalizada';break;
    case '4': color=Colors.redAccent[700];colorBorde=color;texto='Desestimada';break;
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

Widget estado2(String estado){
  
  Color color;
  Color colorTexto=Colors.white;
  Color colorBorde=Colors.black;
  String texto='';

  switch(estado){
    case '1': texto='Enviada';break;
    case '2': texto='En proceso';break;
    case '3': texto='Finalizada';break;
    case '4': texto='Desestimada';break;
  }

  return Container(
    //padding: EdgeInsets.all(4),
    //color: color,
    child: Text(texto, style: TextStyle(fontSize: 18, color: colorTexto, fontWeight: FontWeight.w800)),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: color,
    ),
  );
}