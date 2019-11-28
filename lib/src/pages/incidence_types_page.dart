import 'package:appparticipacion/src/bloc/incidence_types_bloc.dart';
import 'package:appparticipacion/src/provider/incidence_types_provider.dart';
import 'package:flutter/material.dart';
import 'package:appparticipacion/src/bloc/provider.dart';
import 'package:appparticipacion/src/utils/utils.dart' as utils;


class IncidenceTypesPage extends StatefulWidget {
  @override
  _IncidenceTypesPageState createState() => _IncidenceTypesPageState();
}

class _IncidenceTypesPageState extends State<IncidenceTypesPage> {

  bool status;
  

  @override
  Widget build(BuildContext context)  {
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
  }

  Widget _cargarTiposIncidencias(BuildContext context,TipoIncidenciaBloc tipoIncidenciaBloc){
    return StreamBuilder(
      stream: tipoIncidenciaBloc.tipoIncidenciaStream,
      builder: (BuildContext context, AsyncSnapshot<List<IncidenceTypesModel>> snapshot ){
        if(snapshot.hasData){
          List<Widget> listaTipos= [];
          snapshot.data.forEach((f){
            listaTipos.add(
              ListTile(
                title: Row(
                  children:<Widget>[
                    Text(f.name),
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



        