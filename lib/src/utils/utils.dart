import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:appparticipacion/src/bloc/phone_identifier_bloc.dart';
import 'package:appparticipacion/src/models/phone_identifier_model.dart';
import 'package:appparticipacion/src/shared_preferences/user_preferences.dart';
import 'package:appparticipacion/src/provider/phone_identifier_provider.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:latlong/latlong.dart';
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



  LatLng getCoordenadas(String valor){
    final coordenadas = valor.split(',');
    final lat = double.parse(coordenadas[0]);
    final long = double.parse(coordenadas[1]);
    
    return LatLng(lat, long);
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
      final response = await http.get('https://decide.puertoreal.es/');
      if (response.statusCode == 200) {
        print('connected to server decide');
        status=true;
      }
    } on SocketException catch (_) {
      print('not connected to decide');
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
        print('connected to Internet');
         status=true;
      }
    } on SocketException catch (_) {
      print('not connected');
       status=false;
    }
    return status;
  }
