import 'package:appparticipacion/src/bloc/provider.dart';
import 'package:appparticipacion/src/bloc/incidence_trackings_bloc.dart';
import 'package:appparticipacion/src/models/incidence_trackings_model.dart';
import 'package:appparticipacion/src/models/incidence_model.dart';
import 'package:appparticipacion/src/widgets/widget_estado.dart';
import 'package:appparticipacion/src/widgets/widget_iframe.dart';
import 'package:flutter/material.dart';
import 'package:appparticipacion/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:appparticipacion/src/widgets/widget_no_connection.dart';

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
    final IncidenceModel incidence = ModalRoute.of(context).settings.arguments;

    
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de su incidencia'),
      ),
      body: FutureBuilder(
        future: serverDataChecker(context, incidence),
        initialData: Container(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.data;
        },
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

Future<Widget> serverDataChecker(BuildContext context, IncidenceModel incidence)async {
    
    Widget body;
    bool internet = await checkInternetConnection();
    
    if (internet){
      bool servidor = await checkServerConnection();
      if(servidor){
        incidenceId=incidence.id;
        final seguimientoTicket = Provider.seguimientoTicketBloc(context);
        seguimientoTicket.verEstado();
        final tipoIncidenciaBloc = Provider.tipoIncidenciaBloc(context);
        tipoIncidenciaBloc.cargarTipoIncidencia();
        body=SingleChildScrollView(
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
                  Container(alignment: Alignment.centerLeft , child: Text(incidence.descripcion, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),)),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[  
                      Text('Estado actual: '),
                      SizedBox(width: 2,),
                      estado(incidence.estado.toString()),
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
              pintaMensajeAyuntamiento(seguimientoTicket,incidence),
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
                    image: NetworkImage(urlImage+incidence.pictureUrl),
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
            retornarIframe(context, incidence.latitud, incidence.longitud),
            SizedBox(height: 10),          
          ],
        ),
      );
      } else{
        body=noConnectionToServer(context,'incidenceDetails');
      }
    } else{
      body=noConnectionToInternet();
    }
    return body;
  }