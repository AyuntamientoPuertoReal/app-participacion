import 'package:flutter/material.dart';

Widget widgetNoConnection(String mensaje){
  return Container(
    padding: EdgeInsets.all(40),
    child:Column(
      children: <Widget>[
        Center(child:Text(mensaje)),
        Image(
          image: AssetImage("assets/img/jar-loading.gif"),
        )
      ],
    )
  );
}
