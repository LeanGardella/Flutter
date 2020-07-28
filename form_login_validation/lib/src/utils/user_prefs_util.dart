

import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  
  // Esta clase maneja las preferencias del usuario
  // Color secundario
  // Genero
  // Nombre

  // Implemento Singleton
  static UserPreferences _instance;

  UserPreferences._(); // Constructor privado

  factory UserPreferences() {
    if(_instance == null)
      _instance = new UserPreferences._();
    return _instance;
  }

  SharedPreferences _sp;

  initPreferences() async {
    this._sp = await SharedPreferences.getInstance();

  
  }

  // Getters y setters

  get token {
    return _sp.getString('token') ?? '';
  }

  set token(String value) {
    _sp.setString('token', value);
  }
}