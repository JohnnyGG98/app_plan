
import 'dart:async';

import 'package:plan/src/bloc/v.dart';

class LoginB with V {
  final _usuarioCTR = StreamController<String>.broadcast();
  final _passwordCTR = StreamController<String>.broadcast();

  // Obtener datos del stream 

  Stream<String> get usuarioStream => _usuarioCTR.stream.transform(validarUsuario);

  Stream<String> get passwordStream => _passwordCTR.stream.transform(validarPassword);

  // Insertar al stream 
  Function(String) get changeUsuario => _usuarioCTR.sink.add;

  Function(String) get changePassword => _passwordCTR.sink.add;

  dispose() {
    _usuarioCTR?.close();
    _passwordCTR?.close();
  }

}