import 'dart:io';

import 'package:appparticipacion/src/bloc/provider.dart';
import 'package:appparticipacion/src/bloc/ticket_bloc.dart';
import 'package:appparticipacion/src/models/ticket_model.dart';
import 'package:appparticipacion/src/widgets/menu_lateral.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';


class AbrirTicketPage extends StatefulWidget {
  @override
  _AbrirTicketPageState createState() => _AbrirTicketPageState();
}

class _AbrirTicketPageState extends State<AbrirTicketPage> {

  final formkey          = GlobalKey<FormState>();
  final scaffoldKey      = GlobalKey<ScaffoldState>();

  TicketBloc ticketBloc;
  TicketModel ticketModel = new TicketModel();
  bool _guardando = false;
  File foto;

  var geolocator = Geolocator();
  var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

  @override
  Widget build(BuildContext context) {

    ticketBloc = Provider.ticketbloc(context);

    final TicketModel prodData = ModalRoute.of(context).settings.arguments;
    if(prodData != null){
      ticketModel = prodData;
    }


    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Crear ticket ciudadano'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: _seleccionarFoto,
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _tomarFoto,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formkey,
            child: Column(
              children: <Widget>[
                _mostrarFoto(),
                _crearNombre(),
                _crearPrecio(),
                SizedBox(height: 40.0,),
                _crearBoton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre() {
   return TextFormField(
     initialValue: ticketModel.descripcion,
     textCapitalization: TextCapitalization.sentences,
     decoration: InputDecoration(
       labelText: 'Descripcion'
     ),
     onSaved: (value) => ticketModel.descripcion = value,
     validator: (value){/*
       if(value.length <  3){
         return 'Ingrese la descripcion de';
       } else {
         return null;
       }*/
     },
   );
 }

 Widget _crearPrecio() {
   return TextFormField(
     initialValue: ticketModel.coordenadas.toString(),
    // keyboardType: TextInputType.number,
     keyboardType: TextInputType.numberWithOptions(decimal: true),
     decoration: InputDecoration(
       labelText: 'Precio'
     ),
     onSaved: (value) => ticketModel.coordenadas,
     validator: (value){/*
      if (utils.isNumeric(value)){
        return null;
      }else {
        return 'Solo numeros';
      }*/
     },
   );
 }

 Widget _crearBoton() {
   return RaisedButton.icon(
     shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.circular(30.0)
     ),
     color: Colors.deepPurple,
     textColor: Colors.white,
     label: Text('Guardar'),
     icon: Icon(Icons.save),
     onPressed: (_guardando) ? null : _submit,
   );
 }

 void _submit() async {

    if(!formkey.currentState.validate()) return;
    print(ticketModel.descripcion);

  if(formkey.currentState.validate()){

    formkey.currentState.save();


    // cuando el formulario es valido
    setState(() { _guardando = true;});


    if( foto != null){
      ticketModel.fotoUrl = await ticketBloc.subirFoto(foto);
       
    }

    if(ticketModel.id == null){
            Position position = await Geolocator().getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
            String coordenada = position.latitude.toString()+","+position.longitude.toString();
      
            ticketModel.solucionado=false;
            ticketModel.coordenadas = coordenada;
            ticketBloc.crearTicket(ticketModel);
          }else {
           // productosBloc.editarProducto(producto);
          }
      
        } else {
      
          return;
        }
      
        //setState(() { _guardando = true;   });
        mostrarSnackbar('Registro Guardado');
         Navigator.pushReplacementNamed(context, 'home');
        }
      
       void mostrarSnackbar(String mensaje){
      
          final snackBar = SnackBar(
            content: Text(mensaje),
            duration: Duration(milliseconds: 1500),
          );
      
          scaffoldKey.currentState.showSnackBar(snackBar);
      
        }
      
        _seleccionarFoto() async {
      
           _procesarImagen(ImageSource.gallery);
      
        }
      
        _tomarFoto() async {
      
          _procesarImagen(ImageSource.camera);
      
        }
      
        _procesarImagen( ImageSource origen)async{
                foto = await ImagePicker.pickImage(
            source: origen
            );
      
          if(foto != null){
            ticketModel.fotoUrl = null;
      
          }

          print("Texto de la foto URL"+foto.toString());
      
          setState(() {});
      
        }

      
      
        Widget  _mostrarFoto() {

         
          
          if(foto != null){ 
            //to-Do retornar imagen
            print("foto.path:"+foto.path+"||");
            return FadeInImage(
            // image: NetworkImage("https://images.pexels.com/photos/1226302/pexels-photo-1226302.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
              image: FileImage(foto),
              placeholder: AssetImage('assets/img/jar-loading.gif'),
              height: 300.0,
              fit: BoxFit.cover,
            );
          } else {
            return Image(
              image: AssetImage('assets/img/no-image.png'),
              height: 300.0,
              fit: BoxFit.cover,
            );
          }
        


        }
      
        obtenerGeo(int valor) async {
         

        Position position = await Geolocator().getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
        print("latitud = "+position.latitude.toString());
        print("Longitud = "+position.longitude.toString());

          if(valor == 1){
            return position.latitude.toString();
          }else if(valor == 2){
            return position.longitude.toString();
          }else{
            return "";
          }

        }
}