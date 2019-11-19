import 'package:appparticipacion/src/widgets/menu_lateral.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class HomePage extends StatelessWidget {
  
  static final String routeName = 'home';
  final colorSecundario = Color.fromRGBO(183, 133, 0, 1);

  @override
  Widget build(BuildContext context) {
  final fondoApp = Color.fromRGBO(162, 0, 125, 0.75);

  IconData icono = Icons.star;

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
                image: AssetImage('assets/img/APP-logo_header2.png'),
                fit: BoxFit.contain,
                //height: 130,
              ),
              Expanded(child: Container(),),
              Table(
                children: [
                  TableRow(
                    children: [
                      _crearBotonRedondeado(context,Colors.white, Icons.camera_alt, 'ENVIAR INCIDENCIA',"tipoincidencia", fondoApp, 1,Colors.white),
                      _crearBotonRedondeado(context,Colors.white, Icons.list, 'MIS INCIDENCIAS',"historial", fondoApp, 1,Colors.grey[300]),
                    ] //rgb(92, 0, 122)
                  ),
                  TableRow(
                    children: [
                      _crearBotonRedondeado(context,Colors.white, Icons.info_outline, 'NOTICIAS',"noticias", fondoApp, 1,Colors.grey[300]),
                      _crearBotonRedondeado(context,Colors.white, Icons.map, 'PUNTOS DE INTERÉS',"puntoInteres", fondoApp, 1,Colors.grey[350])
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


  Widget _crearBotonRedondeado(BuildContext context, Color color, IconData icono, String texto, String page, Color fondo,double border,  Color fondoIcono){ 

    return InkWell(
      
          onTap: (){
            Navigator.pushNamed(context, page);
          },
          child: Stack(
          alignment: AlignmentDirectional.center,
            children:<Widget>[ Container(
              height: 100.0,
              width: double.infinity,
              margin: EdgeInsets.all(6.0),
              alignment: AlignmentDirectional.topStart,
              decoration: BoxDecoration(
                color: fondo,
                // color: Color.fromRGBO(62, 66, 107, 0.7),
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(width: border, color: Color.fromRGBO(92, 0, 122, 1.0))
              ),
              //child:widget_favorito, 
                
              
            ),
            
            Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                   // widget_favorito,
                    SizedBox(height: 5),
                    Icon(icono, color: fondoIcono, size:40.0),
                    Text(texto, style: TextStyle(color: color, fontSize: 16),textAlign: TextAlign.center,),
                    SizedBox(height: 3.0,),
                  ],
                ),
            ],
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

Widget _crearCirculo(BuildContext context, IconData icono ){
  return Container(
        width: 10,
        height: 10,
        decoration: new BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle
        ),
        child: Center(child: Icon(icono)),
    );
}

  

}