import 'dart:async';
import 'package:form_login_validation/src/validators/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators{

  final _mailCtrl =BehaviorSubject<String>();
  final _passCtrl =BehaviorSubject<String>();

  // Escuchar streams
  Stream<String> get mailStream => _mailCtrl.stream.transform(validarMail);
  Stream<String> get passStream => _passCtrl.stream.transform(validarPassword);

  // Activa botón?
  Stream<bool> get formValidStream => 
    Rx.combineLatest2(mailStream, passStream, (a, b) => true); // Observable is deprecated. Use Rx instead.

  // Agregar datos
  Function(String) get changeMail => _mailCtrl.sink.add;
  Function(String) get changePass => _passCtrl.sink.add;

  // Leer email y password
  String get email    => _mailCtrl.value;
  String get password => _passCtrl.value;

  dispose() {
      _mailCtrl?.close();
      _passCtrl?.close();
  }

}