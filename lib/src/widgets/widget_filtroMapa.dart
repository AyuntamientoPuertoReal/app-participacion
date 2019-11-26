import 'package:appparticipacion/src/bloc/provider.dart';
import 'package:appparticipacion/src/bloc/interest_points_bloc.dart';
import 'package:appparticipacion/src/provider/interest_points_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class MenuLateralFiltroMapa extends StatefulWidget {

  @override
  _MenuLateralFiltroMapaState createState() => _MenuLateralFiltroMapaState();
}

class _MenuLateralFiltroMapaState extends State<MenuLateralFiltroMapa> {
  InterestPointsProvider pI= new InterestPointsProvider();
  final map = new MapController();

  @override
  Widget build(BuildContext context) {

    final puntosInteresBloc = Provider.puntoInteresBloc(context);
    puntosInteresBloc.cargarPuntosInteres();
    
    return Drawer(
      child: _llamarMarcadores(context,puntosInteresBloc)
    );
  }

 Widget _llamarMarcadores(BuildContext context, InterestPointsBloc puntosInteresBloc) {

   return StreamBuilder(
      stream: puntosInteresBloc.puntoInteresStream ,
      builder: (BuildContext context, AsyncSnapshot<List<InterestPointsModel>> snapshot){
        if(snapshot.hasData){
        final data = snapshot.data;

      return Column(
        children: <Widget>[
        SizedBox(height: 50),
        Text("Leyenda del mapa", style: TextStyle(fontSize: 20)),

         new Expanded(
           child: new ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int i) {
              return ListTile(
                 leading: Icon(Icons.pages, color: Color.fromRGBO(92, 0, 122, 1.0),),
                 title: Text(data[i].name),
                 trailing: IconButton(
                   icon: Icon(Icons.accessible_forward),
                   onPressed: (){

                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, 'puntoInteresDetalle', arguments: data[i]);
                    
                   },
                 ),
                 onTap: (){
                   //map.move(utils.getCoordenadas(data[i].latitude), 15); 
                  },
                );
              },
            ),
           ),
          ],
        );

        }else{
          return Container();
        }
      },
    );


  }
}


