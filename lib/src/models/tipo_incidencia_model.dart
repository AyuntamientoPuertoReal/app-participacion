import 'dart:convert';

TipoIncidenciaModel tipoIncidenciaModelFromJson(String str) => TipoIncidenciaModel.fromJson(json.decode(str));

String tipoIncidenciaModelToJson(TipoIncidenciaModel data) => json.encode(data.toJson());

class TipoIncidenciaModel {
    String id;
    String tipo;

    TipoIncidenciaModel({
        this.id,
        this.tipo='',
    });

    factory TipoIncidenciaModel.fromJson(Map<String, dynamic> json) => TipoIncidenciaModel(
        id: json["id"],
        tipo: json["tipo"],
    );

    Map<String, dynamic> toJson() => {
        // "id": id,
        "tipo": tipo,
    };
}
