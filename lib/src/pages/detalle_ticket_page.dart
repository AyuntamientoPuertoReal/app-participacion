
import 'package:appparticipacion/src/bloc/provider.dart';
import 'package:appparticipacion/src/bloc/seguimiento_ticket_bloc.dart';
import 'package:appparticipacion/src/models/seguimiento_ticket_model.dart';
import 'package:appparticipacion/src/models/ticket_model.dart';
import 'package:appparticipacion/src/widgets/widget_estado.dart';
import 'package:appparticipacion/src/widgets/widget_iframe.dart';
import 'package:flutter/material.dart';
import 'package:appparticipacion/src/utils/utils.dart' as utils;

class DetalleTicketPage extends StatefulWidget {
  @override
  _DetalleTicketPageState createState() => _DetalleTicketPageState();
}

class _DetalleTicketPageState extends State<DetalleTicketPage> {

  Color color = Colors.black;


  @override
  Widget build(BuildContext context) {
    final TicketModel ticket = ModalRoute.of(context).settings.arguments;
    utils.incidenceId=ticket.id;
    final seguimientoTicket = Provider.seguimientoTicketBloc(context);
    seguimientoTicket.verEstado();
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle Incidencia'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 10,),
            Text('INCIDENCIA',style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Theme.of(context).primaryColor),),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Text(ticket.descripcion, style: TextStyle(fontSize: 18),),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[  
                      Text('Estado: '),
                      SizedBox(width: 2,),
                      estado(ticket.estado.toString()),
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  ),
                  
                ],
              ),
            ),
            Divider(thickness: 3),
            SizedBox(height: 10),
            Center(child: Text("SEGUIMIENTO",style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Theme.of(context).primaryColor)),),
            pintaMensajeAyuntamiento(seguimientoTicket,ticket),
            Divider(thickness: 3),
            SizedBox(height: 10),
            Text("FOTO ENVIADA",style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Theme.of(context).primaryColor)),
            Container(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeInImage(
                    image: NetworkImage(ticket.fotoUrl),
                    placeholder: AssetImage('assets/img/jar-loading.gif'),
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            Divider(thickness: 3),
            SizedBox(height: 10),
            Text('LOCALIZACIÓN',style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Theme.of(context).primaryColor)),
            retornarIframe(context, ticket.latitud, ticket.longitud),
            SizedBox(height: 10),          
          ],
        ),
      ),
    );
  }
}

Widget pintaMensajeAyuntamiento(SeguimientoTicketBloc seguimientoTicket, TicketModel ticket){
  String mensaje = "";

 return StreamBuilder(
    stream: seguimientoTicket.ticketStream ,
    builder: (BuildContext context, AsyncSnapshot<List<SeguimientoTicketModel>> snapshot){
      if(snapshot.hasData){
        final data=snapshot.data;
        List<Widget> lista=[];
        data.forEach((f){
          
          Widget c= Container(
            padding: EdgeInsets.all(5),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.grey
              )
            ),
              child: Center(
                  child: Text(f.message),
            ),
          )
          );
          lista.add(c);
        });
        if(lista.length < 1){
          Widget vacio = Container(
            padding: EdgeInsets.all(5),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.grey
              )
            ),
              child: Center(
                  child: Text('Tu incidencia ha sido enviada. Gracias por tu colaboración.'),
            ),
          )
          );
          lista.add(vacio);
        }
          return Column(
            children: lista
          );
      } else {
        return CircularProgressIndicator();
      }
      
    },
  );
}