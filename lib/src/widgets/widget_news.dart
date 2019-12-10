import 'package:appparticipacion/src/models/news_model.dart';
import 'package:appparticipacion/src/pages/new_details_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
   
   
Widget  defaultNews(BuildContext context, NewsModel noticia) {

    var fecha=DateTime.parse(noticia.date);
    var formatter = new DateFormat('dd/MM/yyyy hh:mm');
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
            Container(
              height: 115,
              child: ListTile(
                leading: FadeInImage(
                  image: NetworkImage(noticia.imageUrl),
                  placeholder: AssetImage('assets/img/jar-loading.gif'),
                  fit: BoxFit.fitWidth,
                  width: 60,
                  height: 120,
                ),
                title: Text(noticia.title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(fechaFormateada),
                    SizedBox(height: 15.0),
                    Expanded(child: Text(noticia.description, maxLines: 2, overflow: TextOverflow.ellipsis,)),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
              FlatButton(
                child: Text('Ver Noticia', style: TextStyle(color: Colors.blue),),
                onPressed: (){
                  Navigator.pushNamed(context, NewDetails.routeName, arguments: noticia);
                },
              ),
            ],
            ),
          ],
        ),
      ),
    );
          
}

Widget enlargedNews(BuildContext context, NewsModel noticia){

  var fecha=DateTime.parse(noticia.date);
  var formatter = new DateFormat('dd/MM/yyyy hh:mm');
  String fechaFormateada = formatter.format(fecha);

  final card = Container(
    padding: EdgeInsets.all(10),
    child: Column(
      children: <Widget>[
        SizedBox(height: 10,),
        Text(noticia.title, style: TextStyle(fontSize: 18), maxLines: 3, textAlign: TextAlign.center,),
        SizedBox(height: 10,),
        FadeInImage(
            image: NetworkImage(noticia.imageUrl),
            placeholder: AssetImage('assets/img/jar-loading.gif'),
            fadeInDuration: Duration(seconds: 4 ),
        ),
        Container(
          height: 100,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Text(noticia.title, style: TextStyle(fontSize: 18)),
              SizedBox(height: 15.0),
              Text(fechaFormateada),
              SizedBox(height: 15.0),
              Expanded(child: Text(noticia.description, maxLines: 2, overflow: TextOverflow.ellipsis,))
            ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            FlatButton(
              child: Text('Ver Noticia', style: TextStyle(color: Colors.blue)),
              onPressed: (){
                Navigator.pushNamed(context, NewDetails.routeName, arguments: noticia);
                },
            ),
          ],
        ),
      ],
    ),

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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: card,
        ),
    ),
  );

}




