import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:appparticipacion/src/models/ticket_model.dart';
import 'package:appparticipacion/src/preferencias_usuario/preferencias_usuario.dart';
//import 'package:appparticipacion/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';
import 'package:appparticipacion/src/utils/utils.dart' as utils;
import 'package:path/path.dart';
import 'package:dio/dio.dart';



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

  Future<bool> createIncidence(TicketModel incidence) async{
    final url = _url+"/send";
    final token = utils.tokenApicasso;
    Map<String, String> headers = {HttpHeaders.contentTypeHeader: "application/json", HttpHeaders.authorizationHeader: "Bearer $token"};

    // /rails/active_storage/blobs/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBGZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--625562b6d5863a24c9bc729b9a09fca4ac42e98a/73679_0.jpg


    Dio dio = new Dio();
    String nombre = basename(incidence.pictureFile.path);
    print(incidence.pictureFile.path);
    print(nombre);
    var picture=await MultipartFile.fromFile(incidence.pictureFile.path, filename: nombre);
    print(picture.filename);
    try{
      FormData formData = new FormData.fromMap({
        "description"         : incidence.descripcion,
        "latitude"            : incidence.latitud,
        "longitude"           : incidence.longitud,
        "picture"                : await MultipartFile.fromFile(incidence.pictureFile.path, filename: nombre),
        "phone_identifier_id" : incidence.phoneIdentifierId,
        "incidence_type_id"   : incidence.tipoIncidencia,
      });
      print(formData.fields[2]);
      Response response = await dio.post(url, data: formData, options: Options(headers: headers));
      print(response);
      return true;
    } catch(e){
      print(e);
      return false;
    }
  }

  Future<bool> crearTicketCiudadano(TicketModel ticket)async{



    final url = _url+"/send";

    final token = utils.tokenApicasso;


    Map<String, String> headers = {HttpHeaders.contentTypeHeader: "application/json", HttpHeaders.authorizationHeader: "Bearer $token"};

    final response = await http.post(Uri.parse(url),  body: ticketModelToJson(ticket), headers: headers);

    final decodeData = json.decode(response.body);

    print(decodeData);

    return true;

  }

  Future<String> subirImagen(File imagen) async {


    // final url = Uri.parse('https://api.cloudinary.com/v1_1/dg0aypaob/image/upload?upload_preset=e4g32rq3');
    // final mimeType = mime(imagen.path).split('/'); // imagen/jpeg

    
    // final imageUploadRequest = http.MultipartRequest(
    //   'POST',
    //   url
    // );

    // final file = await http.MultipartFile.fromPath('file', imagen.path, contentType: MediaType(mimeType[0], mimeType[1]));

    // imageUploadRequest.files.add(file);

    // final streamResponse = await imageUploadRequest.send();
    // final resp = await http.Response.fromStream(streamResponse);

    // if(resp.statusCode != 200 && resp.statusCode != 201){
    //   print('Algo salio mal...');
    //   print(resp.body);
    //   return null;
    // }

    // final responseData = json.decode(resp.body);
    // print(responseData);

    // return responseData['secure_url'];
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


  }
}