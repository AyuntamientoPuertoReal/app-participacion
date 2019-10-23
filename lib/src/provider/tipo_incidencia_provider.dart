import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:appparticipacion/src/models/tipo_incidencia_model.dart';
export 'package:appparticipacion/src/models/tipo_incidencia_model.dart';

class TipoIncidenciaProvider {
  final String _url = 'https://flutter-varios-8bb9d.firebaseio.com';

  Future<List<TipoIncidenciaModel>> cargarTipoIncidencia() async {
    final url = '$_url/tipoIncidencia.json';
    final response = await http.get(url);

    final Map<String, dynamic> decodeData = json.decode(response.body);
    final List<TipoIncidenciaModel> tiposIncidencias = new List();
    
    if(decodeData == null) return [];

    if(decodeData['error'] != null) return [];

    decodeData.forEach((id, prod){
      final prodTemp = TipoIncidenciaModel.fromJson(prod);
      prodTemp.id = id;

      tiposIncidencias.add(prodTemp);
    });

    return tiposIncidencias;
  }
}