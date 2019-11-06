import 'dart:convert';

NoticiaModel noticiaModelFromJson(String str) => NoticiaModel.fromJson(json.decode(str));

String noticiaModelToJson(NoticiaModel data) => json.encode(data.toJson());

class NoticiaModel {
    String id;
    String title;
    String description;
    String body;
    String date;
    String imageUrl;

    NoticiaModel({
        this.id,
        this.title = "",
        this.description = "",
        this.body = "",
        this.date = "",
        this.imageUrl= "",
    });

    factory NoticiaModel.fromJson(Map<String, dynamic> json) => NoticiaModel(
        id         : json["id"],
        title      : json["title"],
        description: json["description"],
        body       : json["body"],
        date       : json["Date"],
        imageUrl   : json["imageUrl"],
    );

    Map<String, dynamic> toJson() => {
     //   "id"          : id,
        "title"       : title,
        "description" : description,
        "body"        : body,
        "date"        : date,
        "imageUrl"    : imageUrl,
    };
}
