import 'dart:io';

import 'package:appparticipacion/src/models/ticket_model.dart';
import 'package:appparticipacion/src/provider/ticket_provider.dart';
import 'package:rxdart/rxdart.dart';

class TicketBloc {

   final _ticketController = new BehaviorSubject<List<TicketModel>>();
   final _cargandoController = new BehaviorSubject<bool>();

   final _ticketProvider = new TicketProvider();

     Stream<List<TicketModel>> get ticketStream  => _ticketController.stream;
     Stream<bool> get cargando  => _cargandoController.stream;

   void crearTicket(TicketModel ticket) async {

  _cargandoController.sink.add(true);
  await _ticketProvider.crearTicketCiudadano(ticket);
  _cargandoController.sink.add(false);

 }

   Future<String> subirFoto(File foto) async {

   _cargandoController.sink.add(true);
   final fotoUrl = await _ticketProvider.subirImagen(foto);
   _cargandoController.sink.add(false);

   return fotoUrl;
 }

   void cargartickets() async {

   final tickets = await _ticketProvider.cargarTicketsCiudadanos();
   _ticketController.sink.add(tickets);

  }

   void editarProducto(TicketModel ticket) async {

   _cargandoController.sink.add(true);
   await _ticketProvider.editarTicketCiudadano(ticket);
   _cargandoController.sink.add(false);

  }

  void borrarTicket(String id) async {

   await _ticketProvider.borrarTicket(id);

  }

   dispose(){
    _ticketController?.close();
    _cargandoController?.close();
  }


}