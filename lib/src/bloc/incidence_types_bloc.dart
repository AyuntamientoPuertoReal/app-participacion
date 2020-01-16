import 'package:appparticipacion/src/provider/incidence_types_provider.dart';
import 'package:rxdart/rxdart.dart';

class IncidenceTypesBloc {
  final _incidenceTypeController = new BehaviorSubject<List<IncidenceTypesModel>>();
  final _cargandoController = new BehaviorSubject<bool>();

  final _incidenceTypesProvider = new IncidenceTypesProvider();

  Stream<List<IncidenceTypesModel>> get incidenceTypesStream => _incidenceTypeController.stream;
  Stream<bool> get cargando  => _cargandoController.stream;

  void loadIncidenceTypes() async {
    final incidenceType = await _incidenceTypesProvider.loadIncidenceTypes();
    _incidenceTypeController.sink.add(incidenceType);
  }

  dispose(){
    _incidenceTypeController?.close();
    _cargandoController?.close();
  }
}