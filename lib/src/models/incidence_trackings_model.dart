import 'dart:convert';

IncidenceTrackingsModel ticketModelFromJson(String str) => IncidenceTrackingsModel.fromJson(json.decode(str));

String ticketModelToJson(IncidenceTrackingsModel data) => json.encode(data.toJson());

class IncidenceTrackingsModel {
    int id;
    int incidenceId;
    int staffId;
    String processingUnits;
    int status;
    String message;
    String date;

    IncidenceTrackingsModel({
        this.id,
        this.incidenceId,
        this.staffId,
        this.processingUnits = '',
        this.status,
        this.message = '',
        this.date = ''
    });

    factory IncidenceTrackingsModel.fromJson(Map<String, dynamic> json) => IncidenceTrackingsModel(
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
