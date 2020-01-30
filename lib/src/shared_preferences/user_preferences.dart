import 'package:shared_preferences/shared_preferences.dart';

/*
  Recordar instalar el paquete de:
    shared_preferences:

  Inicializar en el main
    final prefs = new UserPreferences();
    await prefs.initPrefs();
    
    Recuerden que el main() debe de ser async {...
*/

class UserPreferences {

  static final UserPreferences _instancia = new UserPreferences._internal();

  factory UserPreferences() {
    return _instancia;
  }

  UserPreferences._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del atributo
  get idToken {
    return _prefs.getString('idToken') ?? '';
  }

  set idToken ( String value ) {
    _prefs.setString('idToken', value);
  }

    get idTokenNotification {
    return _prefs.getString('idTokenNotification') ?? '';
  }

  set idTokenNotification ( String value ) {
    _prefs.setString('idTokenNotification', value);
  }
  
}