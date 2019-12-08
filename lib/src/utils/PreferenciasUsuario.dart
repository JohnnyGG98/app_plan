import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {

  static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del nombre
  get username {
    return _prefs.getString('username') ?? '';
  }

  set username( String value ) {
    _prefs.setString('username', value);
  }


  get ultimapagina {
    return _prefs.getString('ultimapagina') ?? '/';
  }

  set ultimapagina( String value ) {
    _prefs.setString('ultimapagina', value);
  }

}
