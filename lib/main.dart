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
          HomePage.routeName                     : (BuildContext context) => HomePage(),
          CreateIncidencePage.routeName          : (BuildContext context) => CreateIncidencePage(),
          NewsPage.routeName                     : (BuildContext context) => NewsPage(),
          NewDetails.routeName                   : (BuildContext context) => NewDetails(),
          IncidencesHistoricalPage.routeName     : (BuildContext context) => IncidencesHistoricalPage(),
          InterestPointDetailsPage.routeName     : (BuildContext context) => InterestPointDetailsPage(),
          IncidendeDetailsPage.routeName         : (BuildContext context) => IncidendeDetailsPage(),
          IncidenceTypesPage.routeName           : (BuildContext context) => IncidenceTypesPage(),
          InterestPointsPage.routeName           : (BuildContext context) => InterestPointsPage(),
          HelpPage.routeName                     : (BuildContext context) => HelpPage(),
          NoInicioPage.routeName                 : (BuildContext context) => NoInicioPage(),
        },
        theme: ThemeData(
          primaryColor: Color.fromRGBO(162, 0, 125, 1.0)
        ),
      ),
    );
  }
}