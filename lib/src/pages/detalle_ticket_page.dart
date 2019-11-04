
import 'package:appparticipacion/src/bloc/provider.dart';
import 'package:appparticipacion/src/bloc/seguimiento_ticket_bloc.dart';
import 'package:appparticipacion/src/models/seguimiento_ticket_model.dart';
import 'package:appparticipacion/src/models/ticket_model.dart';
import 'package:appparticipacion/src/widgets/widget_estado.dart';
import 'package:flutter/material.dart';

class DetalleTicketPage extends StatefulWidget {
  @override
  _DetalleTicketPageState createState() => _DetalleTicketPageState();
}

class _DetalleTicketPageState extends State<DetalleTicketPage> {

  Color color = Colors.black;


  @override
  Widget build(BuildContext context) {
    final TicketModel ticket = ModalRoute.of(context).settings.arguments;

    final seguimientoTicket = Provider.seguimientoTicketBloc(context);
    seguimientoTicket.verEstado();
    // if(ticket.solucionado){
    //   color = Colors.green;
    // }else {
    //   color = Colors.orange;
    // }
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle Incidencia'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Text(ticket.descripcion, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[  
                      Text('Estado: '),
                      SizedBox(width: 2,),
                      estado(ticket.estado),
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  ),
                  
                ],
              ),
            ),
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
            Center(child: Text("Actualizaciones del ayuntamiento"),),
            SizedBox(height: 10),
            pintaMensajeAyuntamiento(seguimientoTicket,ticket),
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

        data.forEach((f){
          if(f.estado == ticket.estado){
            mensaje=f.mensaje;
          }
        });

      //  if(ticket.estado == data[0].estado){
          return Container(
            padding: EdgeInsets.all(5),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
              border: Border.all(
                width: 2
              )
            ),
              child: Center(
                  child: Text(mensaje), 
              ),
            ),
          );
       // } 
      } else {
        return CircularProgressIndicator();
      }
      
    },
  );

  // return Container(
  //   child: Text("data"),
  // );
}