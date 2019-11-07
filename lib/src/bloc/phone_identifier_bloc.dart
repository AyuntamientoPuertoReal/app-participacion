import 'package:appparticipacion/src/provider/phone_identifier_provider.dart';
import 'package:rxdart/rxdart.dart';

class PhoneIdentifierBloc {

  final _phoneIdentifierController = new BehaviorSubject<PhoneIdentifierModel>();
  final _cargandoController = new BehaviorSubject<bool>();

  final _phoneIdentifierProvider = new PhoneIdentifierProvider();

  Stream<PhoneIdentifierModel> get ticketStream  => _phoneIdentifierController.stream;
  Stream<bool> get cargando  => _cargandoController.stream;

  void crearPhoneIdentifier(PhoneIdentifierModel phoneIdentifier) async {

    _cargandoController.sink.add(true);
    await _phoneIdentifierProvider.crearPhoneIdentifier(phoneIdentifier);
    _cargandoController.sink.add(false);

 }

  // void cargarPhoneIdentifier() async {

  //   final phoneIdentifier = await _phoneIdentifierProvider.cargarPhoneIdentifier();
  //   _phoneIdentifierController.sink.add(phoneIdentifier);

  // }

  dispose(){
    _phoneIdentifierController?.close();
    _cargandoController?.close();
  }


}