import 'package:flutter/material.dart';
import 'package:appparticipacion/src/models/interest_points_model.dart';
import 'package:appparticipacion/src/utils/utils.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:appparticipacion/src/widgets/widget_no_connection.dart';
import 'package:flutter_advanced_networkimage/provider.dart';


Widget crearPuntoInteres(BuildContext context, InterestPointsModel puntoInteres){

  return FutureBuilder(
        future: serverDataChecker(context, puntoInteres),
        initialData: Container(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.data;
        },
      );
}



  Future<Widget> serverDataChecker(BuildContext context, InterestPointsModel interestPoint)async {
    
    Widget body;
    bool internet = await checkInternetConnection();
    
    if (internet){
      bool servidor = await checkServerConnection();
      if(servidor){

    body= InkWell(
      onTap: (){
        Navigator.pushNamed(context, 'puntoInteresDetalle', arguments: interestPoint);
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
                image: AdvancedNetworkImage(
                  interestPoint.imageUrl,
                  useDiskCache: true,
                  cacheRule: CacheRule(maxAge: const Duration(days: 7))
                ), //cargarImagen(interestPoint.imageUrl),
                fit: BoxFit.fitWidth,
                ),
                title: Text(""),
                subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                 // Text("Latitud: "+puntoInteres.latitude+", Longitud: "+puntoInteres.longitude),
                  //SizedBox(height: 9.0),
                  Text(interestPoint.name, style: TextStyle(fontSize: 16, color: Colors.black),),
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
                  label: Text('Ver Mapa', style: TextStyle(fontSize: 15)),
                  icon: Icon(FontAwesome.getIconData("globe")),
                  onPressed: (){
                      openMap(interestPoint.latitude, interestPoint.longitude);
                      },
                  ),
                Expanded(child: Container()),
                //SizedBox(width: 85.0),
                FlatButton(
                  child: Row(
                    children: <Widget>[
                      Text('Más info', style: TextStyle( color: Colors.blue)),
                      SizedBox(width: 3,),
                      Icon(Icons.info_outline, color: Colors.blue,),
                    ],
                  ),
                  onPressed: (){
                    Navigator.pushNamed(context, 'puntoInteresDetalle', arguments: interestPoint);
                },
              ),
            ],
            ),
          ],
      ),
    ),
  );
      } else{
        body=noConnectionToServer();
      }
    } else{
      body=noConnectionToServer();
    }
    return body;
  }