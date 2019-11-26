import 'dart:async';

class V {
  final validarPassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if (password.length > 6) {
        sink.add(password);
      } else {
        sink.addError('La contraseña no es valida');
      }
    } 
  );

  final validarUsuario = StreamTransformer<String, String>.fromHandlers(
    handleData: (usuario, sink) {
      if (usuario.length >= 9) {
        sink.add(usuario);
      } else {
        sink.addError('Su usuario no es valido.');
      }
    } 
  );
}