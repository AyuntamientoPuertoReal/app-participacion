import 'dart:convert';

IncidenceTypesModel tipoIncidenciaModelFromJson(String str) => IncidenceTypesModel.fromJson(json.decode(str));

String tipoIncidenciaModelToJson(IncidenceTypesModel data) => json.encode(data.toJson());

class IncidenceTypesModel {
    int id;
    String name;
    String code;
    int order;

    IncidenceTypesModel({
        this.id,
        this.name='',
        this.code='',
        this.order
    });

    factory IncidenceTypesModel.fromJson(Map<String, dynamic> json) => IncidenceTypesModel(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        order: json["order"]
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
        "order": order
    };
}
