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
      body: CustomScrollView(
       slivers: <Widget>[
         _crearAppBar(noticia),
         SliverList(
           delegate: SliverChildListDelegate(
             [
               SizedBox(height: 10.0),
               _crearTitulo(context, noticia),
               _crearDescripcion(context,noticia),
             ]
           ),
         )
       ],
      ),
    );
  }

 Widget _crearAppBar(NoticiaModel noticia) {
   return SliverAppBar(
    elevation: 2.0,
    backgroundColor: Colors.indigo,
    expandedHeight: 200.0,
    floating: false,
    pinned: true,

    flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
       // title: Text(noticia.title,style: TextStyle(color: Colors.white, fontSize: 16.0)),
         background: FadeInImage(
           image: NetworkImage(noticia.imageUrl),
           placeholder: AssetImage('assets/img/loading.gif'),
           fadeInDuration: Duration(milliseconds: 150),
           fit: BoxFit.cover,
         ),  
     ),
   );
 }

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
   //String prueba="<a href='https://github.com'>https://github.com</a><br />";
   return Html(
     data: noticia.body
  /*"""
    <!--For a much more extensive example, look at example/main.dart-->
    <div>
      <h1>Demo Page</h1>
      <p>This is a fantastic nonexistent product that you should buy!</p>
      <h2>Pricing</h2>
      <p>Lorem ipsum <b>dolor</b> sit amet.</p>
      <h2>The Team</h2>
      <p>There isn't <i>really</i> a team...</p>
      <h2>Installation</h2>
      <p>You <u>cannot</u> install a nonexistent product!</p>
      <!--You can pretty much put any html in here!-->
    </div>
  """*/,
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

      // Display the image in large form.
      print(src);
    },
  //Must have useRichText set to false for this to work.
  );
}

void _launchUrl(String url) async {
    if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}