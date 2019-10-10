import 'package:encrypt/encrypt.dart';
import 'package:flutter_udid/flutter_udid.dart';

 String decrypted;


void generateToken() async {

  String devideId = await FlutterUdid.udid;

  print(devideId);

  final key = Key.fromUtf8('qNjp7yM;JqGtC+r~+E.L<36{YkX*7:Lz');
  final iv = IV.fromLength(16);

  final encrypter = Encrypter(AES(key));

  final encrypted = encrypter.encrypt(devideId, iv: iv);
   decrypted = encrypter.decrypt(encrypted, iv: iv);

  print(decrypted);
  print(encrypted.base64);

}