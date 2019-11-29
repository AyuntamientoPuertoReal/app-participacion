import 'dart:async';

import 'package:appparticipacion/src/bloc/provider.dart';
import 'package:appparticipacion/src/bloc/interest_points_bloc.dart';
import 'package:appparticipacion/src/widgets/widget_puntos_interes.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:appparticipacion/src/utils/utils.dart';
import 'package:appparticipacion/src/widgets/widget_no_connection.dart';


class InterestPointsPage extends StatefulWidget {
  @override
  _InterestPointsPageState createState() => _InterestPointsPageState();
}

class _InterestPointsPageState extends State<InterestPointsPage> {

  var _connectionStatus = 'Unknown';
  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    super.initState();
    connectivity = new Connectivity();
    subscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _connectionStatus = result.toString();
      print(_connectionStatus);
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        setState(() {});
      } else {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Puntos de Interés"),
      ),
      body: FutureBuilder(
        future: serverDataChecker(context),
        initialData: Container(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.data;
        },
      ),
    );
  }

Widget _crearListadoPuntosInteres(InterestPointsBloc puntoIntereBloc) {

  return StreamBuilder(
    stream: puntoIntereBloc.puntoInteresStream ,
    builder: (BuildContext context, AsyncSnapshot snapshot){
      
      if(snapshot.hasData){
        final data = snapshot.data;
        return ListView.builder(
          padding: EdgeInsets.all(12.0),
          itemCount: data.length,
          itemBuilder: (context, i){
            return Column(
              children: <Widget>[
                _crearPuntoInteres(context,data[i]),
                SizedBox(height: 10)
              ],
            );
          },
        );
      }else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }

    },
  );


}

  Future<Widget> serverDataChecker(BuildContext context)async {
    
    Widget body;
    bool internet = await checkInternetConnection();
    
    if (internet){
      bool servidor = await checkServerConnection();
      if(servidor){
        final puntoIntereBloc = Provider.puntoInteresBloc(context);
        puntoIntereBloc.cargarPuntosInteres();
        body=_crearListadoPuntosInteres(puntoIntereBloc);
      } else{
        body=noConnectionToServer();
      }
    } else{
      body=noConnectionToInternet();
    }
    return body;
  }

  _crearPuntoInteres(BuildContext context, data) {

    return crearPuntoInteres(context, data);

  }


}