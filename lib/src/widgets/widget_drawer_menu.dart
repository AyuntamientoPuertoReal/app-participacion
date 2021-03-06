import 'package:appparticipacion/src/pages/help_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerMenu extends StatelessWidget {
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
           leading: Icon(MaterialCommunityIcons.web, color: fondo),
           title: Text('Web Ayuntamiento'),
           onTap: (){
             _launchUrl('http://www.puertoreal.es/');
           },
         ),
         ListTile(
           leading: Icon(MaterialCommunityIcons.web, color: fondo),
           title: Text('Web Participación Ciudadana'),
           onTap: (){
             _launchUrl('http://participacion.puertoreal.es/');
           },
         ),
         ListTile(
           leading: Icon(MaterialCommunityIcons.web, color: fondo),
           title: Text('Web Decide Puerto Real'),
           onTap: (){
             _launchUrl('http://decide.puertoreal.es/');
           },
         ),
         Divider(
           height: 2.0,
           thickness: 1,
         ),
         ListTile(
           leading: Icon(Icons.help, color: fondo),
           title: Text('Ayuda'),
           onTap: (){
             Navigator.pushNamed(context, HelpPage.routeName);
           },
         ),
         Divider(
           height: 2.0,
           thickness: 1,
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
}