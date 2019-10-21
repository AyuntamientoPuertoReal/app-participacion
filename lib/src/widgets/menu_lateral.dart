import 'package:flutter/material.dart';
import 'package:appparticipacion/src/pages/home_page.dart';
import 'package:flutter/services.dart';

class MenuLateralWidget extends StatelessWidget {
  //final fondo = Color.fromRGBO(162, 0, 125, 1.0);
  
  @override
  Widget build(BuildContext context) {
    final fondo = Theme.of(context).primaryColor;
    return Drawer(
     child: ListView(
       padding: EdgeInsets.zero,
       children: <Widget>[
         DrawerHeader(
            child: Container(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/fondo_menu_lateral3.jpg'),
                fit: BoxFit.cover
              )
            ),
         ),
         ListTile(
           leading: Icon(Icons.home, color: fondo),
           title: Text('Inicio'),
           onTap: (){
             Navigator.pushNamed(context, HomePage.routeName);
           },
         ),

         ListTile(
           leading: Icon(Icons.announcement, color: fondo),
           title: Text('Noticias'),
           onTap: (){
             Navigator.pushNamed(context, 'noticias');
           },
         ),

         ListTile(
           leading: Icon(Icons.build, color: fondo),
           title: Text('Crear Incidencia'),
           onTap: (){
             Navigator.pushNamed(context, 'abrirticket');
           },
         ),
         ListTile(
           leading: Icon(Icons.history, color: fondo),
           title: Text('Historial de Incidencias'),
           onTap: () { 
             Navigator.pushNamed(context, 'historial');
           },
         ),
         ListTile(
           leading: Icon(Icons.map, color: fondo),
           title: Text('Ver Mapa'),
           onTap: () { 
             Navigator.pushNamed(context, 'mapa');
           },
         ),
         Divider(
           height: 2.0,
           thickness: 1,
         ),
         ListTile(
           leading: Icon(Icons.exit_to_app, color: fondo),
           title: Text('Salir de la aplicación'),
           onTap: () { 
             SystemChannels.platform.invokeMethod('SystemNavigator.pop');
           },
         ),
       ],
     ),
   );
  }
}