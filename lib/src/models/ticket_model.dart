import 'dart:convert';

TicketModel ticketModelFromJson(String str) => TicketModel.fromJson(json.decode(str));

String ticketModelToJson(TicketModel data) => json.encode(data.toJson());

class TicketModel {
    String id;
    String descripcion;
    String coordenadas;
    String estado;
    String latitud;
    String longitud;
    String fotoUrl;
    String token;
    String fechaCreacion;
    String tipoIncidencia;

    TicketModel({
        this.id,
        this.descripcion        = "",
        this.coordenadas        = "",
        this.latitud            = "",
        this.longitud           = "",
        this.estado             = "",
        this.fotoUrl,
        this.token              = "",
        this.fechaCreacion      = "",
        this.tipoIncidencia     = "",
    });

    factory TicketModel.fromJson(Map<String, dynamic> json) => TicketModel(
        id               : json["id"],
        descripcion      : json["description"],
        coordenadas      : json["coordenadas"],
        latitud          : json["latitude"],
        longitud         : json["longitude"],
        estado           : json["estado"],
        fotoUrl          : json["image_url"],
        fechaCreacion    : json["fechaCreacion"],
        token            : json["token_id"],
        tipoIncidencia   : json["incidence_type_id"],
    );

    Map<String, dynamic> toJson() => {
      "incidence" : {
        //"id"              : id,
        "description"        : descripcion,
        //"coordenadas"        : coordenadas,
        "latitude"           : latitud,
        "longitude"          : longitud,
        //"estado"             : estado,
        "image_url"          : fotoUrl,
        //"fechaCreacion"      : fechaCreacion,
        "token_id"           : token,
        "incidence_type_id"  : tipoIncidencia,
      }
    };

}
