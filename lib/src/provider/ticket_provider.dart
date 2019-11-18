import 'dart:convert';
import 'dart:io';
import 'package:appparticipacion/src/models/ticket_model.dart';
import 'package:appparticipacion/src/preferencias_usuario/preferencias_usuario.dart';
//import 'package:appparticipacion/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';
import 'package:appparticipacion/src/utils/utils.dart' as utils;



class TicketProvider {
  final prefs = new PreferenciasUsuario();
  

  
 // final String _url = 'https://flutter-varios-8bb9d.firebaseio.com';

  final String _url = utils.url+"incidences";
 
  //final _prefs = new PreferenciasUsuario();
  

//  "incidence": {
//   "description": "Silla caída",
//   "image_url": "silla.jpg",
//   "token_id": 1,
//   "latitude": "111111111",
//   "longitude": "1111111",
//   "incidence_type_id": 1


  Future<bool> crearTicketCiudadano(TicketModel ticket)async{

   // final url = "$_url/ticketCiudadano.json";
    final url = _url;

    final token = utils.tokenApicasso;

  //  Map<String, String> headers = {"Content-type": "application/json", "Http_authorization": "Bearer 98869c76f2094130a80dd2fedde63128"};


    Map<String, String> headers = {HttpHeaders.contentTypeHeader: "application/json", HttpHeaders.authorizationHeader: "Bearer $token"};

    final response = await http.post(url,  body: ticketModelToJson(ticket), headers: headers);

    final decodeData = json.decode(response.body);

    print(decodeData);

    return true;

  }

  Future<String> subirImagen(File imagen) async {

    final url = Uri.parse('https://api.cloudinary.com/v1_1/dg0aypaob/image/upload?upload_preset=e4g32rq3');
    final mimeType = mime(imagen.path).split('/'); // imagen/jpeg

    final imageUploadRequest = http.MultipartRequest(
      'POST',
      url
    );

    final file = await http.MultipartFile.fromPath('file', imagen.path, contentType: MediaType(mimeType[0], mimeType[1]));

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if(resp.statusCode != 200 && resp.statusCode != 201){
      print('Algo salio mal...');
      print(resp.body);
      return null;
    }

    final responseData = json.decode(resp.body);
    print(responseData);

    return responseData['secure_url'];


  }

  Future<List<TicketModel>> cargarTicketsCiudadanos() async {

    String prefToken = prefs.idToken; 
    final String _urlHistorical = utils.url+"incidences_historical/$prefToken";

    final url = _urlHistorical;

    final authorizationToken = utils.tokenApicasso;

    Map<String, String> headers = {HttpHeaders.contentTypeHeader: "application/json", HttpHeaders.authorizationHeader: "Bearer $authorizationToken"};
    
    final response = await http.get(url, headers: headers); 

    final Map<String, dynamic> decodeData = json.decode(response.body);
    final List<TicketModel> tickets = new List();

    if(decodeData == null) return [];

    if(decodeData['error'] != null) return [];
    
    decodeData['entries'].forEach((i){

      final prodTemp = TicketModel.fromJson(i);
      //prodTemp.id = id;

    //  if(prodTemp.token == utils.encryptedString.toString()){

      // print("tocken objeto: "+prodTemp.phoneIdentifierId);
      // print("tocken desencriptado clase: "+utils.decrypted);
      // print("tocken encryptado clase: "+utils.encryptedString.toString());

      tickets.add(prodTemp);

     // }

    });

    return tickets;
//     final url = _url;

//     print(url);

//     final authorizationToken = utils.tokenApicasso;

//     Map<String, String> headers = {HttpHeaders.contentTypeHeader: "application/json", HttpHeaders.authorizationHeader: "Bearer $authorizationToken"};
    
//     final response = await http.get(url, headers: headers); 

//     final Map<String, dynamic> decodeData = json.decode(response.body);
//     final List<PuntoInteresModel> puntosInteres = new List();
    
//     if(decodeData == null) return [];

//     if(decodeData['error'] != null) return [];

//  // print(decodeData['entries']);
    
//   if(decodeData['total']>0){
    
//    // print(decodeData.toString());
//     decodeData['entries'].forEach((i){

//       PuntoInteresModel prodTemp = PuntoInteresModel.fromJson(i);
//    //   print(prodTemp.toJson());

//       puntosInteres.add(prodTemp);
//     });
//   }

//     return puntosInteres;

  }

}