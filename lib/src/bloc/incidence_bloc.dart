import 'package:appparticipacion/src/models/incidence_model.dart';
import 'package:appparticipacion/src/provider/incidence_provider.dart';
import 'package:rxdart/rxdart.dart';

class IncidenceBloc {

   final _ticketController = new BehaviorSubject<List<IncidenceModel>>();
   final _cargandoController = new BehaviorSubject<bool>();

   final _ticketProvider = new IncidenceProvider();

     Stream<List<IncidenceModel>> get incidenceStream  => _ticketController.stream;
     Stream<bool> get cargando  => _cargandoController.stream;

   void crearTicket(IncidenceModel ticket) async {

  _cargandoController.sink.add(true);
  await _ticketProvider.createIncidence(ticket);
  _cargandoController.sink.add(false);

 }

  void cargartickets() async {

   final tickets = await _ticketProvider.loadIncidences();
   _ticketController.sink.add(tickets);

  }

   dispose(){
    _ticketController?.close();
    _cargandoController?.close();
  }
}