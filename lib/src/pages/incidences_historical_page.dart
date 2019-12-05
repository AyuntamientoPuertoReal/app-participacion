import 'dart:async';

import 'package:appparticipacion/src/bloc/provider.dart';
import 'package:appparticipacion/src/bloc/incidence_bloc.dart';
import 'package:appparticipacion/src/models/incidence_model.dart';
import 'package:appparticipacion/src/pages/incidence_details_page.dart';
import 'package:appparticipacion/src/widgets/widget_estado.dart';
import 'package:connectivity/connectivity.dart';
import 'package:intl/intl.dart';
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
      ),
      body: FutureBuilder(
        future: serverDataChecker(context),
        initialData: cancelConexion(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.data;
        },
      ),
      
    );
  }

 Widget _crearListadoTickets(BuildContext context, IncidenceBloc ticketBloc) {

   return StreamBuilder(
     stream: ticketBloc.ticketStream,
     builder: (BuildContext context, AsyncSnapshot<List<IncidenceModel>> snapshot ){
      
      if(snapshot.hasData){

        final data = snapshot.data;
        
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            var fecha=DateTime.parse(data[index].fechaCreacion);
            var formatter = new DateFormat('dd/MM/yyyy hh:mm');
            String fechaFormateada = formatter.format(fecha);
              return InkWell(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.only(right: 10, left: 10),
                      child: Row(
                        children: <Widget>[
                          Text(data[index].nombreIncidencia,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                          Expanded(child: Container(),),
                          estado(data[index].estado.toString()),
                        ],
                      ),
                    ),
                    ListTile(
                      leading: FadeInImage(
                        image: NetworkImage(urlImage+data[index].pictureUrl),
                        placeholder: AssetImage('assets/img/jar-loading.gif'),
                        width: 50.0,
                        fit: BoxFit.contain,
                      ),
                      title: Text(data[index].descripcion,overflow: TextOverflow.ellipsis,),
                      subtitle: Row(
                        children: <Widget>[
                          Text("Enviada el "+fechaFormateada),
                        ],
                      ),
                      onTap: (){

                        Navigator.pushNamed(context, IncidenceDetailsPage.routeName, arguments: data[index]);
                      },
                    ),
                    
                    Divider(
                      thickness: 1.0,
                      color: Colors.black,
                    ),
                  ],
                ),
                onTap: (){
                  Navigator.pushNamed(context, IncidenceDetailsPage.routeName, arguments: data[index]);
                },
              );
          },
        );
      }else {
         return Center(child: CircularProgressIndicator());
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
        final ticketBloc = Provider.ticketbloc(context);
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