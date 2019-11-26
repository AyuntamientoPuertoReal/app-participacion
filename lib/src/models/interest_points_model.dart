import 'dart:convert';

InterestPointsModel puntoInteresModelFromJson(String str) => InterestPointsModel.fromJson(json.decode(str));

String puntoInteresModelToJson(InterestPointsModel data) => json.encode(data.toJson());

class InterestPointsModel {
    int id;
    String name;
    String description;
    String imageUrl;
    String latitude;
    String longitude;

    InterestPointsModel({
        this.id,
        this.name='',
        this.description='',
        this.imageUrl='',
        this.latitude='',
        this.longitude='',
    });

    factory InterestPointsModel.fromJson(Map<String, dynamic> json) => InterestPointsModel(
        id          : json["id"],
        name        : json["name"],
        description : json["description"],
        imageUrl    : json["image_url"],
        latitude    : json["latitude"],
        longitude   : json["longitude"],
    );

    Map<String, dynamic> toJson() => {
        // "id": id,
        "name"          : name,
        "description"   : description,
        "image_url"     : imageUrl,
        "latitude"      : latitude,
        "longitude"     : longitude,
    };



}
