import 'package:appparticipacion/src/bloc/provider.dart';
import 'package:appparticipacion/src/bloc/puntos_interes_bloc.dart';
import 'package:appparticipacion/src/provider/punto_interes_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:appparticipacion/src/utils/utils.dart' as utils;


class MapaPage extends StatefulWidget {

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {

  final map = new MapController();
  final List<String> _coordenadas = ["36.527845, -6.191586", "36.528371, -6.180022", "36.528124, -6.187882"];
  String tipoMapa = "streets";
  PuntoInteresProvider pI= new PuntoInteresProvider();
  @override
  Widget build(BuildContext context) {
    final puntosInteresBloc = Provider.puntoInteresBloc(context);
    puntosInteresBloc.cargarPuntosInteres();

    Future<List<PuntoInteresModel>> _listaPuntos = pI.cargarPuntoInteres();

    return Scaffold(
      appBar: AppBar(
        title: Text("Mapa de  puerto real"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: (){
              map.move(utils.getCoordenadas(_coordenadas[0]), 15);
            },
          )
        ],
      ),
      body: _crearFlutterMap(puntosInteresBloc, _listaPuntos),
      floatingActionButton: _crearBotonFlotante(context),
    );
  }

  Widget _crearFlutterMap(PuntoInteresBloc puntosInteresBloc, Future<List<PuntoInteresModel>> _listaPuntos) {
    List<Marker> lista =[];
    return FutureBuilder(
      future: _listaPuntos,
      builder: (BuildContext context, AsyncSnapshot<List<PuntoInteresModel>> snapshot){
        if(snapshot.hasData){
          snapshot.data.forEach((m){
            Marker marca = Marker(
              width: 100.0,
              height: 100.0,
              point: utils.getCoordenadas(m.geo),
              builder: (context) => Container(
                child: InkWell(child: Icon(Icons.location_on, size: 40.0, color: Theme.of(context).primaryColor), onTap: () => _detallePuntoInteres()),
              )
            );
            lista.add(marca);
          });

          return FlutterMap(
            mapController: map,
            options: MapOptions(
              center: utils.getCoordenadas("36.527845, -6.191586")
            ),
            layers: [
              _crearMapa(),
              MarkerLayerOptions(
                markers: lista
              )
            ],
          );
        } else {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  _crearBotonFlotante(BuildContext context) {
    return FloatingActionButton(
     child: Icon(Icons.repeat),
     backgroundColor: Theme.of(context).primaryColor,
     onPressed: (){
        // streets, dark, light, outdoors, satellite
        if( tipoMapa == 'streets' ){
          tipoMapa='dark';
        }else if( tipoMapa == 'dark'){
          tipoMapa='light';
        }else if( tipoMapa == 'light'){
          tipoMapa='outdoors';
        }else if( tipoMapa == 'outdoors'){
          tipoMapa='satellite';
        } else if(tipoMapa == 'satellite'){
          tipoMapa='streets';
        }

        setState(() {});
     },
   );
  }

  _crearMapa() {
   return TileLayerOptions(
    //  urlTemplate: 'https://api.mapbox.com/v4/'
    //  '{id}/{z}/{x}/{y}@2x.png?access_token={acessToken}',
    urlTemplate: "https://api.tiles.mapbox.com/v4/"
              "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
     additionalOptions: {
       'accessToken' : 'pk.eyJ1IjoieGVsZW4iLCJhIjoiY2swZ2ZpMGEyMDZpNTNmbnNicG04eDVnbSJ9.ZWd5LMcBo0EYfSgaM3_AtA',
       'id'          : 'mapbox.$tipoMapa' 
       // streets, dark, light, outdoors, satellite
     }
   );
  }

  _detallePuntoInteres() {
    // To-Do al hacer clic en el marcador, llevara al detalle del punto en concreto, por ejemplo informacion del ayuntamiento o el impro
    print("entro dentro del evento del marcador");
  }
}