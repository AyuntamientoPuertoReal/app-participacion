import 'package:flutter/material.dart';

Widget estado(String estado){
  
  Color color;
  Color colorTexto=Colors.white;
  Color colorBorde=Colors.black;

  switch(estado){
    case 'Finalizada': color=Colors.green;colorBorde=color;break;
    case 'Desestimada': color=Colors.redAccent[700];colorBorde=color;break;
    case 'En Proceso': color=Colors.orangeAccent;colorTexto=Colors.black;colorBorde=color;break;
    case 'Enviada': color=Colors.white;colorTexto=Colors.black;colorBorde=colorTexto;break;
  }

  return Container(
    padding: EdgeInsets.all(4),
    //color: color,
    child: Text(estado, style: TextStyle(color: colorTexto),),
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