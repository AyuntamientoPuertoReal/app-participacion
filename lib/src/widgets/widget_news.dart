import 'package:appparticipacion/src/models/news_model.dart';
import 'package:appparticipacion/src/pages/new_details_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

   
   
Widget  defaultNews(BuildContext context, NewsModel noticia) {

  var fecha=DateTime.parse(noticia.date);
  fecha=fecha.toLocal();
  var formatter = new DateFormat('dd/MM/yyyy HH:mm');
  String fechaFormateada = formatter.format(fecha);


  return InkWell(
    onTap: (){
      Navigator.pushNamed(context, NewDetails.routeName, arguments: noticia);
    },
    child: Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(height: 8),
          ListTile(
            leading: FadeInImage(
              image: NetworkImage(noticia.imageUrl),
              placeholder: AssetImage('assets/img/jar-loading.gif'),
              fit: BoxFit.fitWidth,
              width: 60,
              height: 120,
            ),
            title: Text(noticia.title, style: TextStyle( fontWeight: FontWeight.w800, fontSize: 16),),
            subtitle: Text(fechaFormateada),
          ),
          SizedBox(height: 5,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Text(noticia.description, style: TextStyle(fontSize: 15))
          ),
          Container(
            alignment: Alignment.centerRight,
            child: FlatButton(
              child: Text('Ver Noticia', style: TextStyle(color: Colors.blue),),
              onPressed: (){
                Navigator.pushNamed(context, NewDetails.routeName, arguments: noticia);
              },
            ),
          ),
        ],
      )
    ),
  );
}

Widget enlargedNews(BuildContext context, NewsModel noticia){

  var fecha=DateTime.parse(noticia.date);
  var formatter = new DateFormat('dd/MM/yyyy hh:mm');
  String fechaFormateada = formatter.format(fecha);

  final card = Container(
    padding: EdgeInsets.all(15),
    child: Column(
      children: <Widget>[
        Text(noticia.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800), textAlign: TextAlign.center,),
        SizedBox(height: 10,),
        FadeInImage(
          image: NetworkImage(noticia.imageUrl),
          placeholder: AssetImage('assets/img/jar-loading.gif'),
          fadeInDuration: Duration(seconds: 4 ),
        ),
        Text(fechaFormateada),
        SizedBox(height: 15,),
        Text(noticia.description, style: TextStyle(fontSize: 15),),
        Center(
          child: FlatButton(
            child: Text('Ver Noticia', style: TextStyle(color: Colors.blue),),
            onPressed: (){
              Navigator.pushNamed(context, NewDetails.routeName, arguments: noticia);
            },
          ),
        ),
      ],
    )
  );

  return InkWell(
    onTap: (){
      Navigator.pushNamed(context, NewDetails.routeName, arguments: noticia);
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            blurRadius: 20.0,
            spreadRadius: 2.0,
            offset: Offset(2.0, 10.0)
            )
        ]
      ),
        child: card,
    ),
  );

}
