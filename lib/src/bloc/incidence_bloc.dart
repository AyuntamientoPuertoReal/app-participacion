import 'package:appparticipacion/src/provider/incidence_provider.dart';
import 'package:rxdart/rxdart.dart';

class IncidencesBloc {

  final _incidencesController = new BehaviorSubject<List<IncidenceModel>>();
  final _cargandoController = new BehaviorSubject<bool>();

  final _incidenceProvider = new IncidenceProvider();

  Stream<List<IncidenceModel>> get incidenceStream  => _incidencesController.stream;
  Stream<bool> get cargando  => _cargandoController.stream;

  void createIncidence(IncidenceModel incidence) async {

    _cargandoController.sink.add(true);
    await _incidenceProvider.createIncidence(incidence);
    _cargandoController.sink.add(false);
  }

  void loadIncidence() async {

   final incidences = await _incidenceProvider.loadIncidences();
   _incidencesController.sink.add(incidences);
  }

   dispose(){
    _incidencesController?.close();
    _cargandoController?.close();
  }
}