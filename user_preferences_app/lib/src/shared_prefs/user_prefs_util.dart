

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

  get genero {
    return _sp.getInt('genero') ?? 1;
  }

  set genero(int value) {
    _sp.setInt('genero', value);
  }

  get colorSecundario {
    return _sp.getBool('color') ?? false;
  }

  set colorSecundario(bool value) {
    _sp.setBool('color', value);
  }

  get nombre {
    return _sp.getString('nombre') ?? '';
  }

  set nombre(String value) {
    _sp.setString('nombre', value);
  }

  get ultimaPagina {
    return _sp.getString('ultima_pagina');
  }

  set ultimaPagina (String value ){
    _sp.setString('ultima_pagina', value);
  }
}