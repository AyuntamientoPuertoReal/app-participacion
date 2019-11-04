import 'dart:convert';

SeguimientoTicketModel ticketModelFromJson(String str) => SeguimientoTicketModel.fromJson(json.decode(str));

String ticketModelToJson(SeguimientoTicketModel data) => json.encode(data.toJson());

class SeguimientoTicketModel {
    String id;
    String estado;
    String mensaje;

    SeguimientoTicketModel({
        this.id,
        this.estado        = "",
        this.mensaje        = "",
    });

    factory SeguimientoTicketModel.fromJson(Map<String, dynamic> json) => SeguimientoTicketModel(
        id               : json["id"],
        estado           : json["Estado"],
        mensaje          : json["Mensaje"],
    );

    Map<String, dynamic> toJson() => {
       // "id"        : id,
        "Estado"      : estado,
        "Mensaje"     : mensaje,
    };

}
