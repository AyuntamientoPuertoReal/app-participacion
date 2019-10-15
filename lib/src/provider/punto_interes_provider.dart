import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:appparticipacion/src/models/puntos_interes_model.dart';
export 'package:appparticipacion/src/models/puntos_interes_model.dart';


class PuntoInteresProvider {
  final String _url = 'https://flutter-varios-8bb9d.firebaseio.com';

  Future<List<PuntoInteresModel>> cargarPuntoInteres() async {
    final url = '$_url/puntosInteres.json';
    final response = await http.get(url);

    final Map<String, dynamic> decodeData = json.decode(response.body);
    final List<PuntoInteresModel> puntosInteres = new List();
    
    if(decodeData == null) return [];

    if(decodeData['error'] != null) return [];

    decodeData.forEach((id, prod){
      final prodTemp = PuntoInteresModel.fromJson(prod);
      prodTemp.id = id;

      puntosInteres.add(prodTemp);
    });

    return puntosInteres;
  }


}