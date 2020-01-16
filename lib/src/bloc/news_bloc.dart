import 'package:appparticipacion/src/models/news_model.dart';
import 'package:appparticipacion/src/provider/news_provider.dart';
import 'package:rxdart/rxdart.dart';

class NewsBloc{

  final _noticiaController = new BehaviorSubject<List<NewsModel>>();
  final _cargandoController = new BehaviorSubject<bool>();

  final _noticiaProvider = new NewsProvider();

  Stream<List<NewsModel>> get newsStream  => _noticiaController.stream;
  Stream<bool> get cargando  => _cargandoController.stream;


  void cargarNoticia() async {

   final noticias = await _noticiaProvider.loadNews();
   _noticiaController.sink.add(noticias);

  }

  dispose(){
    _noticiaController?.close();
    _cargandoController?.close();
  }


}