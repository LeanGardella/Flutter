import 'dart:async';

class Validators {

  final validarPassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (pass, sink) {
      if(pass.length >= 6)
        sink.add(pass);
      else
        sink.addError('Contraseña demasiado corta');
    }
  );

   final validarMail = StreamTransformer<String, String>.fromHandlers(
    handleData: (mail, sink) {
      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = new RegExp(pattern);

      if(regex.hasMatch(mail))
        sink.add(mail);
      else
        sink.addError('Correo electrónico inválido');
    }
  );
}