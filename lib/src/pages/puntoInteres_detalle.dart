import 'package:appparticipacion/src/provider/punto_interes_provider.dart';
import 'package:flutter/material.dart';
import 'package:appparticipacion/src/utils/utils.dart' as utils;

class PuntosInteresDetallePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final PuntoInteresModel puntoDeInteres = ModalRoute.of(context).settings.arguments;

    print("name "+puntoDeInteres.name);
   // print("descripcion "+puntoDeInteres.description);

    return Scaffold(
      appBar: AppBar(
        title: Text(""+puntoDeInteres.name)
      ),
      body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
             Column(
              children: <Widget>[
                Image(
                  image: NetworkImage(puntoDeInteres.urlImage),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                  children: <Widget>[
                  Text(puntoDeInteres.description),
                  SizedBox(height: 30),
                  RaisedButton.icon(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.blue,
                    textColor: Colors.white,
                    label: Text("Ver en Google Maps", style: TextStyle(fontSize: 18)),
                    icon: Icon(Icons.compare),
                    onPressed: (){
                       utils.openMap(puntoDeInteres.geo);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
           ],

          ),
        ),
    );

  }
}