import 'package:appparticipacion/src/models/incidence_model.dart';
import 'package:appparticipacion/src/pages/incidence_details_page.dart';
import 'package:appparticipacion/src/provider/incidence_provider.dart';
import 'package:appparticipacion/src/utils/utils.dart' as utils;
import 'package:flutter/material.dart';


class DataSearchHistorical extends SearchDelegate{

  String seleccion="";
  String busqueda="";
  final incidence = new IncidenceProvider();
  int size = 0;

  @override
  String get searchFieldLabel => 'Buscar Incidencia';

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
           future: incidence.loadIncidences()/*.buscarPelicula(query),*/,
           builder: (BuildContext context, AsyncSnapshot<List<IncidenceModel>> snapshot) {
             if(snapshot.hasData){
    
               final incidences  = snapshot.data;
               
               return ListView(
                 children: incidences.map((incidence){
                   return ListTile(
                     leading: FadeInImage(
                       image: NetworkImage(utils.urlImage+incidence.pictureUrl),
                       placeholder: AssetImage('assets/img/no-image.png'),
                       width: 50.0,
                       fit: BoxFit.cover,
                     ),
                     title: Text(incidence.nombreIncidencia),
                     subtitle: Text( incidence.descripcion.toString() , overflow: TextOverflow.ellipsis,),
                     onTap: (){
                       close(context, null);
                       Navigator.pushNamed(context, IncidenceDetailsPage.routeName, arguments: incidence);
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
           future: incidence.loadIncidences()/*.buscarPelicula(query),*/,
           builder: (BuildContext context, AsyncSnapshot<List<IncidenceModel>> snapshot) {
             if(snapshot.hasData){
    
               final incidences  = snapshot.data;
               List<IncidenceModel> listaIncidenciasBusqueda = incidences.where((i) => i.descripcion.toLowerCase().contains(query.toLowerCase())).toList();
               size = listaIncidenciasBusqueda.length;
    
               return ListView(
                 children: listaIncidenciasBusqueda.map((incidence){
                   return ListTile(
                     leading: FadeInImage(
                       image: NetworkImage(utils.urlImage+incidence.pictureUrl),
                       placeholder: AssetImage('assets/img/no-image.png'),
                       width: 50.0,
                       fit: BoxFit.cover,
                     ),
                     title: Text(incidence.nombreIncidencia),
                     subtitle: Text( incidence.descripcion.toString() , overflow: TextOverflow.ellipsis,),
                     onTap: (){
                       close(context, null);
                       Navigator.pushNamed(context, IncidenceDetailsPage.routeName, arguments: incidence);
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