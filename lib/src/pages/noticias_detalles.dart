import 'package:appparticipacion/src/models/noticias_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

class NoticiasDetalles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final NoticiaModel noticia = ModalRoute.of(context).settings.arguments;
    print(noticia.body.toString());

    print(noticia.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(noticia.title),
      ),
      body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FadeInImage(
                image: NetworkImage(noticia.imageUrl),
                placeholder: AssetImage('assets/img/jar-loading.gif'),
                fadeInDuration: Duration(milliseconds: 150),
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              SizedBox(height: 20.0,),
              _crearTitulo(context, noticia),
              _crearDescripcion(context, noticia)
            ],
          ),
        ),
    );
  }
  

//  Widget _crearAppBar(NoticiaModel noticia) {
//    return SliverAppBar(
//     elevation: 2.0,
//     backgroundColor: Colors.indigo,
//     expandedHeight: 200.0,
//     floating: false,
//     pinned: true,

//     flexibleSpace: FlexibleSpaceBar(
//         centerTitle: true,
//          background: FadeInImage(
//            image: NetworkImage(noticia.imageUrl),
//            placeholder: AssetImage('assets/img/loading.gif'),
//            fadeInDuration: Duration(milliseconds: 150),
//            fit: BoxFit.cover,
//          ),  
//      ),
//    );
//  }

 Widget _crearTitulo(BuildContext context, NoticiaModel noticiaModel) {

   return Container(
     padding: EdgeInsets.symmetric(horizontal: 20.0),
     child: Row(
       children: <Widget>[
         SizedBox(width: 20.0),
         Flexible(
           child: Column(
             children: <Widget>[
               Text(noticiaModel.title, style: Theme.of(context).textTheme.title),
               SizedBox(height: 15.0),
               Text(noticiaModel.description, style: Theme.of(context).textTheme.subhead),
             ],
           ),
         )
       ],
     ),
   );


  }

Widget _crearDescripcion(BuildContext context, NoticiaModel noticiaModel) {

     return Container(
     padding: EdgeInsets.all(20.0),
     child: _mostrarHtml(noticiaModel)
   );

  }
}

 Widget _mostrarHtml(NoticiaModel noticia) {
   return Html(
     data: noticia.body,
    //Optional parameters:
    padding: EdgeInsets.all(8.0),
    useRichText: false,
    //backgroundColor: Colors.white70,
    defaultTextStyle: TextStyle(fontFamily: 'serif'),
    linkStyle: const TextStyle(
      color: Colors.redAccent,
    ),
    onLinkTap: (url) {
      // open url in a webview
      print("Opening $url...");
      _launchUrl(url);
    },
    onImageTap: (src) {
      print(src);
    },
  );
}

void _launchUrl(String url) async {
    if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}