import 'package:appparticipacion/src/provider/interest_points_provider.dart';
import 'package:flutter/material.dart';
import 'package:appparticipacion/src/utils/utils.dart' as utils;

class InterestPointDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final InterestPointsModel puntoDeInteres = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Más información")
      ),
      body: SingleChildScrollView(
          child: Column(
              children: <Widget>[
                FadeInImage(
                  image: NetworkImage(puntoDeInteres.imageUrl),
                  placeholder: AssetImage('assets/img/jar-loading.gif'),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                  children: <Widget>[
                  Text(puntoDeInteres.name),
                  SizedBox(height: 20),
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
                       utils.openMap(puntoDeInteres.latitude, puntoDeInteres.longitude);
                        },
                      ),
                    ],
                  ),
                ),
              ],
          ),
        ),
      );

  }
}