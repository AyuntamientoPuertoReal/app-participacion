import 'package:appparticipacion/src/bloc/provider.dart';
import 'package:appparticipacion/src/bloc/interest_points_bloc.dart';
import 'package:appparticipacion/src/widgets/widget_puntos_interes.dart';
import 'package:flutter/material.dart';


class InterestPointsPage extends StatefulWidget {
  @override
  _InterestPointsPageState createState() => _InterestPointsPageState();
}

class _InterestPointsPageState extends State<InterestPointsPage> {
  @override
  Widget build(BuildContext context) {

    final puntoIntereBloc = Provider.puntoInteresBloc(context);
    puntoIntereBloc.cargarPuntosInteres();

    return Scaffold(
      appBar: AppBar(
        title: Text("Puntos de Interés"),
      ),
      body: _crearListadoPuntosInteres(puntoIntereBloc),
    );
  }

Widget _crearListadoPuntosInteres(InterestPointsBloc puntoIntereBloc) {

  return StreamBuilder(
    stream: puntoIntereBloc.puntoInteresStream ,
    builder: (BuildContext context, AsyncSnapshot snapshot){
      
      if(snapshot.hasData){
        final data = snapshot.data;
        return ListView.builder(
          padding: EdgeInsets.all(12.0),
          itemCount: data.length,
          itemBuilder: (context, i){
            return Column(
              children: <Widget>[
                _crearPuntoInteres(context,data[i]),
                SizedBox(height: 10)
              ],
            );
          },
        );
      }else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }

    },
  );

}

  _crearPuntoInteres(BuildContext context, data) {

    return crearPuntoInteres(context, data);

  }
}