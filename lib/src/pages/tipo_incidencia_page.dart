import 'package:appparticipacion/src/bloc/tipo_incidencia_bloc.dart';
import 'package:appparticipacion/src/provider/tipo_incidencia_provider.dart';
import 'package:flutter/material.dart';
import 'package:appparticipacion/src/bloc/provider.dart';


class TipoIncidenciaPage extends StatefulWidget {
  @override
  _TipoIncidenciaPageState createState() => _TipoIncidenciaPageState();
}

class _TipoIncidenciaPageState extends State<TipoIncidenciaPage> {
  @override
  Widget build(BuildContext context) {
    final tipoIncidenciaBloc = Provider.tipoIncidenciaBloc(context);
    tipoIncidenciaBloc.cargarTipoIncidencia();
    return Scaffold(
      appBar: AppBar(
        title: Text('Nueva Incidencia'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(14),
            child: Text('Elige el tipo de incidencia que quieres enviar al Ayuntamiento: ', style: TextStyle(fontSize: 20),)
          ),
          SizedBox(height: 10),
          Divider(
            thickness: 0.0,
          ),
          _cargarTiposIncidencias(context,tipoIncidenciaBloc),
        ],
      ),
    );
  }

  Widget _cargarTiposIncidencias(BuildContext context,TipoIncidenciaBloc tipoIncidenciaBloc){
    return StreamBuilder(
      stream: tipoIncidenciaBloc.tipoIncidenciaStream,
      builder: (BuildContext context, AsyncSnapshot<List<TipoIncidenciaModel>> snapshot ){
        if(snapshot.hasData){
          List<Widget> listaTipos= [];
          snapshot.data.forEach((f){
            listaTipos.add(
              ListTile(
                title: Row(
                  children:<Widget>[
                    Text(f.tipo),
                    Expanded(
                      child: Container(),
                    ),
                    Icon(Icons.arrow_forward_ios,color: Theme.of(context).primaryColor,)
                  ]
                ),
                onTap: (){
                  Navigator.pushNamed(context, 'abrirticket', arguments: f);
                },
              )
            );
            listaTipos.add(
              Divider(
                thickness: 1.0,
              )
            );
          });

          return new Expanded(
            child: ListView(
              children: listaTipos.toList(),
            ),
          );

        } else{
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      }
    );
  }
}