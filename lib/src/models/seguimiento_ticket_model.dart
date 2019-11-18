import 'dart:convert';

SeguimientoTicketModel ticketModelFromJson(String str) => SeguimientoTicketModel.fromJson(json.decode(str));

String ticketModelToJson(SeguimientoTicketModel data) => json.encode(data.toJson());

class SeguimientoTicketModel {
    int id;
    int incidenceId;
    int staffId;
    String processingUnits;
    int status;
    String message;
    String date;

    SeguimientoTicketModel({
        this.id,
        this.incidenceId,
        this.staffId,
        this.processingUnits = '',
        this.status,
        this.message = '',
        this.date = ''
    });

    factory SeguimientoTicketModel.fromJson(Map<String, dynamic> json) => SeguimientoTicketModel(
        id               : json["id"],
        incidenceId      : json[""],
        staffId          : json["staff_id"],
        processingUnits  : json["processing_units"],
        status           : json["status"],
        message          : json["message"],
        date             : json["date"],
    );

    Map<String, dynamic> toJson() => {
       // "id"        : id,
        "Estado"      : status,
        "Mensaje"     : message,
    };

}
