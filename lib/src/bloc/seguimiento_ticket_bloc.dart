import 'package:appparticipacion/src/models/seguimiento_ticket_model.dart';
import 'package:appparticipacion/src/provider/seguimiento_ticket_provider_page.dart';
import 'package:rxdart/rxdart.dart';

class SeguimientoTicketBloc {

   final _seguimientoTicketController = new BehaviorSubject<List<SeguimientoTicketModel>>();
   final _cargandoController = new BehaviorSubject<bool>();

   final _seguimientoTicketProvider = new SeguimientoTicketProvider();

     Stream<List<SeguimientoTicketModel>> get ticketStream  => _seguimientoTicketController.stream;
     Stream<bool> get cargando  => _cargandoController.stream;


   void verEstado() async {

   final seguimientoTicket = await _seguimientoTicketProvider.cargarSeguimientoTickets();
   _seguimientoTicketController.sink.add(seguimientoTicket);

  }

  dispose(){
    _seguimientoTicketController?.close();
    _cargandoController?.close();
  }
}
