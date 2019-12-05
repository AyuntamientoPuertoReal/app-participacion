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
import 'package:appparticipacion/src/pages/no_inicio_page.dart';
import 'package:appparticipacion/src/shared_preferences/user_preferences.dart';
import 'package:appparticipacion/src/utils/utils.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
 
String rutaInicial='home';

void main() async {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final prefs = new UserPreferences();
  await prefs.initPrefs();

  
  Connectivity connectivity;
  connectivity = new Connectivity();
  ConnectivityResult result = await connectivity.checkConnectivity();

  if(prefs.idToken == "" && result == ConnectivityResult.wifi || result == ConnectivityResult.mobile){
    bool status= await checkServerConnection();
    if(status){
      generateToken();
    } else{
      rutaInicial='noInicio';
    }
  }else if(prefs.idToken == ""){
    rutaInicial='noInicio';
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
        initialRoute: rutaInicial,
        routes: {
          'home'                     : (BuildContext context) => HomePage(),
          'createIncidence'          : (BuildContext context) => CreateIncidencePage(),
          'news'                     : (BuildContext context) => NewsPage(),
          'newsDetails'              : (BuildContext context) => NewDetails(),
          'incidenceHistorical'       : (BuildContext context) => IncidencesHistoricalPage(),
          'interestPointsDetails'     : (BuildContext context) => InterestPointDetailsPage(),
          'incidenceDetails'         : (BuildContext context) => IncidendeDetailsPage(),
          'incidenceType'           : (BuildContext context) => IncidenceTypesPage(),
          'interestPoints'           : (BuildContext context) => InterestPointsPage(),
          'help'                     : (BuildContext context) => HelpPage(),
          'noInicio'                 : (BuildContext context) => NoInicioPage(),
        },
        theme: ThemeData(
          primaryColor: Color.fromRGBO(162, 0, 125, 1.0)
        ),
      ),
    );
  }
}