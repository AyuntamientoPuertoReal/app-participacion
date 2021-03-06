import 'package:appparticipacion/src/pages/interest_points_details_page.dart';
import 'package:appparticipacion/src/provider/interest_points_provider.dart';
import 'package:flutter/material.dart';


class DataSearch extends SearchDelegate{

  String seleccion="";
  String busqueda="";
  final puntoInteresprovider = new InterestPointsProvider();
  int size = 0;

   @override
  String get searchFieldLabel => 'Buscar punto de interés';

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
           future: puntoInteresprovider.loadInterestPoints(),
           builder: (BuildContext context, AsyncSnapshot<List<InterestPointsModel>> snapshot) {
             if(snapshot.hasData){
    
               final interestPoint  = snapshot.data;
               
               return ListView(
                 children: interestPoint.map((interestPoint){
                   return ListTile(
                     leading: FadeInImage(
                       image: NetworkImage(interestPoint.imageUrl),
                       placeholder: AssetImage('assets/img/no-image.png'),
                       width: 50.0,
                       fit: BoxFit.cover,
                     ),
                     title: Text(interestPoint.name),
                     subtitle: Text( interestPoint.description.toString() , overflow: TextOverflow.ellipsis,),
                     onTap: (){
                       close(context, null);
                       Navigator.pushNamed(context, InterestPointDetailsPage.routeName, arguments: interestPoint);
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
           future: puntoInteresprovider.loadInterestPoints(),
           builder: (BuildContext context, AsyncSnapshot<List<InterestPointsModel>> snapshot) {
             if(snapshot.hasData){
    
               final interestPoint  = snapshot.data;
               List<InterestPointsModel> listaPuntosBusqueda = interestPoint.where((i) => i.name.toLowerCase().contains(query.toLowerCase())).toList();
    
               return ListView(
                 children: listaPuntosBusqueda.map((interestPoint){
                   return ListTile(
                     leading: FadeInImage(
                       image: NetworkImage(interestPoint.imageUrl),
                       placeholder: AssetImage('assets/img/no-image.png'),
                       width: 50.0,
                       fit: BoxFit.cover,
                     ),
                     title: Text(interestPoint.name),
                     subtitle: Text( interestPoint.description.toString() , overflow: TextOverflow.ellipsis,),
                     onTap: (){
                       close(context, null);
                       Navigator.pushNamed(context, InterestPointDetailsPage.routeName, arguments: interestPoint);
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