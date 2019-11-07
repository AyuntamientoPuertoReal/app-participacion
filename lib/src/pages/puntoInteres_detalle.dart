import 'package:appparticipacion/src/provider/punto_interes_provider.dart';
import 'package:flutter/material.dart';
import 'package:appparticipacion/src/utils/utils.dart' as utils;
import 'package:flutter_html/flutter_html.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PuntosInteresDetallePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final PuntoInteresModel puntoDeInteres = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(""+puntoDeInteres.name)
      ),
      body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
             Column(
              children: <Widget>[
                FadeInImage(
                  image: NetworkImage(puntoDeInteres.urlImage),
                  placeholder: AssetImage('assets/img/jar-loading.gif'),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                  children: <Widget>[
                  Text(puntoDeInteres.description),
                  SizedBox(height: 30),
                  RaisedButton.icon(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.blue,
                    textColor: Colors.white,
                    label: Text("Ver en Google Maps", style: TextStyle(fontSize: 18)),
                    icon: Icon(Icons.compare),
                    onPressed: (){
                       utils.openMap(puntoDeInteres.geo);
                        },
                      ),

                      Container(
                        child: WebView(
                          initialUrl: Uri.dataFromString('<html><head></head><body><div class="mapouter"><div class="gmap_canvas"><iframe width="200" height="300" id="gmap_canvas" src="https://maps.google.com/maps?q=36.52866345,-6.143663&t=&z=13&ie=UTF8&iwloc=&output=embed" frameborder="0" scrolling="no" marginheight="0" marginwidth="0"></iframe></div><style>.mapouter{position:relative;text-align:right;height:300px;width:500px;}.gmap_canvas {overflow:hidden;background:none!important;height:500px;width:600px;}</style></div></body></html>', mimeType: 'text/html').toString(),
                        ),
                      )
                     // _mostrarHtml(puntoDeInteres)
                    ],
                  ),
                ),
              ],
            ),
           ],
          ),
        ),
    );

  }
}

 Widget _mostrarHtml(PuntoInteresModel puntoInteresModel) {
   String lat;
   String long;

   return Html(
    data: '<div class="mapouter"><div class="gmap_canvas"><iframe width="200" height="300" id="gmap_canvas" src="https://maps.google.com/maps?q=36.52866345,-6.143663&t=&z=13&ie=UTF8&iwloc=&output=embed" frameborder="0" scrolling="no" marginheight="0" marginwidth="0"></iframe></div><style>.mapouter{position:relative;text-align:right;height:300px;width:500px;}.gmap_canvas {overflow:hidden;background:none!important;height:500px;width:600px;}</style></div>',
    // data: '<p>buenas</p>',
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
      //_launchUrl(url);
    },
    onImageTap: (src) {
      print(src);
    },
  );
}