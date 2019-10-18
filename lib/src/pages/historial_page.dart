import 'package:appparticipacion/src/bloc/provider.dart';
import 'package:appparticipacion/src/bloc/ticket_bloc.dart';
import 'package:appparticipacion/src/models/ticket_model.dart';
import 'package:appparticipacion/src/widgets/menu_lateral.dart';
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
        title: Text("Historial de Incidencias"),
      ),
      drawer: MenuLateralWidget(),
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
            return Column(
              children: <Widget>[
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
                      Text('01/08/2019'),
                      SizedBox( width: 10,),
                      Text(data[index].solucionado.toString()),
                    ],
                  ),
                  onTap: (){

                    Navigator.pushNamed(context, 'detalleTicket', arguments: data[index]);
                  },
                ),
                Divider(
                  thickness: 2.0,
                ),
              ],
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