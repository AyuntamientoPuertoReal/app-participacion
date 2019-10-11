import 'dart:convert';

PuntoInteresModel puntoInteresModelFromJson(String str) => PuntoInteresModel.fromJson(json.decode(str));

String puntoInteresModelToJson(PuntoInteresModel data) => json.encode(data.toJson());

class PuntoInteresModel {
    String id;
    String name;
    String description;
    String urlImage;
    String geo;

    PuntoInteresModel({
        this.id,
        this.name='',
        this.description='',
        this.urlImage='',
        this.geo='',
    });

    factory PuntoInteresModel.fromJson(Map<String, dynamic> json) => PuntoInteresModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        urlImage: json["url_image"],
        geo: json["geo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "url_image": urlImage,
        "geo": geo,
    };
}
