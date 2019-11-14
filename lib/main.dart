import 'package:appparticipacion/src/bloc/provider.dart';
import 'package:appparticipacion/src/pages/abrir_ticket_page.dart';
import 'package:appparticipacion/src/pages/ayuda_page.dart';
import 'package:appparticipacion/src/pages/detalle_ticket_page.dart';
import 'package:appparticipacion/src/pages/historial_page.dart';
import 'package:appparticipacion/src/pages/home_page.dart';
import 'package:appparticipacion/src/pages/noticias_detalles.dart';
import 'package:appparticipacion/src/pages/noticias_page.dart';
import 'package:appparticipacion/src/pages/prueba.dart';
import 'package:appparticipacion/src/pages/puntoInteres_detalle.dart';
import 'package:appparticipacion/src/pages/puntoInteres_page.dart';
import 'package:appparticipacion/src/pages/tipo_incidencia_page.dart';
import 'package:appparticipacion/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:appparticipacion/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
 
void main() async {
   SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
   final prefs = new PreferenciasUsuario();
   await prefs.initPrefs();

  print("pref token : "+prefs.idToken);

  if(prefs.idToken == ""){
   generateToken();
  }

  runApp(MyApp());

}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    
  // if(prefs.token == ""){
  // print("Entro aqui");
  // }

    return Provider(
        child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Participación Ciudadana',
        initialRoute: 'home',
        routes: {
          'home'                : (BuildContext context) => HomePage(),
          'abrirticket'         : (BuildContext context) => AbrirTicketPage(),
          'noticias'            : (BuildContext context) => NoticiasPage(),
          'noticiasDetalle'     : (BuildContext context) => NoticiasDetalles(),
          'historial'           : (BuildContext context) => HistorialPage(),
          'puntoInteresDetalle' : (BuildContext context) => PuntosInteresDetallePage(),
          'detalleTicket'       : (BuildContext context) => DetalleTicketPage(),
          'tipoincidencia'      : (BuildContext context) => TipoIncidenciaPage(),
          'puntoInteres'        : (BuildContext context) => PuntoInteresPage(),
          'ayudaPage'           : (BuildContext context) => AyudaPage(),
          'prueba'              : (BuildContext context) => Prueba(),
        },
        theme: ThemeData(
          primaryColor: Color.fromRGBO(162, 0, 125, 1.0)
        ),
      ),
    );
  }
}