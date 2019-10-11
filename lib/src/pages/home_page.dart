import 'package:appparticipacion/src/widgets/menu_lateral.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class HomePage extends StatelessWidget {
  @override
static final String routeName = 'home';


final fondoOscuro = Color.fromRGBO(103, 58, 183, 0.6);
final fondoClaro = Color.fromRGBO(126, 87, 195, 0.6);


// final fondoOscuro = Color.fromRGBO(92, 0, 122, 0.6);
// final fondoClaro = Color.fromRGBO(193, 88, 220, 0.6);
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuLateralWidget(),
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
                image: AssetImage('assets/img/APP-logo_header1.png'),
                fit: BoxFit.contain,
                //height: 130,
              ),
              Expanded(child: Container(),),
              Table(
                children: [
                  TableRow(
                    children: [
                      _crearBotonRedondeado(context,Colors.white, Icons.build, 'CREAR INCIDENCIA',"abrirticket", fondoOscuro),
                      _crearBotonRedondeado(context,Colors.white, Icons.announcement, 'NOTICIA',"noticias", fondoClaro),
                    ] //rgb(92, 0, 122)
                  ),
                  TableRow(
                    children: [
                      _crearBotonRedondeado(context,Colors.white, Icons.history, 'HISTORIAL',"historial", fondoClaro),
                      _crearBotonRedondeado(context,Colors.white, Icons.map, 'PUNTOS DE INTERÉS',"mapa", fondoOscuro)
                    ]
                  )
                ],
              ),
              FlatButton(
                child: Text('Ir a Decide Puerto Real >',style: TextStyle(color: Colors.white, fontSize: 16),),
                onPressed: (){
                  print('object');
                },
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
          image: AssetImage('assets/img/login.jpg'),
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
            borderRadius: BorderRadius.circular(20.0)
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
    throw 'Could not launch $url';
  }
}

  

}