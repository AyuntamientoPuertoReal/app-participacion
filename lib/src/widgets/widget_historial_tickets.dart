import 'package:appparticipacion/src/models/ticket_model.dart';
import 'package:flutter/material.dart';

Widget historialTicket(BuildContext context, TicketModel ticket){

final card = Container(
            
          child: Column(
            children: <Widget>[
              
              FadeInImage(

                 image: NetworkImage(ticket.fotoUrl),
                 placeholder: AssetImage('assets/img/jar-loading.gif'),
                 fadeInDuration: Duration(seconds: 4 ),
              ),
              /*
              Image(
                image: NetworkImage('https://diariomisiones.com/wp-content/uploads/2019/04/milos-meme-1024x531.jpg'),
              ),
              */
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Text(ticket.coordenadas, style: TextStyle(fontSize: 18)),
                    SizedBox(height: 15.0),
                    Text(ticket.descripcion),
                    SizedBox(height: 15.0),
                    Text(ticket.estado),
                  ],
                 ),
                )
            ],
          ),

        );


    return Container(
     
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            blurRadius: 20.0,
            spreadRadius: 2.0,
            offset: Offset(2.0, 10.0)
            )
        ]
      ),
       child: ClipRRect(
         borderRadius: BorderRadius.circular(20.0),
         child: card,
       ),
    );

  }