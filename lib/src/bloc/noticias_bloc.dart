



import 'package:appparticipacion/src/models/noticias_model.dart';
import 'package:appparticipacion/src/provider/noticias_provider.dart';
import 'package:rxdart/rxdart.dart';

class NoticiaBloc{

  final _noticiaController = new BehaviorSubject<List<NoticiaModel>>();
  final _cargandoController = new BehaviorSubject<bool>();

  final _noticiaProvider = new NoticiaProvider();

  Stream<List<NoticiaModel>> get noticiasStream  => _noticiaController.stream;
  Stream<bool> get cargando  => _cargandoController.stream;


  void cargarNoticia() async {

   final noticias = await _noticiaProvider.cargarNoticias();
   _noticiaController.sink.add(noticias);

  }

  dispose(){
    _noticiaController?.close();
    _cargandoController?.close();
  }


}