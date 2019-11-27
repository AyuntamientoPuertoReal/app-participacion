import 'package:flutter/material.dart';
import 'package:appparticipacion/src/models/interest_points_model.dart';
import 'package:appparticipacion/src/utils/utils.dart' as utils;
import 'package:flutter_icons/flutter_icons.dart';

Widget crearPuntoInteres(BuildContext context, InterestPointsModel puntoInteres){

  return InkWell(
    onTap: (){
      Navigator.pushNamed(context, 'puntoInteresDetalle', arguments: puntoInteres);
    },
    child: Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              height: 85,
              child: ListTile(
                leading: FadeInImage(
                placeholder: AssetImage('assets/img/jar-loading.gif'),
                image: NetworkImage(puntoInteres.imageUrl),
                fit: BoxFit.fitWidth,
                ),
                title: Text(""),
                subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                 // Text("Latitud: "+puntoInteres.latitude+", Longitud: "+puntoInteres.longitude),
                  //SizedBox(height: 9.0),
                  Text(puntoInteres.name, style: TextStyle(fontSize: 16, color: Colors.black),),
                ],
                ),
              ),
            ),
            SizedBox(height: 6.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(width: 5,),
                RaisedButton.icon(
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.blue,
                  textColor: Colors.white,
                  label: Text('Ver Mapa', style: TextStyle(fontSize: 18)),
                  icon: Icon(FontAwesome.getIconData("globe")),
                  onPressed: (){
                      utils.openMap(puntoInteres.latitude, puntoInteres.longitude);
                      },
                  ),
                Expanded(child: Container()),
                //SizedBox(width: 85.0),
                FlatButton(
                  child: Text('Más info', style: TextStyle(fontSize: 18)),
                  onPressed: (){
                    Navigator.pushNamed(context, 'puntoInteresDetalle', arguments: puntoInteres);
                },
              ),
            ],
            ),
          ],
      ),
    ),
  );
}
