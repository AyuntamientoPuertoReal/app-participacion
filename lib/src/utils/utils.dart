import 'package:appparticipacion/src/bloc/phone_identifier_bloc.dart';
import 'package:appparticipacion/src/models/phone_identifier_model.dart';
import 'package:appparticipacion/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:appparticipacion/src/provider/phone_identifier_provider.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:latlong/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

 String decrypted;
 String encryptedString;
 //PhoneIdentifierBloc _phoneIdentifier;
 final prefs = new PreferenciasUsuario();
 PhoneIdentifierBloc phoneIdentifierBloc;
 PhoneIdentifierModel phoneModel = new PhoneIdentifierModel();
 PhoneIdentifierProvider phoneIdentifierProvider = new PhoneIdentifierProvider();


 String url = 'http://192.168.0.102:3000/api/v1/';
 String tokenApicasso = "829be5880ce84c76980cccc93a508b29";
 


void generateToken() async {

 //phoneIdentifierBloc = Provider.phoneIdentifierBloc(context);
   // await prefs.initPrefs();


  String devideId = await FlutterUdid.udid;

  //final key = Key.fromUtf8('qNjp7yM;JqGtC+r~+E.L<36{YkX*7:Lz');
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
  // id = await _comprobarTokenBd(encryptedString);
   prefs.idToken = identificador;
  }
  
   // print(phoneModel.toJson());
  
   // phoneIdentifierProvider.crearPhoneIdentifier(phoneModel);
  
  
  
   
  
  
    // decrypted = encrypter.decrypt(encrypted, iv: iv);
    
  //  print("encryptedToken "+encryptedString);
  
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
    // 36.529358, -6.186970 coordenadas puerto real
    final coordenadas = valor.split(',');
    final lat = double.parse(coordenadas[0]);
    final long = double.parse(coordenadas[1]);
    
    return LatLng(lat, long);
  }

  openMap(String valor) async {
    final coordenadas = valor.split(',');
    final lat = double.parse(coordenadas[0]);
    final long = double.parse(coordenadas[1]);
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$lat,$long';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }

  }

    String obtenerFechaCreacionTicket(){
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day, now.hour, now.minute, now.second);
    
    return date.toString();
  }
