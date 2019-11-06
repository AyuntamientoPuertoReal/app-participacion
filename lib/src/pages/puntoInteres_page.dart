import 'package:appparticipacion/src/bloc/provider.dart';
import 'package:appparticipacion/src/bloc/puntos_interes_bloc.dart';
import 'package:appparticipacion/src/widgets/widget_puntos_interes.dart';
import 'package:flutter/material.dart';


class PuntoInteresPage extends StatefulWidget {
  @override
  _PuntoInteresPageState createState() => _PuntoInteresPageState();
}

class _PuntoInteresPageState extends State<PuntoInteresPage> {
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

Widget _crearListadoPuntosInteres(PuntoInteresBloc puntoIntereBloc) {

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