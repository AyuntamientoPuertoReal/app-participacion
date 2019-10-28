import 'package:flutter/material.dart';
import 'package:appparticipacion/src/models/puntos_interes_model.dart';
import 'package:appparticipacion/src/utils/utils.dart' as utils;
import 'package:flutter_icons/flutter_icons.dart';

Widget crearPuntoInteres(BuildContext context, PuntoInteresModel puntoInteres){

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
                      // leading: Icon(Icons.photo_album,color: Colors.blue,),
                      leading: Image(
                       // image: AssetImage('assets/img/no-image.png'),
                      image: NetworkImage(puntoInteres.urlImage),
                        fit: BoxFit.fitWidth,
                      ),
                      title: Text(puntoInteres.name),
                      subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(puntoInteres.geo),
                        SizedBox(height: 15.0),
                        Text(puntoInteres.description, overflow: TextOverflow.ellipsis),
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
                          label: Text("Ver Mapa", style: TextStyle(fontSize: 18)),
                          icon: Icon(FontAwesome.getIconData("globe")),
                          onPressed: (){
                             utils.openMap(puntoInteres.geo);
                              },
                          ),
                          Expanded(child: Container(),),
                          //SizedBox(width: 85.0),
                        FlatButton(
                          child: Text('Mas info'),
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
