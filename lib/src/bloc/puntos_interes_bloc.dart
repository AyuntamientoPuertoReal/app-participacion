import 'package:appparticipacion/src/provider/punto_interes_provider.dart';
import 'package:rxdart/rxdart.dart';

class PuntoInteresBloc {
  final _puntoInteresController = new BehaviorSubject<List<PuntoInteresModel>>();
  final _cargandoController = new BehaviorSubject<bool>();

  final _puntoInteresProvider = new PuntoInteresProvider();

  Stream<List<PuntoInteresModel>> get puntoInteresStream => _puntoInteresController.stream;
  Stream<bool> get cargando  => _cargandoController.stream;

  void cargarPuntosInteres() async {
    final puntosInteres = await _puntoInteresProvider.cargarPuntoInteres();
    _puntoInteresController.sink.add(puntosInteres);
  }

  dispose(){
    _puntoInteresController?.close();
    _cargandoController?.close();
  }
}