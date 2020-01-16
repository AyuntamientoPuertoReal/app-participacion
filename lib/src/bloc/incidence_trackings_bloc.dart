import 'package:appparticipacion/src/provider/incidence_trackings_provider.dart';
import 'package:rxdart/rxdart.dart';

class IncidenceTrackingsBloc {

  final _incidenceTrackingsController = new BehaviorSubject<List<IncidenceTrackingsModel>>();
  final _cargandoController = new BehaviorSubject<bool>();

  final _incidenceTrackingsProvider = new IncidenceTrackingsProvider();

  Stream<List<IncidenceTrackingsModel>> get incidenceTrackingsStream  => _incidenceTrackingsController.stream;
  Stream<bool> get cargando  => _cargandoController.stream;


  void getState() async {

   final incidenceTracking = await _incidenceTrackingsProvider.loadIncidenceTrackings();
   _incidenceTrackingsController.sink.add(incidenceTracking);

  }

  dispose(){
    _incidenceTrackingsController?.close();
    _cargandoController?.close();
  }
}
