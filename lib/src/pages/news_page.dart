import 'package:appparticipacion/src/bloc/news_bloc.dart';
import 'package:appparticipacion/src/bloc/provider.dart';
import 'package:appparticipacion/src/models/news_model.dart';
import 'package:flutter/material.dart';
import 'package:appparticipacion/src/widgets/widget_noticia.dart';


class NewsPage extends StatefulWidget {

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  IconData icono = Icons.zoom_in;
  bool noticiaGrande=false;
  @override
  Widget build(BuildContext context) {

    final noticiaBloc = Provider.noticiaBloc(context);
    noticiaBloc.cargarNoticia();
    

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
      body: _crearListadoNoticias(noticiaBloc),
    );
  }

  Widget _crearListadoNoticias(NewsBloc noticiabloc) {

    return StreamBuilder(
      stream: noticiabloc.noticiasStream ,
      builder: (BuildContext context, AsyncSnapshot<List<NewsModel>> snapshot){
      if(snapshot.hasData){
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
      }else {
        return Center(child: CircularProgressIndicator());
      }
      },
    );
  }

  _crearNoticia(BuildContext context ,NewsModel noticiaModel) {

    if(noticiaGrande){
    return enlargedNews(context,noticiaModel); 
    } else {
    return defaultNews(context,noticiaModel); 
    }


  }
}