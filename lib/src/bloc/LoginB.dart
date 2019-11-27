
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:plan/src/bloc/v.dart';

class LoginB with V {
  final _usuarioCTR = BehaviorSubject<String>();
  final _passwordCTR = BehaviorSubject<String>();

  // Obtener datos del stream 

  Stream<String> get usuarioStream => _usuarioCTR.stream.transform(validarUsuario);

  Stream<String> get passwordStream => _passwordCTR.stream.transform(validarPassword);

  // Insertar al stream 
  Function(String) get changeUsuario => _usuarioCTR.sink.add;

  Function(String) get changePassword => _passwordCTR.sink.add;

  // Obtenemos los ultimos valores  

  String get usuario => _usuarioCTR.value;
  String get password => _passwordCTR.value; 

  // Validamos que los dos campos esten llenos  
  Stream<bool> get formValidLogin => 
    Observable.combineLatest2(usuarioStream, passwordStream, (e, p) => true);

  dispose() {
    _usuarioCTR?.close();
    _passwordCTR?.close();
  }

}