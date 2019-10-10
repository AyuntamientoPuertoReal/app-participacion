import 'package:appparticipacion/src/bloc/noticias_bloc.dart';
import 'package:appparticipacion/src/bloc/provider.dart';
import 'package:appparticipacion/src/bloc/ticket_bloc.dart';
import 'package:appparticipacion/src/models/ticket_model.dart';
import 'package:appparticipacion/src/widgets/menu_lateral.dart';
import 'package:appparticipacion/src/widgets/widget_historial_tickets.dart';
import 'package:flutter/material.dart';


class HistorialPage extends StatefulWidget {
  @override
  _HistorialPageState createState() => _HistorialPageState();
}

class _HistorialPageState extends State<HistorialPage> {
  
  @override
  Widget build(BuildContext context) {

    final ticketBloc = Provider.ticketbloc(context);
    ticketBloc.cargartickets();


    return Scaffold(
      appBar: AppBar(
        title: Text("Historial Page"),
      ),
      drawer: MenuLateralWidget(),
      body: _crearListadoTickets(ticketBloc)
    );
  }

 Widget _crearListadoTickets(TicketBloc ticketBloc) {

   return StreamBuilder(
     stream: ticketBloc.ticketStream ,
     builder: (BuildContext context, AsyncSnapshot snapshot){
      
      if(snapshot.hasData){

        final data = snapshot.data;

       return ListView.builder(
         padding: EdgeInsets.all(20.0),
         itemCount: data.length,
         itemBuilder: (context, i){
           return Column(
             children: <Widget>[
                SizedBox(height: 15.0),
                _crearTicket(context,data[i]),
                SizedBox(height: 15.0),
             ],
           );
         }
       );
      }else {
         return Center(child: CircularProgressIndicator());
       }


     },
   );

  }

  _crearTicket(BuildContext context,TicketModel data) {
    return historialTicket(context, data);
  }

}