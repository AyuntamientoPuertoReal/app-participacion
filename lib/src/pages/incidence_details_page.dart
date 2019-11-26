import 'package:appparticipacion/src/bloc/provider.dart';
import 'package:appparticipacion/src/bloc/incidence_trackings_bloc.dart';
import 'package:appparticipacion/src/models/incidence_trackings_model.dart';
import 'package:appparticipacion/src/models/incidence_model.dart';
import 'package:appparticipacion/src/widgets/widget_estado.dart';
import 'package:appparticipacion/src/widgets/widget_iframe.dart';
import 'package:flutter/material.dart';
import 'package:appparticipacion/src/utils/utils.dart' as utils;
import 'package:intl/intl.dart';

class IncidendeDetailsPage extends StatefulWidget {
  @override
  _IncidendeDetailsPageState createState() => _IncidendeDetailsPageState();
}

class _IncidendeDetailsPageState extends State<IncidendeDetailsPage> {

  Color color = Colors.black;
  Color fondoSeguimiento = Color.fromRGBO(231, 242, 252, 1.0);
  final fondoApp = Color.fromRGBO(162, 0, 125, 0.75);


  @override
  Widget build(BuildContext context) {
    final IncidenceModel ticket = ModalRoute.of(context).settings.arguments;
    utils.incidenceId=ticket.id;
    final seguimientoTicket = Provider.seguimientoTicketBloc(context);
    seguimientoTicket.verEstado();
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Incidencia enviada'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 10,),
            Text('DESCRIPCIÓN',style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Theme.of(context).primaryColor),),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Container(alignment: Alignment.centerLeft , child: Text(ticket.descripcion, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),)),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[  
                      Text('Estado actual: '),
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
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              color: Color.fromRGBO(162, 0, 125, 0.75),
              child: Column(
                children: <Widget>[
               Center(child: Text("SEGUIMIENTO",style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white))),
               SizedBox(height: 10),
              pintaMensajeAyuntamiento(seguimientoTicket,ticket),
                ],
              ),
            ),
            SizedBox(height: 10),
            Text("FOTO ENVIADA",style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Theme.of(context).primaryColor)),
            Container(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeInImage(
                    image: NetworkImage(utils.urlImage+ticket.pictureUrl),
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

Widget pintaMensajeAyuntamiento(IncidenceTrackingsBloc seguimientoTicket, IncidenceModel ticket){


 return StreamBuilder(
    stream: seguimientoTicket.ticketStream ,
    builder: (BuildContext context, AsyncSnapshot<List<IncidenceTrackingsModel>> snapshot){
      if(snapshot.hasData){
        final data=snapshot.data;
        List<Widget> lista=[];

        var fecha=DateTime.parse(ticket.fechaCreacion);
        var formatter = new DateFormat('dd/MM/yyyy');
        String fechaFormateada = formatter.format(fecha);
        double espacioCelda=90;
        Widget enviada= Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Row(
                  children:<Widget>[
                    Container(
                      width: espacioCelda, 
                      child: Text(fechaFormateada, style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w800),)
                    ),
                    SizedBox(width: 5,),
                    estado2('1')
                  ] 
                    
                ),
                SizedBox(height: 12,),
                Row(
                  children: <Widget>[
                    Container(
                      width: espacioCelda,
                    ),
                    SizedBox(width: 5,),
                    Expanded(child: Text('Tu incidencia ha sido enviada. Gracias por tu colaboración.', style: TextStyle( fontSize:16, color: Colors.white),))
                  ],
                ),
                SizedBox(height: 10,)
                
              ],
            ),
          );
        
        lista.add(enviada);

        
        data.forEach((f){
          var fecha=DateTime.parse(f.date);
          var formatter = new DateFormat('dd/MM/yyyy');
          String fechaFormateada = formatter.format(fecha);
          Widget c= Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Row(
                  children:<Widget>[
                    Container(
                      width: espacioCelda, 
                      child: Text(fechaFormateada, style: TextStyle( fontSize: 16, color: Colors.white, fontWeight: FontWeight.w800),)
                    ),
                    SizedBox(width: 5,),
                    estado2(f.status.toString())
                    //Text(f.status.toString(), style: TextStyle(color: Colors.white),),
                    //Expanded(child: Container(child: Text(f.message, style: TextStyle(color: Colors.white),overflow: TextOverflow.clip,maxLines: 10,))),
                  ] 
                    
                ),
                SizedBox(height: 12,),
                Row(
                  children: <Widget>[
                    Container(
                      width: espacioCelda,
                    ),
                    SizedBox(width: 5,),
                    Expanded(child: Text(f.message, style: TextStyle(fontSize:16, color: Colors.white),))
                  ],
                ),
                SizedBox(height: 10,)
                
              ],
            ),
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