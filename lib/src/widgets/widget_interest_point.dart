import 'package:appparticipacion/src/pages/interest_points_details_page.dart';
import 'package:appparticipacion/src/pages/interest_points_page.dart';
import 'package:flutter/material.dart';
import 'package:appparticipacion/src/models/interest_points_model.dart';
import 'package:appparticipacion/src/utils/utils.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:appparticipacion/src/widgets/widget_no_connection.dart';


Widget createInterestPoint(BuildContext context, InterestPointsModel puntoInteres){

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
        Navigator.pushNamed(context, InterestPointDetailsPage.routeName, arguments: interestPoint);
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
                image: NetworkImage(interestPoint.imageUrl),
                fit: BoxFit.fitWidth,
                ),
                title: Text(""),
                subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(interestPoint.name, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: Colors.black),),
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
                  icon: Icon(FontAwesome.globe),
                  onPressed: (){
                      openMap(interestPoint.latitude, interestPoint.longitude);
                      },
                  ),
                Expanded(child: Container()),
                FlatButton(
                  child: Row(
                    children: <Widget>[
                      Text('Más info', style: TextStyle( color: Colors.blue)),
                      SizedBox(width: 3,),
                      Icon(Icons.info_outline, color: Colors.blue,),
                    ],
                  ),
                  onPressed: (){
                    Navigator.pushNamed(context, InterestPointDetailsPage.routeName, arguments: interestPoint);
                },
              ),
            ],
            ),
          ],
      ),
    ),
  );
      } else{
        body=noConnectionToServer(context,InterestPointsPage.routeName);
      }
    } else{
      body=noConnectionToInternet();
    }
    return body;
  }