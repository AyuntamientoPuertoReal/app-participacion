import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:appparticipacion/src/models/interest_points_model.dart';
export 'package:appparticipacion/src/models/interest_points_model.dart';
import 'package:appparticipacion/src/utils/utils.dart' as utils;



class InterestPointsProvider {
  final String _url = utils.url+"interest_points";

  Future<List<InterestPointsModel>> loadInterestPoints() async {

    final url = _url;

    final authorizationToken = utils.tokenApicasso;

    Map<String, String> headers = {HttpHeaders.contentTypeHeader: "application/json", HttpHeaders.authorizationHeader: "Bearer $authorizationToken"};
    
    final response = await http.get(url, headers: headers); 

    final Map<String, dynamic> decodeData = json.decode(response.body);
    final List<InterestPointsModel> puntosInteres = new List();
    
    if(decodeData == null) return [];

    if(decodeData['error'] != null) return [];
    
    if(decodeData['total']>0){
    
    decodeData['entries'].forEach((i){

      InterestPointsModel prodTemp = InterestPointsModel.fromJson(i);

      puntosInteres.add(prodTemp);
    });
  }

    return puntosInteres;
  }


}