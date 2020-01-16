import 'package:appparticipacion/src/provider/interest_points_provider.dart';
import 'package:rxdart/rxdart.dart';

class InterestPointsBloc {
  final _interestPointsController = new BehaviorSubject<List<InterestPointsModel>>();
  final _cargandoController = new BehaviorSubject<bool>();

  final _interestPointsProvider = new InterestPointsProvider();

  Stream<List<InterestPointsModel>> get interestPointsStream => _interestPointsController.stream;
  Stream<bool> get cargando  => _cargandoController.stream;

  void loadInterestPoint() async {
    final interestPoint = await _interestPointsProvider.loadInterestPoints();
    _interestPointsController.sink.add(interestPoint);
  }

  dispose(){
    _interestPointsController?.close();
    _cargandoController?.close();
  }
}