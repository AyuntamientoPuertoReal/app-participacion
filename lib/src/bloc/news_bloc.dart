import 'package:appparticipacion/src/provider/news_provider.dart';
import 'package:rxdart/rxdart.dart';

class NewsBloc{

  final _newsController = new BehaviorSubject<List<NewsModel>>();
  final _cargandoController = new BehaviorSubject<bool>();

  final _newsProvider = new NewsProvider();

  Stream<List<NewsModel>> get newsStream  => _newsController.stream;
  Stream<bool> get cargando  => _cargandoController.stream;


  void loadNews() async {

   final news = await _newsProvider.loadNews();
   _newsController.sink.add(news);

  }

  dispose(){
    _newsController?.close();
    _cargandoController?.close();
  }
}