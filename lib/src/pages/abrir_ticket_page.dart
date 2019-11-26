import 'dart:io';
import 'package:appparticipacion/src/bloc/provider.dart';
import 'package:appparticipacion/src/bloc/ticket_bloc.dart';
import 'package:appparticipacion/src/models/ticket_model.dart';
import 'package:appparticipacion/src/models/tipo_incidencia_model.dart';
import 'package:appparticipacion/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:appparticipacion/src/widgets/widget_modal.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:appparticipacion/src/utils/utils.dart' as utils;
import 'package:appparticipacion/src/provider/ticket_provider.dart';


class AbrirTicketPage extends StatefulWidget {
  @override
  _AbrirTicketPageState createState() => _AbrirTicketPageState();
}

class _AbrirTicketPageState extends State<AbrirTicketPage> {

  final formkey          = GlobalKey<FormState>();
  final scaffoldKey      = GlobalKey<ScaffoldState>();

  final prefs = new PreferenciasUsuario();
  TicketBloc ticketBloc;
  TicketModel ticketModel = new TicketModel();
  TipoIncidenciaModel tipoIncidencia;
  bool _guardando = false;
  bool _fotoSeleccionada= false;
  File foto;
  Widget boton;

  String longitud;
  String latitud;

  var geolocator = Geolocator();
  var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
  TextEditingController _inputFieldDateController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    tipoIncidencia = ModalRoute.of(context).settings.arguments;
    String mensaje="Para poder crear una incidencia siga los siguientes pasos:\n"+
     "\n1- Use el icono de la cámara para poder capturar una foto que verán nuestros técnicos\n"+
     "\n2- Ponga una descripción para que nuestros técnicos tengan una breve explicación sobre la incidencia\n"+
     "\n3- Pulse el botón Guardar y todo el proceso habrá terminado";
    ticketBloc = Provider.ticketbloc(context);


    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Nueva Incidencia'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.help, size: 25),
            onPressed: () => mostrarModal(context, mensaje)
          ),
          IconButton(
            icon: Icon(Icons.camera_alt, size: 25),
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
                Text("INCIDENCIA: "+tipoIncidencia.name, style: TextStyle(fontSize: 20),),
                SizedBox(height: 20),
                _mostrarFoto(),
                SizedBox(height: 10.0,),
                Text('AVISO: Al realizar la foto, se tomará tu ubicación para saber donde está la incidencia.',style: TextStyle(fontSize: 16),),
                SizedBox(height: 10.0,),
                _crearDescripcionIncidencia(),
                SizedBox(height: 20.0,),
                _crearBoton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearDescripcionIncidencia() {
    return TextFormField(
      controller: _inputFieldDateController,
      textCapitalization: TextCapitalization.sentences,
      maxLines: null,
      maxLength: 400,
      maxLengthEnforced: true,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        labelText: 'Descripción de la incidencia',
        labelStyle: TextStyle(color: Theme.of(context).primaryColor)
      ),
      style: TextStyle(
        color: Colors.blue
      ),
      onSaved: (value) => ticketModel.descripcion = value,
      validator: (value){
        
        if(value.length <  3){
          return 'Ingrese la descripcion de la incidencia';
        } else if(_fotoSeleccionada!=true){
          return 'Ingrese la foto de la incidencia';
          //return 'null';
        } else{
          return 'Ingrese la foto y la descripción de la incidencia';
        }
      },
    );
  }

  
  Widget _crearBoton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
      label: Text('Enviar', style: TextStyle(fontSize: 18),),
      icon: Icon(Icons.save),
      onPressed: (_guardando) ? null : _showDialog,
    );
  }
  void _showDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text("Enviar incidencia"),
          content: Text("Se va a enviar la incidencia."),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancelar"),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Aceptar"),
              onPressed: (){
                _submit();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    );
  }

  void _submit() async {
   // if(!formkey.currentState.validate()) return;
    print("Estado de guardado = $_guardando");
    if(formkey.currentState.validate()){
      mostrarSnackbar("Tu incidencia está siendo enviada al Ayuntamiento...");
      formkey.currentState.save();

      // cuando el formulario es valido
      setState(() { _guardando = true;});

       
        String fecha = utils.obtenerFechaCreacionTicket();

        ticketModel.fechaCreacion=fecha;
        ticketModel.latitud=latitud;
        ticketModel.longitud=longitud;
        ticketModel.pictureFile = foto;
        ticketModel.phoneIdentifierId=utils.prefs.idToken;
        ticketModel.tipoIncidencia = tipoIncidencia.id;

        print(ticketModel.toJson());
        TicketProvider tk = new TicketProvider();
        bool creado= await tk.createIncidence(ticketModel);
        
      if(creado){

       Navigator.pushReplacementNamed(context, 'home');

      } else {
        mostrarModal(context,'Registro No Guardado');
      }
  
    } else {
      return;
    }
  
  }

  void mostrarSnackbar(String mensaje){

    final snackBar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 20000), 
    );

    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  _tomarFoto() async {
    _procesarImagen(ImageSource.camera);
  }

  _procesarImagen( ImageSource origen)async{
    
    foto = await ImagePicker.pickImage(
      source: origen
    );

    if(foto != null){
      Position position = await Geolocator().getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
      String coordenada = position.latitude.toString()+","+position.longitude.toString();
      latitud = position.latitude.toString();
      longitud = position.longitude.toString();
      ticketModel.coordenadas = coordenada;
      _fotoSeleccionada = true;
    }
    setState(() {});
  }

  Widget _mostrarFoto() {
    if(foto != null){ 
      return FadeInImage(
        image: FileImage(foto),
        placeholder: AssetImage('assets/img/jar-loading.gif'),
        height: 300.0,
        fit: BoxFit.cover,
      );
    } else {
      return InkWell(
        child: Image(
          image: AssetImage('assets/img/tomar-foto.jpg'),
          height: 300.0,
          fit: BoxFit.cover,
        ),
        onTap: _tomarFoto,
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