import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:appparticipacion/src/models/noticias_model.dart';
import 'package:appparticipacion/src/utils/utils.dart' as utils;

class NoticiaProvider{

  final String _url = utils.url+"news";
 
  Future<List<NoticiaModel>> cargarNoticias() async {

    final url = _url;
    final authorizationToken = utils.tokenApicasso;

    Map<String, String> headers = {HttpHeaders.contentTypeHeader: "application/json", HttpHeaders.authorizationHeader: "Bearer $authorizationToken"};


    final response = await http.get(url, headers: headers); 

    final Map<String, dynamic> decodeData = json.decode(response.body);
    final List<NoticiaModel> noticias = new List();

    if(decodeData == null) return [];

    if(decodeData['error'] != null) return [];

    decodeData['entries'].forEach((i){

      final prodTemp = NoticiaModel.fromJson(i);
     

      noticias.add(prodTemp);

    });

    return noticias;

  }

}