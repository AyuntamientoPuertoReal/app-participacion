import 'dart:convert';
import 'dart:io';
import 'package:appparticipacion/src/models/ticket_model.dart';
//import 'package:appparticipacion/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';
import 'package:appparticipacion/src/utils/utils.dart' as utils;


class TicketProvider {

 // final String _url = 'https://flutter-varios-8bb9d.firebaseio.com';
  final String _url = 'http://172.16.19.78:3000/api/v1/incidences';
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

    final token = '98869c76f2094130a80dd2fedde63128';

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

    final url = '$_url/ticketCiudadano.json?token=a60a3e79075e3442';

    final response = await http.get(url); 

    final Map<String, dynamic> decodeData = json.decode(response.body);
    final List<TicketModel> tickets = new List();

    if(decodeData == null) return [];

    if(decodeData['error'] != null) return [];

    decodeData.forEach((id, prod){

      final prodTemp = TicketModel.fromJson(prod);
      prodTemp.id = id;

    //  if(prodTemp.token == utils.encryptedString.toString()){

      print("tocken objeto: "+prodTemp.token);
      print("tocken desencriptado clase: "+utils.decrypted);
      print("tocken encryptado clase: "+utils.encryptedString.toString());

      tickets.add(prodTemp);

     // }

    });

    return tickets;

  }

}