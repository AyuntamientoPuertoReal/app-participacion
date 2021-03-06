import 'dart:convert';

PhoneIdentifierModel phoneIdentifierModelFromJson(String str) => PhoneIdentifierModel.fromJson(json.decode(str));

String phoneIdentifierModelToJson(PhoneIdentifierModel data) => json.encode(data.toJson());

class PhoneIdentifierModel {
    int id;
    String phoneIdentifier;
    String notificationToken;

    PhoneIdentifierModel({
        this.id,
        this.phoneIdentifier = '',
        this.notificationToken = '',
    });

    factory PhoneIdentifierModel.fromJson(Map<String, dynamic> json) => PhoneIdentifierModel(
        id: json["id"],
        phoneIdentifier: json["phone_identifier"],
    );

    Map<String, dynamic> toJson() =>{ "phone_identifier": {
        "phone_identifier": phoneIdentifier,
        "fcm_token"       : notificationToken
      }
    };
}
