import 'package:appparticipacion/src/models/news_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
   
   
Widget  cardTipo1() {
          
              return Card(
                elevation: 10.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Image(
                        image: AssetImage('assets/img/no-image.png'),
                      ),
                      title: Text('Soy el titulo de esta Noticia'),
                      subtitle: Text('Aqui estamo con la descripcion de la Noticia de prueba con la que estamos tranajando en este proyecto'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                      FlatButton(
                        child: Text('Ver Noticia'),
                        onPressed: (){},
                      ),
                    ],)
                  ],
                ),
              );
          
    }

Widget  defaultNews(BuildContext context, NewsModel noticia) {

    var fecha=DateTime.parse(noticia.date);
    var formatter = new DateFormat('dd/MM/yyyy hh:mm');
    String fechaFormateada = formatter.format(fecha);

          
              return InkWell(
                onTap: (){
                  Navigator.pushNamed(context, 'noticiasDetalle', arguments: noticia);
                },
                child: Card(
                  elevation: 10.0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        height: 85,
                        child: ListTile(
                          leading: FadeInImage(
                            image: NetworkImage(noticia.imageUrl),
                            placeholder: AssetImage('assets/img/jar-loading.gif'),
                            fit: BoxFit.fitWidth,
                          ),
                          title: Text(noticia.title),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(fechaFormateada),
                              SizedBox(height: 15.0),
                              Expanded(child: Text(noticia.description)),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                        FlatButton(
                          child: Text('Ver Noticia'),
                          onPressed: (){
                            Navigator.pushNamed(context, 'noticiasDetalle', arguments: noticia);
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
            
          child: Column(
            children: <Widget>[
              SizedBox(height: 10,),
              Text(noticia.title, style: TextStyle(fontSize: 18)),
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
                    Expanded(child: Text(noticia.description))
                  ],
                 ),
                ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[
                 FlatButton(
                   child: Text('Ver Noticia'),
                    onPressed: (){
                      Navigator.pushNamed(context, 'noticiasDetalle', arguments: noticia);
                     },
                  ),
                ],
              ),
            ],
          ),

        );


    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, 'noticiasDetalle', arguments: noticia);
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




