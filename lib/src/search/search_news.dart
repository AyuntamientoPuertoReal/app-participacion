import 'package:appparticipacion/src/pages/new_details_page.dart';
import 'package:appparticipacion/src/provider/news_provider.dart';
import 'package:flutter/material.dart';


class DataSearchNews extends SearchDelegate{

  String seleccion="";
  String busqueda="";
  final puntoInteresprovider = new NewsProvider();
  int size = 0;

   @override
  String get searchFieldLabel => 'Buscar título de la noticia';

  @override
  List<Widget> buildActions(BuildContext context) {
    //Las acciones de nuestro AppBar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del AppBar
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: (){
          close(context, null);
        },
      );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que vamos a mostrar
    if(size==0){
    return Center(
      child: Container(
        child: Text("No se ha encontrado ningun resultado"),
      ),
    );
    } else {
          return Center(
      child: Container(
        child: showSearch(),
      ),
    );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen cuando la persona escriben
    // List<InterestPointsModel> listaPI = retornarInterestPoint();
       
        return showSearch();
       
      }

  Widget showSearch(){

         if(query.isEmpty){
          return FutureBuilder(
           future: puntoInteresprovider.loadNews(),
           builder: (BuildContext context, AsyncSnapshot<List<NewsModel>> snapshot) {
             if(snapshot.hasData){
    
               final news  = snapshot.data;
               
               return ListView(
                 children: news.map((noticia){
                   return ListTile(
                     leading: FadeInImage(
                       image: NetworkImage(noticia.imageUrl),
                       placeholder: AssetImage('assets/img/no-image.png'),
                       width: 50.0,
                       fit: BoxFit.cover,
                     ),
                     title: Text(noticia.title),
                     subtitle: Text( noticia.description.toString() , overflow: TextOverflow.ellipsis,),
                     onTap: (){
                       close(context, null);
                       Navigator.pushNamed(context, NewDetails.routeName, arguments: noticia);
                     },
                   );
                 }).toList(),
               );
             }else{
               return Center(
                 child: CircularProgressIndicator(),
               );
             }
           },
         );
        }else {
         return FutureBuilder(
           future: puntoInteresprovider.loadNews(),
           builder: (BuildContext context, AsyncSnapshot<List<NewsModel>> snapshot) {
             if(snapshot.hasData){
    
               final news  = snapshot.data;
               List<NewsModel> listaNoticias = news.where((i) => i.title.toLowerCase().contains(query.toLowerCase())).toList();
    
               return ListView(
                 children: listaNoticias.map((noticia){
                   return ListTile(
                     leading: FadeInImage(
                       image: NetworkImage(noticia.imageUrl),
                       placeholder: AssetImage('assets/img/no-image.png'),
                       width: 50.0,
                       fit: BoxFit.cover,
                     ),
                     title: Text(noticia.title),
                     subtitle: Text( noticia.description.toString() , overflow: TextOverflow.ellipsis,),
                     onTap: (){
                       close(context, null);
                       Navigator.pushNamed(context, NewDetails.routeName, arguments: noticia);
                     },
                   );
                 }).toList(),
               );
             }else{
               return Center(
                 child: CircularProgressIndicator(),
               );
             }
           },
         );
        }

      }

}