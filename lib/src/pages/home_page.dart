import 'package:appparticipacion/src/pages/incidence_types_page.dart';
import 'package:appparticipacion/src/pages/incidences_historical_page.dart';
import 'package:appparticipacion/src/pages/interest_points_page.dart';
import 'package:appparticipacion/src/pages/news_page.dart';
import 'package:appparticipacion/src/utils/sizeConfig.dart';
import 'package:appparticipacion/src/widgets/widget_drawer_menu.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  static final String routeName = 'home';
  final colorSecundario = Color.fromRGBO(183, 133, 0, 1);

  @override
  Widget build(BuildContext context) {
  SizeConfig().init(context);
  final fondoApp = Color.fromRGBO(162, 0, 125, 0.75);

    return Scaffold(
      drawer: DrawerMenu(),
      appBar: AppBar(
        title: Text(''),
      ),
      body: Stack(
        children:<Widget>[
          _fondoApp(),
          Column(
            children: <Widget>[
              SizedBox(height: 20,),
              Image(
                image: AssetImage('assets/img/APP-logo_header2.png'),
                fit: BoxFit.contain,
              ),
              Expanded(child: Container(),),
              Table(
                children: [
                  TableRow(
                    children: [
                      _crearBotonRedondeado(context,Colors.white, Icons.camera_alt, 'ENVIAR INCIDENCIA',IncidenceTypesPage.routeName, fondoApp, Colors.white),
                      _crearBotonRedondeado(context,Colors.white, Icons.list, 'MIS INCIDENCIAS',IncidencesHistoricalPage.routeName, fondoApp, Colors.grey[300]),
                    ] //rgb(92, 0, 122)
                  ),
                  TableRow(
                    children: [
                      _crearBotonRedondeado(context,Colors.white, Icons.info_outline, 'NOTICIAS',NewsPage.routeName, fondoApp, Colors.grey[300]),
                      _crearBotonRedondeado(context,Colors.white, Icons.map, 'PUNTOS DE INTERÉS',InterestPointsPage.routeName, fondoApp,Colors.grey[350])
                    ]
                  )
                ],
              ),
              SizedBox(
                height: 12,
              )
            ],
          ),
        ] 
      ),
    );
  }

  Widget _fondoApp(){
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/img/login2.jpg'),
          fit: BoxFit.cover
        )
      ),
    );
  }


  Widget _crearBotonRedondeado(BuildContext context, Color color, IconData icono, String texto, String page, Color fondo,  Color fondoIcono){ 
    return Container(
      height: SizeConfig.blockSizeVertical * 15,
      width: double.infinity,
      margin: EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: fondo,
        // color: Color.fromRGBO(62, 66, 107, 0.7),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(width: 1.0, color: Color.fromRGBO(92, 0, 122, 1.0))
      ),
      child: FlatButton(
        padding: EdgeInsets.all(2),
        onPressed: (){
            Navigator.pushNamed(context, page);
        },
        child: Container(
          alignment: AlignmentDirectional.center,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(height: 5.0,),
              Icon(icono, color: fondoIcono, size:40.0),
              Text(texto, style: TextStyle(color: color, fontSize: 16),textAlign: TextAlign.center,),
              SizedBox(height: 3.0,),
            ],
          ),
        ),
      ),
    );
  }
}