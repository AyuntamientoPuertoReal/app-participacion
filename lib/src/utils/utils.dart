import 'package:encrypt/encrypt.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:latlong/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

 String decrypted;
 String encryptedString;


void generateToken() async {

  String devideId = await FlutterUdid.udid;

  print(devideId);

  final key = Key.fromUtf8('qNjp7yM;JqGtC+r~+E.L<36{YkX*7:Lz');
  final iv = IV.fromLength(16);

  final encrypter = Encrypter(AES(key));

  final encrypted = encrypter.encrypt(devideId, iv: iv);
   decrypted = encrypter.decrypt(encrypted, iv: iv);

  print("Decryped token: "+decrypted);
  print("Encrypted token"+encrypted.base64);
  encryptedString = encrypted.base64.toString();
  print("encryptedToken "+encryptedString);
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
