import 'package:flutter/material.dart';

Widget noConnectionToInternet(){
  return Container(
    padding: EdgeInsets.all(20),
    child:Column(
      children: <Widget>[
        Center(child: Text('INFORMACIÓN',style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color.fromRGBO(162, 0, 125, 1.0)),),),
        Center(
          child: Image(
            image: AssetImage("assets/img/conexion-internet.png"),
          ),
        ),
        Center(child:Text('El dispositivo no tiene conexión a Internet.', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600))),
      ],
    )
  );
}

Widget noConnectionToServer(){
  return Container(
    padding: EdgeInsets.all(20),
    child:Column(
      children: <Widget>[
        Center(child: Text('INFORMACIÓN',style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color.fromRGBO(162, 0, 125, 1.0)),),),
        Center(
          child: Image(
            image: AssetImage("assets/img/conexion-server.png"),
          ),
        ),
        Center(child:Text('El servicio está bajo mantenimiento. Vuelva a intentarlo de nuevo más tarde.', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600))),
        SizedBox(height: 20,),
        Center(child: Text('Disculpe las molestias',style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600,color: Color.fromRGBO(162, 0, 125, 1.0))),)
      ],
    )
  );
}
