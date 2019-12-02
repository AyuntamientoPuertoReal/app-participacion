import 'dart:async';
import 'dart:io';
import 'package:appparticipacion/src/bloc/provider.dart';
import 'package:appparticipacion/src/bloc/incidence_bloc.dart';
import 'package:appparticipacion/src/models/incidence_model.dart';
import 'package:appparticipacion/src/models/incidence_types_model.dart';
import 'package:appparticipacion/src/shared_preferences/user_preferences.dart';
import 'package:appparticipacion/src/widgets/widget_modal.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:appparticipacion/src/utils/utils.dart';
import 'package:appparticipacion/src/provider/incidence_provider.dart';
import 'package:appparticipacion/src/widgets/widget_no_connection.dart';

class CreateIncidencePage extends StatefulWidget {
  @override
  _CreateIncidencePageState createState() => _CreateIncidencePageState();
}

class _CreateIncidencePageState extends State<CreateIncidencePage> {

  final formkey          = GlobalKey<FormState>();
  final scaffoldKey      = GlobalKey<ScaffoldState>();

  final prefs = new UserPreferences();
  IncidenceBloc ticketBloc;
  IncidenceModel ticketModel = new IncidenceModel();
  IncidenceTypesModel tipoIncidencia;
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
      body: FutureBuilder(
        future: serverDataChecker(context),
        initialData: Container(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.data;
        },
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
        final int valorMinimo=10;
        if(value.length <  valorMinimo){
          return 'La descripción de la incidencia es demasiado corta';
        } else if(_fotoSeleccionada!=true){
          return 'Ingrese la foto de la incidencia';
          //return 'null';
        } else{
          return null;
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
    if(formkey.currentState.validate()){
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
    }else{
      return;
    }
  }

  void _submit() async {
    print("Estado de guardado = $_guardando");
    
    Connectivity connectivity;
    connectivity = new Connectivity();
    ConnectivityResult result = await connectivity.checkConnectivity();
    
    var _connectionStatus = result.toString();
    print(_connectionStatus);
    
    if (result == ConnectivityResult.wifi || result == ConnectivityResult.mobile) {
      mostrarSnackbar("Tu incidencia está siendo enviada al Ayuntamiento...");
      formkey.currentState.save();
      // cuando el formulario es valido
      setState(() { _guardando = true;});

      ticketModel.latitud=latitud;
      ticketModel.longitud=longitud;
      ticketModel.pictureFile = foto;
      ticketModel.phoneIdentifierId=prefs.idToken;
      ticketModel.tipoIncidencia = tipoIncidencia.id;

      print(ticketModel.toJson());
      IncidenceProvider tk = new IncidenceProvider();
      bool creado= await tk.createIncidence(ticketModel);
      
      if(creado){

      Navigator.pushReplacementNamed(context, 'home');

      } else {
        mostrarModal(context,'La incidencia no se ha guardado. Inténtelo de nuevo más tarde.');
      }

    } else {
      //setState(() {});
      
      mostrarModal(context,'La incidencia no se ha enviado porque no tiene conexión a Internet. Inténtelo de nuevo más tarde.');
    }
    
  
  
 
    // if(formkey.currentState.validate()){
      
    // } else {
    //   return;
    // }
  
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

    Future<Widget> serverDataChecker(BuildContext context)async {
    
    Widget body;
    bool internet = await checkInternetConnection();
    
    if (internet){
      bool servidor = await checkServerConnection();
      if(servidor){
        body = SingleChildScrollView(
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
      );
      } else{
        body=noConnectionToServer();
      }
    } else{
      body=noConnectionToInternet();
    }
    return body;
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