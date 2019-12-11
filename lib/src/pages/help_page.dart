import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {

  static final String routeName = 'help';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Guia de uso de la aplicación"),
      ),
      body: Stack(
        children: <Widget>[
        _fondoApp(),
         SingleChildScrollView(
           child: Container(
             padding: EdgeInsets.all(15),
             color: Color.fromRGBO(255, 255, 255, 0.4),
             child: Column(
              children: <Widget>[
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text("SOBRE ESTA APLICACIÓN", style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500, color: Theme.of(context).primaryColor))
                  ),
                SizedBox(height: 15),
                Container(
                  child: Text("Esta herramienta permite a los ciudadanos y ciudadanas informar al Ayuntamiento de Puerto Real de las distintas incidencias que sean detectadas en el municipio. \n\nEl ayuntamiento informará sobre las actuaciones que se lleven a cabo para la resolucion de dichas incidencias.\n\nAdicionalmente, podrá informarse sobre las noticias actuales sobre Participación Ciudadana, así como sobre los Puntos de interés del municipio.\n", style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500))
                  ),
                SizedBox(height: 5),
                 Image(
                  image: AssetImage("assets/img/botones.png"),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text("A continuación le vamos a explicar todo lo que puede hacer con la Aplicación:\n", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500))
                  ),
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text("ENVIAR INCIDENCIA:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Theme.of(context).primaryColor)),
                ),
                SizedBox(height: 5),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text("Podrá crear una incidencia que se enviará al ayuntamiento para su posterior arreglo.", style: TextStyle(fontSize: 15))
                  ),
                Container(
                  child: Center(
                    child: Text("Cree una incidencia en 3 sencillos pasos", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Theme.of(context).primaryColor)),
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
                  children:<Widget>[ 
                    Row(
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
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text("MIS INCIDENCIA:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Theme.of(context).primaryColor)),
                ),
                SizedBox(height: 5),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text("Aqui podrá ver todas las incidencias que haya creado hasta el momento junto al estado de las mismas. Además de que si selecciona una incidencia podra ver todo el seguimiento del ayuntamiento sobre la misma.", style: TextStyle(fontSize: 15))
                  ),
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text("NOTICIAS:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Theme.of(context).primaryColor)),
                ),
                SizedBox(height: 5),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text("En esta pantalla se mostraran todas las noticias relacionadas con Participación Ciudadana", style: TextStyle(fontSize: 15))
                  ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text("PUNTOS DE INTERÉS:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Theme.of(context).primaryColor)),
                ),
                SizedBox(height: 5),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text("Esta pantalla contiene una lista de puntos de interés de Puerto Real, Seleccionando un punto de interés en concreto podra ver información sobre el mismo y podra acceder a un enlace a Google Maps para poder ver su localización", style: TextStyle(fontSize: 15))
                  ),
                // Container(
                //   padding: EdgeInsets.all(10),
                //   child: Center(
                //     child: Text("\n"
                //     +"\n- Podrá ver el historial de todas las incidencias que haya hecho hasta el momento\n"
                //     +"\n- Podrá ver todas las noticias que el Ayuntamiento escriba directamente en su móvil\n"
                //     +"\n- Tendrá a su disposición una lista de puntos de interés de Puerto real con información y un enlace para como llegar", style: TextStyle(fontSize: 15)),
                //   ),
                // ),
              ],
            ),
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
      ),
    );
  }