import 'package:appparticipacion/src/provider/incidence_types_provider.dart';
import 'package:rxdart/rxdart.dart';

class TipoIncidenciaBloc {
  final _tipoIncidenciaController = new BehaviorSubject<List<IncidenceTypesModel>>();
  final _cargandoController = new BehaviorSubject<bool>();

  final _tipoIncidenciaProvider = new IncidenceTypesProvider();

  Stream<List<IncidenceTypesModel>> get tipoIncidenciaStream => _tipoIncidenciaController.stream;
  Stream<bool> get cargando  => _cargandoController.stream;

  void cargarTipoIncidencia() async {
    final tipoIncidencia = await _tipoIncidenciaProvider.cargarTipoIncidencia();
    _tipoIncidenciaController.sink.add(tipoIncidencia);
  }

  dispose(){
    _tipoIncidenciaController?.close();
    _cargandoController?.close();
  }
}