import 'package:appparticipacion/src/bloc/provider.dart';
import 'package:appparticipacion/src/pages/create_incidence_page.dart';
import 'package:appparticipacion/src/pages/help_page.dart';
import 'package:appparticipacion/src/pages/incidence_details_page.dart';
import 'package:appparticipacion/src/pages/incidences_historical_page.dart';
import 'package:appparticipacion/src/pages/home_page.dart';
import 'package:appparticipacion/src/pages/new_details_page.dart';
import 'package:appparticipacion/src/pages/news_page.dart';
import 'package:appparticipacion/src/pages/interest_points_details_page.dart';
import 'package:appparticipacion/src/pages/interest_points_page.dart';
import 'package:appparticipacion/src/pages/incidence_types_page.dart';
import 'package:appparticipacion/src/shared_preferences/user_preferences.dart';
import 'package:appparticipacion/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
 
void main() async {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final prefs = new UserPreferences();
  await prefs.initPrefs();

  if(prefs.idToken == ""){
    generateToken();
  }

  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
        child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Participación Ciudadana',
        initialRoute: 'home',
        routes: {
          'home'                : (BuildContext context) => HomePage(),
          'abrirticket'         : (BuildContext context) => CreateIncidencePage(),
          'noticias'            : (BuildContext context) => NewsPage(),
          'noticiasDetalle'     : (BuildContext context) => NewDetails(),
          'historial'           : (BuildContext context) => IncidencesHistoricalPage(),
          'puntoInteresDetalle' : (BuildContext context) => InterestPointDetailsPage(),
          'detalleTicket'       : (BuildContext context) => IncidendeDetailsPage(),
          'tipoincidencia'      : (BuildContext context) => IncidenceTypesPage(),
          'puntoInteres'        : (BuildContext context) => InterestPointsPage(),
          'ayudaPage'           : (BuildContext context) => HelpPage(),
        },
        theme: ThemeData(
          primaryColor: Color.fromRGBO(162, 0, 125, 1.0)
        ),
      ),
    );
  }
}