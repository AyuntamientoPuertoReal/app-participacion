import 'package:appparticipacion/src/provider/interest_points_provider.dart';
import 'package:rxdart/rxdart.dart';

class InterestPointsBloc {
  final _puntoInteresController = new BehaviorSubject<List<InterestPointsModel>>();
  final _cargandoController = new BehaviorSubject<bool>();

  final _puntoInteresProvider = new InterestPointsProvider();

  Stream<List<InterestPointsModel>> get interestPointsStream => _puntoInteresController.stream;
  Stream<bool> get cargando  => _cargandoController.stream;

  void cargarPuntosInteres() async {
    final puntosInteres = await _puntoInteresProvider.loadInterestPoints();
    _puntoInteresController.sink.add(puntosInteres);
  }

  dispose(){
    _puntoInteresController?.close();
    _cargandoController?.close();
  }
}