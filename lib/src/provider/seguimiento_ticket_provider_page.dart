import 'dart:convert';
import 'dart:io';
import 'package:appparticipacion/src/models/seguimiento_ticket_model.dart';
import 'package:http/http.dart' as http;
import 'package:appparticipacion/src/utils/utils.dart' as utils;


class SeguimientoTicketProvider {

  Future<List<SeguimientoTicketModel>> cargarSeguimientoTickets() async {
    int incidenceId = utils.incidenceId;
    final String _url = utils.url+"incidence_trackings?q[incidence_id_eq]=$incidenceId";

    final authorizationToken = utils.tokenApicasso;

    Map<String, String> headers = {HttpHeaders.contentTypeHeader: "application/json", HttpHeaders.authorizationHeader: "Bearer $authorizationToken"};
    
    final response = await http.get(_url, headers: headers); 

    final Map<String, dynamic> decodeData = json.decode(response.body);
    final List<SeguimientoTicketModel> listaSeguimiento = new List();

    if(decodeData == null) return [];

    if(decodeData['error'] != null) return [];
    
    if(decodeData['total']>0){
      decodeData['entries'].forEach((i){

        final prodTemp = SeguimientoTicketModel.fromJson(i);

        listaSeguimiento.add(prodTemp);

      });
    }

    return listaSeguimiento;
    
    
    
    
    
    
    
    
    
    // final url = '$_url/seguimientoTicket.json';
    // final response = await http.get(url);

    // final Map<String, dynamic> decodeData = json.decode(response.body);
    // final List<SeguimientoTicketModel> seguimientoTicket = new List();
    
    // if(decodeData == null) return [];

    // if(decodeData['error'] != null) return [];

    // decodeData.forEach((id, prod){
    //   final prodTemp = SeguimientoTicketModel.fromJson(prod);
    //   prodTemp.id = id;

    //   seguimientoTicket.add(prodTemp);
    // });

    // return seguimientoTicket;
  }

}