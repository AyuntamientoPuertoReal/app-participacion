import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:appparticipacion/src/models/incidence_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


class PushNotificationProvider {

 FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
 final _mensajesStreamController = StreamController<IncidenceModel>.broadcast();
  Stream<void> get mensajes => _mensajesStreamController.stream;

  initNotifications() async {

  _firebaseMessaging.requestNotificationPermissions();


  _firebaseMessaging.configure(

    onMessage: ( info ){
      print("======== On Message ========");
      
     // _mensajesStreamController.sink.add(info['data']['usuario']);

      //   Map<String, dynamic> argumento;
      //   IncidenceModel incidencia;
      // if(Platform.isAndroid){
      //   argumento = info['data']['incidence'] ?? 'no-data';
      //   incidencia.id =  argumento['id'];
      //   incidencia.descripcion = argumento['description'];
      //   incidencia.pictureUrl = argumento['image_url'];
      //   incidencia.phoneIdentifierId = argumento['phone_identifier_id'];
      //   incidencia.latitud = argumento['latitude'];
      //   incidencia.longitud = argumento['longitude'];
      //   incidencia.tipoIncidencia = argumento['incidence_type_id'];  
      // }

      // print("incidencia"+incidencia.toString());

      _mensajesStreamController.sink; 

    },
    onLaunch: ( info ){
      print("======== On Launch ========");
     // print(info);

      // String argumento = "no-data";
      // IncidenceModel incidencia;
      // if(Platform.isAndroid){
      //   argumento = info['data']['incidence'] ?? 'no-data';
      // }
      
     // print(argumento);
    

    },
    onResume: ( info ){
      print("======== On Resume ========");
      // print("info "+info.toString());

      // String argumento;
      // //IncidenceModel incidencia;
      // if(Platform.isAndroid){
      //   print("entro en el if ante");
      //   argumento = info['data']['incidence'];
      //   //print(argumento);
      //   final datos = json.decode(argumento);
      //   print(datos['id']);
      //   print("entro en el if despues de argumento");
        
      //   IncidenceModel incidencia = IncidenceModel.fromJson(datos);

      //   print("incidencia"+incidencia.toString());
      //   _mensajesStreamController.sink.add(incidencia); 
      //   print(incidencia.tipoIncidencia.toString());
      // }

      _mensajesStreamController.sink; 
      
     // print(argumento);

      //  _mensajesStreamController.sink.add(argumento); 
              // incidencia.id = info['data']['incidence']['description'];
        // incidencia.pictureUrl = info['data']['incidence']['image_url'];
        // incidencia.phoneIdentifierId = info['data']['incidence']['phone_identifier_id'];
        // incidencia.latitud = info['data']['incidence']['latitude'];
        // incidencia.longitud = info['data']['incidence']['longitude'];
        // incidencia.tipoIncidencia = info['data']['incidence']['incidence_type_id'];     

    },

  );


}

Future<String> returnNotificationToken() async {
  String notificationToken = await _firebaseMessaging.getToken();

  return notificationToken;
}


dispose(){
  _mensajesStreamController.close();
}

}