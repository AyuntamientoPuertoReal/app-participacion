import 'dart:convert';

TipoIncidenciaModel tipoIncidenciaModelFromJson(String str) => TipoIncidenciaModel.fromJson(json.decode(str));

String tipoIncidenciaModelToJson(TipoIncidenciaModel data) => json.encode(data.toJson());

class TipoIncidenciaModel {
    int id;
    String name;
    String code;
    int order;

    TipoIncidenciaModel({
        this.id,
        this.name='',
        this.code='',
        this.order
    });

    factory TipoIncidenciaModel.fromJson(Map<String, dynamic> json) => TipoIncidenciaModel(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        order: json["order"]
    );

    Map<String, dynamic> toJson() => {
        // "id": id,
        "name": name,
        "code": code,
        "order": order
    };
}
