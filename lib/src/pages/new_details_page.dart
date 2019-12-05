import 'package:appparticipacion/src/models/news_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

class NewDetails extends StatelessWidget {

  static final String routeName = 'newDetails';
  @override
  Widget build(BuildContext context) {

    final NewsModel noticia = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Volver a Noticias"),
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
              SizedBox(height: 30.0,),
              Text(noticia.title, style: Theme.of(context).textTheme.title, textAlign: TextAlign.center,),
              SizedBox(height: 5.0,),
              _crearDescripcion(context, noticia)
            ],
          ),
        ),
    );
  }
  
Widget _crearDescripcion(BuildContext context, NewsModel noticiaModel) {

     return Container(
     padding: EdgeInsets.all(20.0),
     child: _mostrarHtml(noticiaModel)
   );

  }
}

Widget _mostrarHtml(NewsModel noticia) {
  return Html(
    data: noticia.body,
    //Optional parameters:
    padding: EdgeInsets.all(8.0),
    useRichText: false,
    defaultTextStyle: TextStyle(fontFamily: 'sans-serif'),
    linkStyle: const TextStyle(
      color: Colors.redAccent,
    ),
    onLinkTap: (url) {
      // open url in a webview
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