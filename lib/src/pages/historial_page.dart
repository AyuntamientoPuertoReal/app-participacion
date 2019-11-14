import 'package:appparticipacion/src/bloc/provider.dart';
import 'package:appparticipacion/src/bloc/ticket_bloc.dart';
import 'package:appparticipacion/src/models/ticket_model.dart';
import 'package:appparticipacion/src/widgets/widget_estado.dart';
import 'package:intl/intl.dart';
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
        title: Text("Mis Incidencias"),
      ),
      body: _crearListadoTickets(ticketBloc),
      
    );
  }

 Widget _crearListadoTickets(TicketBloc ticketBloc) {

   return StreamBuilder(
     stream: ticketBloc.ticketStream,
     builder: (BuildContext context, AsyncSnapshot<List<TicketModel>> snapshot ){
      
      if(snapshot.hasData){

        final data = snapshot.data;
        
        
      return ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (BuildContext context, int index) {
          var fecha=DateTime.parse(data[index].fechaCreacion);
          var formatter = new DateFormat('dd/MM/yyyy hh:mm');
          String fechaFormateada = formatter.format(fecha);
            return InkWell(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.only(right: 10, left: 10),
                    child: Row(
                      children: <Widget>[
                        Text(data[index].nombreIncidencia,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                        Expanded(child: Container(),),
                        estado(data[index].estado.toString()),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: FadeInImage(
                      image: NetworkImage(data[index].fotoUrl),
                      placeholder: AssetImage('assets/img/jar-loading.gif'),
                      width: 50.0,
                      fit: BoxFit.contain,
                    ),
                    title: Text(data[index].descripcion,overflow: TextOverflow.ellipsis,),
                    subtitle: Row(
                      children: <Widget>[
                        // Text(data[index].fechaCreacion),
                        Text("Enviada el "+fechaFormateada),
                        //SizedBox( width: 10,),
                        //Text(data[index].solucionado.toString()),
                        //Expanded(child: Container(),),
                        //estado(data[index].estado),
                      ],
                    ),
                    onTap: (){

                      Navigator.pushNamed(context, 'detalleTicket', arguments: data[index]);
                    },
                  ),
                  
                  Divider(
                    thickness: 1.0,
                    color: Colors.black,
                  ),
                ],
              ),
              onTap: (){
                Navigator.pushNamed(context, 'detalleTicket', arguments: data[index]);
              },
            );
        },
        

      );

      }else {
         return Center(child: CircularProgressIndicator());
       }


     },
   );
  }
}