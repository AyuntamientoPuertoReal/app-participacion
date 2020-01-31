import 'package:appparticipacion/src/models/incidence_model.dart';
import 'package:appparticipacion/src/pages/incidence_details_page.dart';
import 'package:appparticipacion/src/utils/utils.dart' as utils;
import 'package:appparticipacion/src/widgets/widget_incidence_status.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget historicalIncidences(BuildContext context, IncidenceModel data){
  var fecha=DateTime.parse(data.fechaCreacion);
  fecha=fecha.toLocal();
  var formatter = new DateFormat('dd/MM/yyyy HH:mm');
  String fechaFormateada = formatter.format(fecha);

  return InkWell(
    child: Column(
      children: <Widget>[
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.only(right: 10, left: 10),
          child: Row(
            children: <Widget>[
              Text(data.nombreIncidencia,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              Expanded(child: Container(),),
              incidenceStatus(data.estado.toString()),
            ],
          ),
        ),
        ListTile(
          leading: FadeInImage(
            image: NetworkImage(utils.urlImage+data.pictureUrl),
            placeholder: AssetImage('assets/img/jar-loading.gif'),
            width: 50.0,
            fit: BoxFit.contain,
          ),
          title: Text(data.descripcion,overflow: TextOverflow.ellipsis,),
          subtitle: Row(
            children: <Widget>[
              Text("Enviada el "+fechaFormateada),
            ],
          ),
          onTap: (){
            Navigator.pushNamed(context, IncidenceDetailsPage.routeName, arguments: data);
          },
        ),
        Divider(
          thickness: 1.0,
          color: Colors.grey,
        ),
      ],
    ),
    onTap: (){

      Navigator.pushNamed(context, IncidenceDetailsPage.routeName, arguments: data);

    },
  );

}