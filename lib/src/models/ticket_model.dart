import 'dart:convert';

TicketModel ticketModelFromJson(String str) => TicketModel.fromJson(json.decode(str));

String ticketModelToJson(TicketModel data) => json.encode(data.toJson());

class TicketModel {
    String id;
    String descripcion;
    String coordenadas;
    bool solucionado;
    String fotoUrl;
    String token;

    TicketModel({
        this.id,
        this.descripcion        = "",
        this.coordenadas        = "",
        this.solucionado        = false,
        this.fotoUrl,
        this.token              = "",
    });

    factory TicketModel.fromJson(Map<String, dynamic> json) => TicketModel(
        id               : json["id"],
        descripcion      : json["descripcion"],
        coordenadas      : json["coordenadas"],
        solucionado      : json["solucionado"],
        fotoUrl          : json["fotoUrl"],
        token            : json["token"],
    );

    Map<String, dynamic> toJson() => {
       // "id"        : id,
        "descripcion"     : descripcion,
        "coordenadas"     : coordenadas,
        "solucionado"     : solucionado,
        "fotoUrl"         : fotoUrl,
        "token"           : token,
    };

}
