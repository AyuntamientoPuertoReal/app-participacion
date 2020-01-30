import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:appparticipacion/src/utils/utils.dart' as utils;
import 'package:appparticipacion/src/models/phone_identifier_model.dart';
import 'package:appparticipacion/src/provider/notification_provider.dart';
export 'package:appparticipacion/src/models/phone_identifier_model.dart';


class PhoneIdentifierProvider {

  final String phoneIdentifier = utils.encryptedString;
  final pushProvider = new PushNotificationProvider();
  String prefNotification = "";

  final url = utils.url+"phone_identifiers";

  Future<String> createPhoneIdentifier(PhoneIdentifierModel phoneIdentifier)async{

    final token = utils.tokenApicasso;

    Map<String, String> headers = {HttpHeaders.contentTypeHeader: "application/json", HttpHeaders.authorizationHeader: "Bearer $token"};

    phoneIdentifier.notificationToken = await pushProvider.returnNotificationToken();

    prefNotification = phoneIdentifier.notificationToken;

    final response = await http.post(url,  body: phoneIdentifierModelToJson(phoneIdentifier), headers: headers);

    final decodeData = json.decode(response.body);

    String idmovil = decodeData["id"].toString();

    return idmovil;

  }


  Future<int> loadPhoneIdentifier() async {

    final urlToken = '$url?q[phone_identifier_eq]=$phoneIdentifier&select=id';

    final authorizationToken = utils.tokenApicasso;

    Map<String, String> headers = {HttpHeaders.contentTypeHeader: "application/json", HttpHeaders.authorizationHeader: "Bearer $authorizationToken"};

    final response = await http.get(urlToken, headers: headers); 

    final Map<String, dynamic> decodeData = json.decode(response.body);

    if(decodeData == null) return null;

    if(decodeData['error'] != null) return null;
      
    if(decodeData['total']>0){
      int phone = PhoneIdentifierModel.fromJson(decodeData['entries'][0]).id;
      await updateNotificationToken(phone);
      return phone;
      
    } else{
      return null;
    }
  }

  Future<void> updateNotificationToken(int idPhone)async{
    String urlUpdate=url+"/"+idPhone.toString();
    final token = utils.tokenApicasso;

    Map<String, String> headers = {HttpHeaders.contentTypeHeader: "application/json", HttpHeaders.authorizationHeader: "Bearer $token"};

    String notificationToken = await pushProvider.returnNotificationToken();

    final body='{"phone_identifier": {"fcm_token": "$notificationToken"}}';
    await http.patch(urlUpdate,  body: body, headers: headers);
  }

}