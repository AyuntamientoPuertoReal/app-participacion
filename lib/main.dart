import 'package:appparticipacion/src/bloc/provider.dart';
import 'package:appparticipacion/src/pages/abrir_ticket_page.dart';
import 'package:appparticipacion/src/pages/historial_page.dart';
import 'package:appparticipacion/src/pages/home_page.dart';
import 'package:appparticipacion/src/pages/noticias_detalles.dart';
import 'package:appparticipacion/src/pages/noticias_page.dart';
import 'package:appparticipacion/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
 
void main() async {
   SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
   generateToken();
  runApp(MyApp());

}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return Provider(
        child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Participación Ciudadana',
        initialRoute: HomePage.routeName,
        routes: {
          'home'               : (BuildContext context) => HomePage(),
          'abrirticket'        : (BuildContext context) => AbrirTicketPage(),
          'noticias'           : (BuildContext context) => NoticiasPage(),
          'noticiasDetalle'    : (BuildContext context) => NoticiasDetalles(),
          'historial'          : (BuildContext context) => HistorialPage(),
        },
        theme: ThemeData(
          primaryColor: Color.fromRGBO(152, 62, 151, 1.0)
        ),
      ),
    );
  }
}