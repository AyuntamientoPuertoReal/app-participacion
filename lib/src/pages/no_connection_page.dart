import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class NoConnectionPage extends StatelessWidget {

static final String routeName = 'noInicio';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dispositivo sin conexión'),
      ),
      body: Container(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Image(
                image: AssetImage("assets/img/conexion-internet.png"),
              ),
              Text('No se ha podido identificar al dispositivo en el sistema porque no se ha detectado conexión con el servidor.',style: TextStyle(fontSize: 16)),
              SizedBox(height: 20,),
              Text('Por favor, revise si tiene conexión a Internet y vuelva a iniciar la aplicación.',style: TextStyle(fontSize: 16)),
              SizedBox(height: 40,),
              RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                child: Text('Salir', style: TextStyle(color: Colors.white, fontSize: 18),),
                color: Theme.of(context).primaryColor,
                
                onPressed: (){
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
              ),
            ],
          )
        ),
      ),
    );
  }
}