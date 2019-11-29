import 'package:appparticipacion/src/provider/interest_points_provider.dart';
import 'package:flutter/material.dart';
import 'package:appparticipacion/src/utils/utils.dart';
import 'package:appparticipacion/src/widgets/widget_no_connection.dart';

class InterestPointDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final InterestPointsModel puntoDeInteres = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Más información")
      ),
      body: FutureBuilder(
        future: serverDataChecker(context, puntoDeInteres),
        initialData: Container(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.data;
        },
      ),
    );

  }



    Future<Widget> serverDataChecker(BuildContext context, InterestPointsModel interestPoint)async {
    
    Widget body;
    bool internet = await checkInternetConnection();
    
    if (internet){
      bool servidor = await checkServerConnection();
      if(servidor){

      body =  SingleChildScrollView(
          child: Column(
              children: <Widget>[
                FadeInImage(
                  image: NetworkImage(interestPoint.imageUrl),
                  placeholder: AssetImage('assets/img/jar-loading.gif'),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                  children: <Widget>[
                  Text(interestPoint.name),
                  SizedBox(height: 20),
                  Text(interestPoint.description),
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
                        openMap(interestPoint.latitude, interestPoint.longitude);
                        },
                      ),
                    ],
                  ),
                ),
              ],
          ),
        );
      } else{
        body=noConnectionToServer();
      }
    } else{
      body=noConnectionToInternet();
    }
    return body;
  }

}