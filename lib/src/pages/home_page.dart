import 'package:appparticipacion/src/widgets/menu_lateral.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class HomePage extends StatelessWidget {
  
  static final String routeName = 'home';

  @override
  Widget build(BuildContext context) {
  final fondoApp = Color.fromRGBO(162, 0, 125, 0.75);


    return Scaffold(
      drawer: MenuLateralWidget(),
      appBar: AppBar(
        title: Text(''),
        actions: <Widget>[
          // FlatButton(
          //   child: Text('Ir a la Web', style: TextStyle(color: Colors.white, fontSize: 16),),
          //   onPressed: (){
          //     _launchUrl('http://participacion.puertoreal.es/');
          //   },
          // )
        ],
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
                //height: 130,
              ),
              Expanded(child: Container(),),
              Table(
                children: [
                  TableRow(
                    children: [
                      _crearBotonRedondeado(context,Colors.white, Icons.build, 'ENVIAR INCIDENCIA',"tipoincidencia", fondoApp),
                      _crearBotonRedondeado(context,Colors.white, Icons.announcement, 'NOTICIAS',"noticias", fondoApp),
                    ] //rgb(92, 0, 122)
                  ),
                  TableRow(
                    children: [
                      _crearBotonRedondeado(context,Colors.white, Icons.history, 'MIS INCIDENCIAS',"historial", fondoApp),
                      _crearBotonRedondeado(context,Colors.white, Icons.map, 'PUNTOS DE INTERÉS',"mapa", fondoApp)
                    ]
                  )
                ],
              ),
              // FlatButton(
              //   child: Text('Acceder a Decide Puerto Real',style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16),),
              //   onPressed: (){
              //     _launchUrl('https://decide.puertoreal.es/');
              //   },
              // )
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
        // gradient: LinearGradient(
        //   begin: FractionalOffset(0.0, 0.6),
        //   end: FractionalOffset(0.0, 1.0),
        //   colors: [
        //     Color.fromRGBO(52, 54, 101, 1.0),
        //     Color.fromRGBO(35, 37, 57, 1.0)
        //   ]
        // ),
      ),
    );
  }


  Widget _crearBotonRedondeado(BuildContext context, Color color, IconData icono, String texto, String page, Color fondo){    
    return Container(
          height: 100.0,
          //width: 10.0,
          margin: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: fondo,
            // color: Color.fromRGBO(62, 66, 107, 0.7),
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(width: 1.0, color: Color.fromRGBO(92, 0, 122, 1.0))
          ),
          child: FlatButton(
            onPressed: (){
              if(page.contains('http')){
                _launchUrl(page);
              }else {
                Navigator.pushNamed(context, page);
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(height: 5.0,),
                Icon(icono, color: Colors.white, size:40.0),
                // CircleAvatar(
                //   backgroundColor: color,
                //   radius:35.0,
                //   child: Icon(icono, color: Colors.white, size:30.0),
                // ),
                //SizedBox(height: 2.0),
                Text(texto, style: TextStyle(color: color, fontSize: 14),),
                SizedBox(height: 3.0,),
              ],
            ),
          ),
        );
  }

  void _launchUrl(String url) async {
    if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'No se pudo abrir $url';
  }
}

  

}