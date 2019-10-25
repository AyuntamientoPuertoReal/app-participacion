import 'package:appparticipacion/src/models/noticias_model.dart';
import 'package:flutter/material.dart';
   
   
Widget  cardTipo1() {
          
              return Card(
                elevation: 10.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                child: Column(
                  children: <Widget>[
                    ListTile(
                     // leading: Icon(Icons.photo_album,color: Colors.blue,),
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

Widget  noticia2(BuildContext context, NoticiaModel noticia) {
          
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
                         // leading: Icon(Icons.photo_album,color: Colors.blue,),
                          leading: Image(
                           // image: AssetImage('assets/img/no-image.png'),
                            image: NetworkImage(noticia.imageUrl),
                            fit: BoxFit.fitWidth,
                          ),
                          title: Text(noticia.title),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(noticia.date),
                              SizedBox(height: 15.0),
                              Text(noticia.description, overflow: TextOverflow.ellipsis),
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

Widget noticia3(BuildContext context, NoticiaModel noticia){

final card = Container(
            
          child: Column(
            children: <Widget>[
              
              FadeInImage(

                 image: NetworkImage(noticia.imageUrl),
                 placeholder: AssetImage('assets/img/jar-loading.gif'),
                 fadeInDuration: Duration(seconds: 4 ),
              ),
              /*
              Image(
                image: NetworkImage('https://diariomisiones.com/wp-content/uploads/2019/04/milos-meme-1024x531.jpg'),
              ),
              */
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Text(noticia.title, style: TextStyle(fontSize: 18)),
                    SizedBox(height: 15.0),
                    Text(noticia.date),
                    SizedBox(height: 15.0),
                    Text(noticia.description, overflow: TextOverflow.ellipsis)
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




