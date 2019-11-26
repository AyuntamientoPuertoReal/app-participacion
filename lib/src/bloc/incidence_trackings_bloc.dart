import 'package:appparticipacion/src/models/incidence_trackings_model.dart';
import 'package:appparticipacion/src/provider/incidence_trackings_provider.dart';
import 'package:rxdart/rxdart.dart';

class IncidenceTrackingsBloc {

   final _seguimientoTicketController = new BehaviorSubject<List<IncidenceTrackingsModel>>();
   final _cargandoController = new BehaviorSubject<bool>();

   final _seguimientoTicketProvider = new IncidenceTrackingsProvider();

     Stream<List<IncidenceTrackingsModel>> get ticketStream  => _seguimientoTicketController.stream;
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
