import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:appparticipacion/src/models/incidence_types_model.dart';
export 'package:appparticipacion/src/models/incidence_types_model.dart';
import 'package:appparticipacion/src/utils/utils.dart' as utils;

class IncidenceTypesProvider {
  final String _url = utils.url+"incidence_types?sort=order";

  Future<List<IncidenceTypesModel>> loadIncidenceTypes() async {

    final url = _url;
    final token = utils.tokenApicasso;
    Map<String, String> headers = {HttpHeaders.contentTypeHeader: "application/json", HttpHeaders.authorizationHeader: "Bearer $token"};
    final response = await http.get(url, headers: headers);
    final Map<String, dynamic> decodeData = json.decode(response.body);
    final List<IncidenceTypesModel> tiposIncidencias = new List();
    
    if(decodeData == null) return [];

    if(decodeData['error'] != null) return [];

    if(decodeData['total']>0){

      decodeData['entries'].forEach((i){
      
      final prodTemp = IncidenceTypesModel.fromJson(i);
        tiposIncidencias.add(prodTemp);
      });
    }

    return tiposIncidencias;
  }
}