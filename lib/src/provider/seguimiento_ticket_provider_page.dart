import 'dart:convert';
import 'package:appparticipacion/src/models/seguimiento_ticket_model.dart';
import 'package:http/http.dart' as http;
import 'package:appparticipacion/src/models/puntos_interes_model.dart';
export 'package:appparticipacion/src/models/puntos_interes_model.dart';


class SeguimientoTicketProvider {
  final String _url = 'https://flutter-varios-8bb9d.firebaseio.com';

  Future<List<SeguimientoTicketModel>> cargarSeguimientoTickets() async {
    final url = '$_url/seguimientoTicket.json';
    final response = await http.get(url);

    final Map<String, dynamic> decodeData = json.decode(response.body);
    final List<SeguimientoTicketModel> seguimientoTicket = new List();
    
    if(decodeData == null) return [];

    if(decodeData['error'] != null) return [];

    decodeData.forEach((id, prod){
      final prodTemp = SeguimientoTicketModel.fromJson(prod);
      prodTemp.id = id;

      seguimientoTicket.add(prodTemp);
    });

    return seguimientoTicket;
  }

}