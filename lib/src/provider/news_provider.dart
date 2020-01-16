import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:appparticipacion/src/models/news_model.dart';
import 'package:appparticipacion/src/utils/utils.dart' as utils;

class NewsProvider{

  final String _url = utils.url+"news?q[published_eq]=true&sort=-updated_at";
 
  Future<List<NewsModel>> loadNews() async {

    final url = _url;
    final authorizationToken = utils.tokenApicasso;

    Map<String, String> headers = {HttpHeaders.contentTypeHeader: "application/json", HttpHeaders.authorizationHeader: "Bearer $authorizationToken"};

    final response = await http.get(url, headers: headers); 

    final Map<String, dynamic> decodeData = json.decode(response.body);
    final List<NewsModel> noticias = new List();

    if(decodeData == null) return [];

    if(decodeData['error'] != null) return [];

    decodeData['entries'].forEach((i){

      final prodTemp = NewsModel.fromJson(i);
     
      noticias.add(prodTemp);

    });

    return noticias;

  }

}