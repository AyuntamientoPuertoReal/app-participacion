import 'dart:io';

import 'package:appparticipacion/src/bloc/noticias_bloc.dart';
import 'package:appparticipacion/src/bloc/provider.dart';
import 'package:appparticipacion/src/models/noticias_model.dart';
import 'package:appparticipacion/src/pages/home_page.dart';
import 'package:appparticipacion/src/widgets/menu_lateral.dart';
import 'package:flutter/material.dart';
import 'package:appparticipacion/src/widgets/widget_noticia.dart';


class NoticiasPage extends StatefulWidget {


  @override
  _NoticiasPageState createState() => _NoticiasPageState();
}

class _NoticiasPageState extends State<NoticiasPage> {
  IconData icono = Icons.zoom_in;
  bool noticiaGrande=false;
  @override
  Widget build(BuildContext context) {

    final noticiaBloc = Provider.noticiaBloc(context);
    noticiaBloc.cargarNoticia();
    

    return Scaffold(
      drawer: MenuLateralWidget(),
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

 Widget _crearListadoNoticias(NoticiaBloc noticiabloc) {

   return StreamBuilder(
     stream: noticiabloc.noticiasStream ,
     builder: (BuildContext context, AsyncSnapshot<List<NoticiaModel>> snapshot){
       if(snapshot.hasData){
         final data = snapshot.data;
      
       //return noticia2(snapshot.data[0]);
       return ListView.builder(
         padding: EdgeInsets.all(20.0),
         itemCount: snapshot.data.length,
         itemBuilder: (context, i) { 
           return Column(
             children: <Widget>[
               SizedBox(height: 15.0),
                _crearNoticia(context,data[i]),
                SizedBox(height: 15.0),
             ],
           );
           }
       );

       /* return Container(
         child: Text(snapshot.data[0].description),
       );*/

       }else {
         return Center(child: CircularProgressIndicator());
       }
     },
   );
 }

  _crearNoticia(BuildContext context ,NoticiaModel noticiaModel) {

    if(noticiaGrande){
    return noticia3(context,noticiaModel); 
    } else {
    return noticia2(context,noticiaModel); 
    }

  }


}