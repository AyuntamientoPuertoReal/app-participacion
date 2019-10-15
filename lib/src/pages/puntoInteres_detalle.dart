import 'package:appparticipacion/src/provider/punto_interes_provider.dart';
import 'package:flutter/material.dart';

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
      body: Center(
        child: Column(
          children: <Widget>[
            Image(
              image: NetworkImage(puntoDeInteres.urlImage),
            ),
            SizedBox(height: 10),
            Text(puntoDeInteres.description),
            SizedBox(height: 10),
            Text(puntoDeInteres.geo)
          ],
        ),
      ),
    );
  }
}