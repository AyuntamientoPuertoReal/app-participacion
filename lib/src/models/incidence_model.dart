import 'dart:convert';

import 'dart:io';

IncidenceModel ticketModelFromJson(String str) => IncidenceModel.fromJson(json.decode(str));

String ticketModelToJson(IncidenceModel data) => json.encode(data.toJson());

class IncidenceModel {
    int id;
    String descripcion;
    String coordenadas;
    int estado;
    String latitud;
    String longitud;
    String phoneIdentifierId;
    String fechaCreacion;
    int tipoIncidencia;
    String nombreIncidencia;
    String pictureUrl;
    File pictureFile;

    IncidenceModel({
        this.id,
        this.descripcion        = "",
        this.coordenadas        = "",
        this.latitud            = "",
        this.longitud           = "",
        this.estado             ,
        this.pictureUrl,
        this.phoneIdentifierId  = "",
        this.fechaCreacion      = "",
        this.tipoIncidencia,
        this.nombreIncidencia   = "",
        this.pictureFile
    });

    factory IncidenceModel.fromJson(Map<String, dynamic> json) => IncidenceModel(
        id                : json["id"],
        descripcion       : json["description"],
        latitud           : json["latitude"],
        longitud          : json["longitude"],
        estado            : json["status"],
        pictureUrl        : json["image_url"],
        fechaCreacion     : json["created_at"],
        nombreIncidencia  : json["name"],
        
    );

    Map<String, dynamic> toJson() => {   
        "description"         : descripcion,
        "latitude"            : latitud,
        "longitude"           : longitud,
        "picture"             : pictureFile,
        "phone_identifier_id" : phoneIdentifierId,
        "incidence_type_id"   : tipoIncidencia,    
    };

}
