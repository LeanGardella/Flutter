// Inherited Widget

import 'package:flutter/material.dart';

import 'package:form_login_validation/src/bloc/login_bloc.dart';
export 'package:form_login_validation/src/bloc/login_bloc.dart';

import 'package:form_login_validation/src/bloc/producto_bloc.dart';
export 'package:form_login_validation/src/bloc/producto_bloc.dart';

class Provider extends InheritedWidget{

  // Implemento el singleton para evitar perder data cuando hago reload

  // --- INICIO SINGLETON ---
  static Provider _instance; // static instance

  factory Provider( {Key key, Widget child} ){ // factory que verifica instancia creada
    if (_instance == null)
      _instance = new Provider._(key: key, child: child);
    return _instance;
  }
  
  Provider._({Key key, Widget child}) : super(key: key, child: child); // Constructor privado
  // --- FIN SINGLETON ---

  final loginBloc = LoginBloc();
  final _productosBloc = ProductBloc();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true; // Siempre que haya cambio, notifico


  static LoginBloc of (BuildContext context) {
    return ( context.dependOnInheritedWidgetOfExactType<Provider>() as Provider ).loginBloc;
  }

  static ProductBloc productoBloc (BuildContext context) {
    return ( context.dependOnInheritedWidgetOfExactType<Provider>() as Provider )._productosBloc;
  }
}