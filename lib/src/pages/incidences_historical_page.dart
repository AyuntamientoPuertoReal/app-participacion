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
  String _dropMenuSelectedOption = "Todas las incidencias";
  List _incidencesStatus = ['Todas las incidencias','Incidencias en proceso','Incidencias finalizadas'];

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

 Widget _crearListadoincidences(BuildContext context, IncidencesBloc incidenceBloc) {
   List<IncidenceModel> dataStatus;

   return StreamBuilder(
     stream: incidenceBloc.incidenceStream,
     builder: (BuildContext context, AsyncSnapshot<List<IncidenceModel>> snapshot ){
      
      if(snapshot.hasData){
        final data = snapshot.data;
        

        if(_dropMenuSelectedOption == "Todas las incidencias"){
          dataStatus = data;
        }else if(_dropMenuSelectedOption == "Incidencias en proceso"){
          dataStatus = data.where((i) => i.estado==2 || i.estado==1).toList();
        }else if(_dropMenuSelectedOption == "Incidencias finalizadas"){
          dataStatus = data.where((i) => i.estado==3 || i.estado==4).toList();
        }


        
        if(dataStatus.isEmpty){
          return Container(
            child: Center(
              child: Text('No has enviado ninguna incidencia.', textAlign: TextAlign.center, style: TextStyle(fontSize: 16),),
            ),
          );
        } else{
          return Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      'Mostrar ', style: TextStyle(fontSize: 16)
                      )
                    ),
                  _incidenceDropDown()
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: dataStatus.length,
                  itemBuilder: (BuildContext context, int index) {
                    return historicalIncidences(context, dataStatus[index]);
                  },
                ),
              ),
            ],
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
        final incidenceBloc = Provider.incidenciaBloc(context);
        incidenceBloc.loadIncidence();
        body = _crearListadoincidences(context,incidenceBloc);
      } else{
        body=noConnectionToServer(context,IncidencesHistoricalPage.routeName);
      }
    } else{
      body=noConnectionToInternet();
    }
    return body;
  }

   List<DropdownMenuItem<String>> getOpcionesDropDown() {
    
   List<DropdownMenuItem<String>> lista =  new List();

   _incidencesStatus.forEach((status){
     lista.add(DropdownMenuItem(
       child: Text(status),
       value: status,
     ));
   });

  return lista;

  }

 Widget _incidenceDropDown() {

   return Row(
      children: <Widget>[
        SizedBox(width: 4,),
        DropdownButton(
        value: _dropMenuSelectedOption,
        items: getOpcionesDropDown(),
        onChanged: (opt){
        setState(() {
        _dropMenuSelectedOption=opt;
        });
      },
     )
    ],
   );
   
 }




}