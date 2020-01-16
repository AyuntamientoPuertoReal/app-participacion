import 'dart:async';

import 'package:appparticipacion/src/bloc/provider.dart';
import 'package:appparticipacion/src/bloc/incidence_bloc.dart';
import 'package:appparticipacion/src/models/incidence_model.dart';
import 'package:appparticipacion/src/search/search_delegateHistorical.dart';
import 'package:appparticipacion/src/widgets/widget_historical_incidences.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:appparticipacion/src/utils/utils.dart';
import 'package:appparticipacion/src/widgets/widget_no_connection.dart';


class IncidencesHistoricalPage extends StatefulWidget {
  static final String routeName = 'incidencesHistorical';
  @override
  _IncidencesHistoricalPageState createState() => _IncidencesHistoricalPageState();
}

class _IncidencesHistoricalPageState extends State<IncidencesHistoricalPage> {



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
        title: Text("Mis Incidencias"),
        actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: (){
                showSearch(context: context, delegate: DataSearchHistorical());
              }
            )
        ],
      ),
      body: FutureBuilder(
        future: serverDataChecker(context),
        initialData: cancelConnection(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.data;
        },
      ),
      
    );
  }

 Widget _crearListadoTickets(BuildContext context, IncidenceBloc ticketBloc) {

   return StreamBuilder(
     stream: ticketBloc.incidenceStream,
     builder: (BuildContext context, AsyncSnapshot<List<IncidenceModel>> snapshot ){
      
      if(snapshot.hasData){

        final data = snapshot.data;
        if(data.isEmpty){
          return Container(
            child: Center(
              child: Text('No has enviado ninguna incidencia.', textAlign: TextAlign.center, style: TextStyle(fontSize: 16),),
            ),
          );
        } else{
            return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return historicalIncidences(context, data[index]);
            },
          );
        }
        
      }else {
         return cancelConnection(context);
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
        final ticketBloc = Provider.incidenciaBloc(context);
        ticketBloc.cargartickets();
        body = _crearListadoTickets(context,ticketBloc);
      } else{
        body=noConnectionToServer(context,IncidencesHistoricalPage.routeName);
      }
    } else{
      body=noConnectionToInternet();
    }
    return body;
  }

  


}