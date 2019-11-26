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
  await _ticketProvider.createIncidence(ticket);
  _cargandoController.sink.add(false);

 }

  void cargartickets() async {

   final tickets = await _ticketProvider.cargarTicketsCiudadanos();
   _ticketController.sink.add(tickets);

  }

   dispose(){
    _ticketController?.close();
    _cargandoController?.close();
  }


}