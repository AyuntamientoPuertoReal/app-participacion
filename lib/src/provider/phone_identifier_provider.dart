import 'dart:convert';
import 'dart:io';
//import 'package:appparticipacion/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;
import 'package:appparticipacion/src/utils/utils.dart' as utils;
import 'package:appparticipacion/src/models/phone_identifier_model.dart';
export 'package:appparticipacion/src/models/phone_identifier_model.dart';


class PhoneIdentifierProvider {

  final String phoneIdentifier = utils.encryptedString;

  final url = utils.url+"phone_identifiers";

  Future<String> crearPhoneIdentifier(PhoneIdentifierModel phoneIdentifier)async{


    final token = utils.tokenApicasso;

    Map<String, String> headers = {HttpHeaders.contentTypeHeader: "application/json", HttpHeaders.authorizationHeader: "Bearer $token"};

    final response = await http.post(url,  body: phoneIdentifierModelToJson(phoneIdentifier), headers: headers);

    final decodeData = json.decode(response.body);

    String idmovil = decodeData["id"].toString();

    return idmovil;

  }


  Future<int> cargarPhoneIdentifier() async {

   // $url?q[phone_identifier_eq]=$phone_identifier&select=id

    final urlToken = '$url?q[phone_identifier_eq]=$phoneIdentifier&select=id';


    final authorizationToken = utils.tokenApicasso;

    Map<String, String> headers = {HttpHeaders.contentTypeHeader: "application/json", HttpHeaders.authorizationHeader: "Bearer $authorizationToken"};

    final response = await http.get(urlToken, headers: headers); 

    print(response);

    final Map<String, dynamic> decodeData = json.decode(response.body);

    if(decodeData == null) return null;

    if(decodeData['error'] != null) return null;
      
      if(decodeData['total']>0){
        int phone = PhoneIdentifierModel.fromJson(decodeData['entries'][0]).id;
        print("ID movil - "+ phone.toString());
        print(urlToken);
        return phone;
      } else{
        return null;
      }


  }

}