import 'dart:async';

import 'package:appparticipacion/src/bloc/incidence_types_bloc.dart';
import 'package:appparticipacion/src/pages/create_incidence_page.dart';
import 'package:appparticipacion/src/provider/incidence_types_provider.dart';
import 'package:appparticipacion/src/utils/utils.dart';
import 'package:appparticipacion/src/widgets/widget_no_connection.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:appparticipacion/src/bloc/provider.dart';

class IncidenceTypesPage extends StatefulWidget {
  static final String routeName = 'incidenceTypes';
  @override
  _IncidenceTypesPageState createState() => _IncidenceTypesPageState();
}

class _IncidenceTypesPageState extends State<IncidenceTypesPage> {

  bool status;
  


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
        title: Text('Nueva Incidencia'),
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
  }

  Widget _cargarTiposIncidencias(BuildContext context,TipoIncidenciaBloc tipoIncidenciaBloc){
    return StreamBuilder(
      stream: tipoIncidenciaBloc.tipoIncidenciaStream,
      builder: (BuildContext context, AsyncSnapshot<List<IncidenceTypesModel>> snapshot ){
        if(snapshot.hasData){
          List<Widget> listaTipos= [];
          snapshot.data.forEach((f){
            listaTipos.add(
              ListTile(
                title: Row(
                  children:<Widget>[
                    Text(f.name),
                    Expanded(
                      child: Container(),
                    ),
                    Icon(Icons.arrow_forward_ios,color: Theme.of(context).primaryColor,)
                  ]
                ),
                onTap: (){

                  Navigator.pushNamed(context, CreateIncidencePage.routeName, arguments: f);

                },
              )
            );
            listaTipos.add(
              Divider(
                thickness: 1.0,
              )
            );
          });

          return Column(
            children: <Widget>[
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(14),
                child: Text('Elige el tipo de incidencia que quieres enviar al Ayuntamiento: ', style: TextStyle(fontSize: 20),)
              ),
              SizedBox(height: 10),
              Divider(
                thickness: 0.0,
              ),
              new Expanded(
                child: ListView(
                  children: listaTipos.toList(),
                ),
              )
            ]
          );
        } else{
          return cancelConnection(context);
        }
      }
    );
  }

  Future<Widget> serverDataChecker(BuildContext context)async {
    
    Widget body;
    bool internet = await checkInternetConnection();
    
    if (internet){
      bool servidor = await checkServerConnection();
      if(servidor){
        final tipoIncidenciaBloc = Provider.tipoIncidenciaBloc(context);
        tipoIncidenciaBloc.cargarTipoIncidencia();
        body=_cargarTiposIncidencias(context,tipoIncidenciaBloc);
       
      } else{
        body=noConnectionToServer(context,IncidenceTypesPage.routeName);
      }
    } else{
      body=noConnectionToInternet();
    }
    return body;
  }