import 'dart:convert';

TicketModel ticketModelFromJson(String str) => TicketModel.fromJson(json.decode(str));

String ticketModelToJson(TicketModel data) => json.encode(data.toJson());

class TicketModel {
    String id;
    String descripcion;
    String coordenadas;
    String estado;
    String fotoUrl;
    String token;
    String fechaCreacion;
    String tipoIncidencia;

    TicketModel({
        this.id,
        this.descripcion        = "",
        this.coordenadas        = "",
        this.estado             = "",
        this.fotoUrl,
        this.token              = "",
        this.fechaCreacion      = "",
        this.tipoIncidencia     = "",
    });

    factory TicketModel.fromJson(Map<String, dynamic> json) => TicketModel(
        id               : json["id"],
        descripcion      : json["descripcion"],
        coordenadas      : json["coordenadas"],
        estado           : json["estado"],
        fotoUrl          : json["fotoUrl"],
        fechaCreacion    : json["fechaCreacion"],
        token            : json["token"],
        tipoIncidencia   : json["tipoIncidencia"],
    );

    Map<String, dynamic> toJson() => {
       // "id"        : id,
        "descripcion"     : descripcion,
        "coordenadas"     : coordenadas,
        "estado"          : estado,
        "fotoUrl"         : fotoUrl,
        "fechaCreacion"   : fechaCreacion,
        "token"           : token,
        "tipoIncidencia"  : tipoIncidencia,
    };

}
