import 'dart:convert';

NewsModel noticiaModelFromJson(String str) => NewsModel.fromJson(json.decode(str));

String noticiaModelToJson(NewsModel data) => json.encode(data.toJson());

class NewsModel {
    int id;
    String title;
    String description;
    String body;
    String date;
    String imageUrl;

    NewsModel({
        this.id,
        this.title = "",
        this.description = "",
        this.body = "",
        this.date = "",
        this.imageUrl= "",
    });

    factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        id         : json["id"],
        title      : json["title"],
        description: json["description"],
        body       : json["body"],
        date       : json["created_at"],
        imageUrl   : json["image_url"],
    );

    Map<String, dynamic> toJson() => {
        "title"       : title,
        "description" : description,
        "body"        : body,
        "created_at"        : date,
        "imageUrl"    : imageUrl,
    };
}
