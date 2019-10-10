



import 'package:appparticipacion/src/models/noticias_model.dart';
import 'package:appparticipacion/src/provider/noticias_provider.dart';
import 'package:rxdart/rxdart.dart';

class NoticiaBloc{

  final _noticiaController = new BehaviorSubject<List<NoticiaModel>>();
  final _cargandoController = new BehaviorSubject<bool>();

  final _noticiaProvider = new NoticiaProvider();

  Stream<List<NoticiaModel>> get noticiasStream  => _noticiaController.stream;
  Stream<bool> get cargando  => _cargandoController.stream;


  void crearNoticia(NoticiaModel noticia) async {

  _cargandoController.sink.add(true);
  await _noticiaProvider.crearNoticia(noticia);
  _cargandoController.sink.add(false);

  }

  void cargarNoticia() async {

   final noticias = await _noticiaProvider.cargarNoticias();
   _noticiaController.sink.add(noticias);

  }

  void editarNoticia(NoticiaModel noticia) async {

   _cargandoController.sink.add(true);
   await _noticiaProvider.editarNoticias(noticia);
   _cargandoController.sink.add(false);

  }

  void borrarNoticia(String id) async {

   await _noticiaProvider.borrarNoticia(id);

  }

  dispose(){
    _noticiaController?.close();
    _cargandoController?.close();
  }


}