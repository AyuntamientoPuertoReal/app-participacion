import 'package:appparticipacion/src/widgets/menu_lateral.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  @override
static final String routeName = 'home';
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuLateralWidget(),
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Stack(
        children:<Widget>[
          _fondoApp(),
          Column(
            children: <Widget>[
              SizedBox(height: 20,),
              Image(
                image: AssetImage('assets/img/logo_header.png'),
                fit: BoxFit.cover,
                height: 130,
              ),
              Expanded(child: Container(),),
              Table(
                children: [
                  TableRow(
                    children: [
                      _crearBotonRedondeado(context,Colors.blue, Icons.camera_alt, 'Crear Incidencia',"abrirticket"),
                      _crearBotonRedondeado(context,Color.fromRGBO(152, 62, 151, 1.0), Icons.note, 'Noticias',"noticias"),
                    ]
                  ),
                  TableRow(
                    children: [
                      _crearBotonRedondeado(context,Colors.green, Icons.keyboard, 'Historial',"historial"),
                      _crearBotonRedondeado(context,Colors.redAccent, Icons.contact_mail, 'Ver decide',"https://decide.puertoreal.es/")
                    ]
                  )
                ],
              ),
              FlatButton(
                child: Text('Ir a Decide Puerto Real >',style: TextStyle(color: Colors.white),),
                onPressed: (){},
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
          image: AssetImage('assets/img/auth_bg.jpg'),
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


  Widget _crearBotonRedondeado(BuildContext context, Color color, IconData icono, String texto, String page){    
    return Container(
          height: 140.0,
          //width: 10.0,
          margin: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.6),
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
                CircleAvatar(
                  backgroundColor: color,
                  radius:35.0,
                  child: Icon(icono, color: Colors.white, size:30.0),
                ),
                //SizedBox(height: 2.0),
                Text(texto, style: TextStyle(color: color),)
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