import 'dart:convert';
import 'dart:io';
import 'package:appparticipacion/src/models/incidence_model.dart';
import 'package:appparticipacion/src/shared_preferences/user_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:appparticipacion/src/utils/utils.dart' as utils;
import 'package:path/path.dart';
import 'package:dio/dio.dart';



class IncidenceProvider {
  final prefs = new UserPreferences();
  
  final String _url = utils.url+"incidences";

  Future<bool> createIncidence(IncidenceModel incidence) async{

    final url = _url+"/send";

    final token = utils.tokenApicasso;

    Map<String, String> headers = {HttpHeaders.contentTypeHeader: "application/json", HttpHeaders.authorizationHeader: "Bearer $token"};

    Dio dio = new Dio();
    String nombre = basename(incidence.pictureFile.path);

    try{

      FormData formData = new FormData.fromMap({
        "description"         : incidence.descripcion,
        "latitude"            : incidence.latitud,
        "longitude"           : incidence.longitud,
        "picture"             : await MultipartFile.fromFile(incidence.pictureFile.path, filename: nombre),
        "phone_identifier_id" : incidence.phoneIdentifierId,
        "incidence_type_id"   : incidence.tipoIncidencia,
      });

      Response response = await dio.post(url, data: formData, options: Options(headers: headers));

      if(response.statusCode == 200){
        return true;
      }else{
        return false;
      }

    } catch(e){
      return false;
    }
  }

  Future<List<IncidenceModel>> cargarTicketsCiudadanos() async {

    String prefToken = prefs.idToken; 
    final String _urlHistorical = utils.url+"incidences_historical/$prefToken";
    final url = _urlHistorical;
    final authorizationToken = utils.tokenApicasso;
    Map<String, String> headers = {HttpHeaders.contentTypeHeader: "application/json", HttpHeaders.authorizationHeader: "Bearer $authorizationToken"};
    final response = await http.get(url, headers: headers); 
    final Map<String, dynamic> decodeData = json.decode(response.body);
    final List<IncidenceModel> tickets = new List();

    if(decodeData == null) return [];

    if(decodeData['error'] != null) return [];
    
    decodeData['entries'].forEach((i){
      final prodTemp = IncidenceModel.fromJson(i);
      tickets.add(prodTemp);
    });

    return tickets;
  }
}