import 'dart:async';

import 'package:appparticipacion/src/bloc/news_bloc.dart';
import 'package:appparticipacion/src/bloc/provider.dart';
import 'package:appparticipacion/src/models/news_model.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:appparticipacion/src/widgets/widget_news.dart';
import 'package:appparticipacion/src/utils/utils.dart';
import 'package:appparticipacion/src/widgets/widget_no_connection.dart';


class NewsPage extends StatefulWidget {
  static final String routeName = 'news';

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  IconData icono = Icons.zoom_in;
  bool noticiaGrande=false;


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
        title: Text("Noticias"),
        actions: <Widget>[
          FlatButton(
            child: Icon(icono, color: Colors.white, size: 37.0),
            onPressed: (){
              if(noticiaGrande == false){
                noticiaGrande=true;
                icono = Icons.zoom_out;
                setState(() {
                  
                });
              }else {
                noticiaGrande=false;
                icono = Icons.zoom_in;
                setState(() {
                  
                });
              }
            },
          )
        ],
      ),
      backgroundColor: Color.fromRGBO(231, 242, 252, 1.0),
      body: FutureBuilder(
        future: serverDataChecker(context),
        initialData: cancelConnection(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.data;
        },
      ),
    );
  }

  Widget _crearListadoNoticias(NewsBloc noticiabloc) {

    return StreamBuilder(
      stream: noticiabloc.newsStream ,
      builder: (BuildContext context, AsyncSnapshot<List<NewsModel>> snapshot){
      if(snapshot.hasData){
        if(snapshot.data.length==0){
          return Container(
            child: Center(
              child: Text('No hay noticias para mostrar.', style: TextStyle(fontSize: 16),),
            ),
          );
        }else{
          final data = snapshot.data;
          return ListView.builder(
            padding: EdgeInsets.all(12.0),
            itemCount: snapshot.data.length,
            itemBuilder: (context, i) { 
              return Column(
                children: <Widget>[
                  SizedBox(height: 15.0),
                    _crearNoticia(context,data[i]),
                ],
              );
              }
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
        final noticiaBloc = Provider.noticiaBloc(context);
        noticiaBloc.cargarNoticia();
        body = _crearListadoNoticias(noticiaBloc);
      } else{
        body=noConnectionToServer(context,'news');
      }
    } else{
      body=noConnectionToInternet();
    }
    return body;
  }


  _crearNoticia(BuildContext context ,NewsModel noticiaModel) {

    if(noticiaGrande){
    return enlargedNews(context,noticiaModel); 
    } else {
    return defaultNews(context,noticiaModel); 
    }


  }
}