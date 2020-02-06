import 'dart:async';
import 'package:appparticipacion/src/bloc/provider.dart';
import 'package:appparticipacion/src/bloc/interest_points_bloc.dart';
import 'package:appparticipacion/src/search/search_delegate.dart';
import 'package:appparticipacion/src/widgets/widget_interest_point.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:appparticipacion/src/utils/utils.dart';
import 'package:appparticipacion/src/widgets/widget_no_connection.dart';
import 'package:flutter_icons/flutter_icons.dart';


class InterestPointsPage extends StatefulWidget {
  static final String routeName = 'interestPoints';
  @override
  _InterestPointsPageState createState() => _InterestPointsPageState();
}

class _InterestPointsPageState extends State<InterestPointsPage> {

  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> subscription;

  @override
  void initState() {
    super.initState();
        connectivity = new Connectivity();
        subscription = connectivity.onConnectivityChanged.listen((ConnectivityResult result) async {
          if (result == ConnectivityResult.wifi || result == ConnectivityResult.mobile) {
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
            actions: <Widget>[
            IconButton(
              icon: Icon(MaterialIcons.find_in_page, color: Colors.white, size: 37.0),
              onPressed: (){
                showSearch(context: context, delegate: DataSearch());
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
    
    Widget _crearListadoPuntosInteres(InterestPointsBloc puntoIntereBloc) {
    
      return StreamBuilder(
        stream: puntoIntereBloc.interestPointsStream ,
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
            final puntoIntereBloc = Provider.puntoInteresBloc(context);
            puntoIntereBloc.loadInterestPoint();
            body=_crearListadoPuntosInteres(puntoIntereBloc);
          } else{
            body=noConnectionToServer(context,InterestPointsPage.routeName);
          }
        } else{
          body=noConnectionToInternet();
        }
        return body;
      }
    
      _crearPuntoInteres(BuildContext context, data) {
    
        return createInterestPoint(context, data);
    
      }
    


}