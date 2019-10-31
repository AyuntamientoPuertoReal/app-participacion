import 'package:flutter/material.dart';

Widget estado(String estado){
  
  Color color;
  switch(estado){
    case 'Finalizada': color=Colors.green;break;
    case 'Desestimada': color=Colors.red;break;
    case 'En Proceso': color=Colors.blue;break;
    case 'Enviada': color=Colors.orange;break;
  }

  return Container(
    padding: EdgeInsets.all(4),
    //color: color,
    child: Text(estado, style: TextStyle(color: Colors.white),),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: color
    ),
  );
}