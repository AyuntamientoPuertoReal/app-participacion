import 'package:appparticipacion/src/provider/tipo_incidencia_provider.dart';
import 'package:rxdart/rxdart.dart';

class TipoIncidenciaBloc {
  final _tipoIncidenciaController = new BehaviorSubject<List<TipoIncidenciaModel>>();
  final _cargandoController = new BehaviorSubject<bool>();

  final _tipoIncidenciaProvider = new TipoIncidenciaProvider();

  Stream<List<TipoIncidenciaModel>> get tipoIncidenciaStream => _tipoIncidenciaController.stream;
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