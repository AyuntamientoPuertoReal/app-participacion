import 'package:encrypt/encrypt.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:latlong/latlong.dart';

 String decrypted;


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

}

 LatLng getCoordenadas(String valor){
    // 36.529358, -6.186970 coordenadas puerto real
    final coordenadas = valor.split(',');
    final lat = double.parse(coordenadas[0]);
    final long = double.parse(coordenadas[1]);
    
    return LatLng(lat, long);
  }