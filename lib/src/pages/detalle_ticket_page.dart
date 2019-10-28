
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
                  RaisedButton.icon(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    label: Text("Ver seguimiento", style: TextStyle(fontSize: 18)),
                    icon: Icon(Icons.assignment),
                    onPressed: (){
                        
                    },
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[  
                      Text('Estado: '),
                      SizedBox(width: 2,),
                      Text(ticket.solucionado.toString(), style: TextStyle(color: color),),
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
            )
          ],
        ),
      ),
    );
  }
}