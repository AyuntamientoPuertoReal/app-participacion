import 'dart:convert';

PuntoInteresModel puntoInteresModelFromJson(String str) => PuntoInteresModel.fromJson(json.decode(str));

String puntoInteresModelToJson(PuntoInteresModel data) => json.encode(data.toJson());

class PuntoInteresModel {
    int id;
    String name;
    String description;
    String imageUrl;
    String latitude;
    String longitude;

    PuntoInteresModel({
        this.id,
        this.name='',
        this.description='',
        this.imageUrl='',
        this.latitude='',
        this.longitude='',
    });

    factory PuntoInteresModel.fromJson(Map<String, dynamic> json) => PuntoInteresModel(
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
