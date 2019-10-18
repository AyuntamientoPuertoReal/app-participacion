import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:appparticipacion/src/models/noticias_model.dart';

class NoticiaProvider{

  final String _url = 'https://flutter-varios-8bb9d.firebaseio.com';

  Future<bool> crearNoticia(NoticiaModel noticia)async{
    
    final url = "$_url/noticias.json";

    final response = await http.post(url, body: noticiaModelToJson(noticia));

    final decodeData = json.decode(response.body);

    print(decodeData);

    return true;
  }

  Future<List<NoticiaModel>> cargarNoticias() async {

    final url = '$_url/noticias.json';

    final response = await http.get(url);

    final Map<String, dynamic> decodeData = json.decode(response.body);
    final List<NoticiaModel> noticias = new List();

    if(decodeData == null) return [];

    if(decodeData['error'] != null) return [];

    decodeData.forEach((id, prod){

      final prodTemp = NoticiaModel.fromJson(prod);
      prodTemp.id = id;

      noticias.add(prodTemp);

    });

    return noticias;

  }

  Future<int> borrarNoticia(String id) async{

    //final url = '$_url/noticias/$id.json';
    //final response = await http.delete(url);

    return 1;
  }

  Future<bool> editarNoticias(NoticiaModel noticia) async {

    final url = '$_url/noticia/${noticia.id}.json';

    final response = await http.put(url, body: noticiaModelToJson(noticia));

    final decodeData = json.decode(response.body);

    print(decodeData);

    return true;

  }

}