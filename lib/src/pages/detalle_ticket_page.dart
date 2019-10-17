
import 'package:appparticipacion/src/models/ticket_model.dart';
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
    if(ticket.solucionado){
      color = Colors.green;
    }else {
      color = Colors.orange;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle Incidencia'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 15),
            FadeInImage(
              image: NetworkImage(ticket.fotoUrl),
              placeholder: AssetImage('assets/img/jar-loading.gif'),
              height: 300,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 25),
            Text('Descripción de tu incidencia', style: TextStyle(fontSize: 17, color: Colors.black45,),textAlign: TextAlign.center,),
            SizedBox(height: 25,),
            Text(ticket.descripcion, style: TextStyle(fontSize: 16),),
            SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Estado:'),
                SizedBox(width: 2,),
                Text(ticket.solucionado.toString(), style: TextStyle(color: color),),
                SizedBox(width: 20,),
                Text('Fecha:'),
                SizedBox(width: 2,),
                Text('01/08/2019'),
              ],
            )
          ],
        ),
      ),
    );
  }
}