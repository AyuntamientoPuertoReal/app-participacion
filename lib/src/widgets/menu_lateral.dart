import 'package:flutter/material.dart';
import 'package:appparticipacion/src/pages/home_page.dart';
import 'package:flutter/services.dart';

class MenuLateralWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
     child: ListView(
       padding: EdgeInsets.zero,
       children: <Widget>[
         DrawerHeader(
            child: Container(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/menu-img.jpg'),
                fit: BoxFit.cover
              )
            ),
         ),
         ListTile(
           leading: Icon(Icons.pages, color: Colors.blue,),
           title: Text('Inicio'),
           onTap: (){
             Navigator.pushNamed(context, HomePage.routeName);
           },
         ),

         ListTile(
           leading: Icon(Icons.party_mode, color: Colors.blue,),
           title: Text('Noticias'),
           onTap: (){
             Navigator.pushNamed(context, 'noticias');
           },
         ),

         ListTile(
           leading: Icon(Icons.people, color: Colors.blue,),
           title: Text('Abrir Ticket'),
           onTap: (){
             Navigator.pushNamed(context, 'abrirticket');
           },
         ),
         ListTile(
           leading: Icon(Icons.history, color: Colors.blue,),
           title: Text('Historial de tickets'),
           onTap: () { 
             Navigator.pushNamed(context, 'historial');
           },
         ),
         ListTile(
           leading: Icon(Icons.map, color: Colors.blue,),
           title: Text('Ver Mapa'),
           onTap: () { 
             Navigator.pushNamed(context, 'mapa');
           },
         ),
         ListTile(
           leading: Icon(Icons.exit_to_app, color: Colors.blue,),
           title: Text('Salir de la aplicacion'),
           onTap: () { 
             SystemChannels.platform.invokeMethod('SystemNavigator.pop');
           },
         ),
       ],
     ),
   );
  }
}