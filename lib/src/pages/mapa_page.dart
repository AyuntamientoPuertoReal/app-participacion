import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:appparticipacion/src/utils/utils.dart' as utils;

class MapaPage extends StatefulWidget {

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {

  final map = new MapController();
  final String _coordenadas = "36.527845, -6.191586";
  String tipoMapa = "streets";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mapa de  puerto real"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: (){
              map.move(utils.getCoordenadas(_coordenadas), 15);
            },
          )
        ],
      ),
      body: _crearFlutterMap(_coordenadas),
      floatingActionButton: _crearBotonFlotante(context),
    );
  }

  _crearFlutterMap(String valor) {

     return FlutterMap(
     mapController: map,
     options: MapOptions(
       center: utils.getCoordenadas(valor),
       zoom: 15
     ),
     layers: [
       _crearMapa(),
       _crearMarcadores(valor)
     ],
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

  _crearMarcadores(String coordenadas) {
   return MarkerLayerOptions(
      markers: <Marker>[
        Marker(
          width: 100.0,
          height: 100.0,
          point: utils.getCoordenadas(coordenadas),
          builder: (context) => Container(
            child: InkWell(child: Icon(Icons.location_on, size: 40.0, color: Theme.of(context).primaryColor), onTap: () => _detallePuntoInteres()),
          ),
        )
      ]
    );
  }

  _detallePuntoInteres() {
    // To-Do al hacer clic en el marcador, llevara al detalle del punto en concreto, por ejemplo informacion del ayuntamiento o el impro
    print("entro dentro del evento del marcador");
  }
}