import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:appparticipacion/src/bloc/phone_identifier_bloc.dart';
import 'package:appparticipacion/src/models/phone_identifier_model.dart';
import 'package:appparticipacion/src/shared_preferences/user_preferences.dart';
import 'package:appparticipacion/src/provider/phone_identifier_provider.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:url_launcher/url_launcher.dart';

//Hay que crear archivo secrets.dart en la carpeta utils para configurar los accesos
import 'package:appparticipacion/src/utils/secrets.dart' as sc;

  String decrypted;
  String encryptedString;

  final prefs = new UserPreferences();
  PhoneIdentifierBloc phoneIdentifierBloc;
  PhoneIdentifierModel phoneModel = new PhoneIdentifierModel();
  PhoneIdentifierProvider phoneIdentifierProvider = new PhoneIdentifierProvider();


  String url = sc.url;
  String tokenApicasso = sc.tokenApicasso;
  String urlImage = sc.urlImage;
  String urlServer = sc.urlServer;
  int incidenceId;

  void generateToken() async {

    String devideId = await FlutterUdid.udid;
    final key = Key.fromUtf8('k2w9hqA6X4vXBgc8');
    final iv = IV.fromLength(16);

    final encriptedPhoneId = phoneIdentifierEncryption(devideId, key, iv);

    encryptedString = encriptedPhoneId;

    int id = await _comprobarTokenBd(encryptedString);

    if(id != null){
      prefs.idToken = id.toString();
    } else{
    phoneModel.phoneIdentifier=encriptedPhoneId;
    String identificador = await phoneIdentifierProvider.crearPhoneIdentifier(phoneModel);
  
    prefs.idToken = identificador;
    }
  }
  
  Future<int> _comprobarTokenBd(String tokenEncriptado) async {
    int id = await phoneIdentifierProvider.cargarPhoneIdentifier();
    return id;
  }

  String phoneIdentifierEncryption(String deviceId,Key key, IV iv ){
    final encrypter = Encrypter(AES(key));
    final encrypted = encrypter.encrypt(deviceId, iv: iv);

    return encrypted.base64.toString();
  }



  openMap(String latitud, String longitud) async {
    final lat  = latitud;
    final long = longitud;
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$lat,$long';

    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'No se pudo abrir el mapa.';
    }
  }

  String obtenerFechaCreacionTicket(){
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day, now.hour, now.minute, now.second);
    
    return date.toString();
  }

  Future<bool> checkServerConnection() async {
    bool status;
    try {
      //Conexión a Servidor
      final response = await http.get(urlServer);
      // Comprueba si el servidor está up
      if (response.statusCode == 200) {
        // Devuelve true si está up el servidor y envía el status 200, que en http significa OK
        status=true;
      }
    } on SocketException catch (_) {
      // Devuelve false porque ha recibido algún error, por lo que no está funcionando el server
      status=false;
    }
    return status;
    
  }

  Future<bool> checkInternetConnection() async {
    bool status;
    try {
      //Conexión a Internet
      List<InternetAddress> result = await InternetAddress.lookup("www.google.es");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        //Conecta a Internet
         status=true;
      }
    } on SocketException catch (_) {
      //No conecta a Internet
       status=false;
    }
    return status;
  }

Future<bool> checkServerConnectionPrueba2() async {
    bool status;
    try {
      //Conexión a Servidor
      final response = await http.get(urlServer);
      // Comprueba si el servidor está up
      if (response.statusCode == 200) {
        // Devuelve true si está up el servidor y envía el status 200, que en http significa OK
        status=true;
      }
    } on SocketException catch (_) {
      // Devuelve false porque ha recibido algún error, por lo que no está funcionando el server
      status=false;
    }
    return status;
    
  }