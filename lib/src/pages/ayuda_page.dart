import 'package:flutter/material.dart';

class AyudaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Guia de uso de la aplicacion"),
      ),
      body: Stack(
        children: <Widget>[
        _fondoApp(),
         Container(
           color: Color.fromRGBO(255, 255, 255, 0.4),
           child: Column(
            children: <Widget>[
              SizedBox(height: 40),
              Container(
                child: Center(
                  child: Text("Cree una incidencia en 3 sencillos pasos", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _crearCirculo(context,"1"),
                  SizedBox(width: 70),
                  _crearCirculo(context,"2"),
                  SizedBox(width: 70),
                  _crearCirculo(context,"3"),
                ],
              ),
              Wrap(
                direction: Axis.vertical,
                children:<Widget>[ Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(width: 10),
                    _crearTexto("Elija un tipo de incidencia"),
                    SizedBox(width: 40),
                    _crearTexto("Tome su foto y ponga una descripción"),
                    SizedBox(width: 50),
                    _crearTexto("Envie su incidencia"),
                  ],
                ),
                ],
              ),
              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Text("La aplicación de Participación Puerto Real además de permitirle crear una incidencia para poder informar al ayuntamiento, podra hacer diversas acciones como por ejemplo:\n"
                  +"\n- Podrá ver el historial de todas las incidencias que haya hecho hasta el momento\n"
                  +"\n- Podrá ver todas las noticias que el Ayuntamiento escriba directamente en su móvil\n"
                  +"\n- Tendrá a su disposición una lista de puntos de interés de Puerto real con información y un enlace para como llegar"),
                ),
              )
            ],
        ),
         ),
       ],
      ),
    );
  }
}

Widget _crearCirculo(BuildContext context, String texto){
  return Container(
        width: 60,
        height: 60,
        decoration: new BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle
        ),
        child: Center(child: Text(texto, style: TextStyle(fontSize: 25, color: Colors.white))),
    );
}

Widget _crearTexto(String texto){
    return Container(
        width: 90,
        height: 70,
        child: Center(child: Text(texto, style: TextStyle(fontSize: 15, color: Colors.deepPurple),)),
    );
}

  Widget _fondoApp(){
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/img/login2.jpg'),
          fit: BoxFit.cover
        )
        // gradient: LinearGradient(
        //   begin: FractionalOffset(0.0, 0.6),
        //   end: FractionalOffset(0.0, 1.0),
        //   colors: [
        //     Color.fromRGBO(52, 54, 101, 1.0),
        //     Color.fromRGBO(35, 37, 57, 1.0)
        //   ]
        // ),
      ),
    );
  }