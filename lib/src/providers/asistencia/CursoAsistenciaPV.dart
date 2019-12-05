import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:plan/src/models/asistencia/CursoAsistenciaM.dart';
import 'package:plan/src/utils/ConsApi.dart';

class CursoAsistenciaPV {

  String _url = ConsApi.path + 'v2/asistencia/cursos/';


  Future<List<CursoAsistenciaM>> _getCursos(String url) async {
    final res = await http.get(url);
    final data = json.decode(res.body);
    final cs = CursosAsistencia.fromJsonList(data['items']);
    return cs.cas;
  }

  Future<List<CursoAsistenciaM>> getPorDia(String usuario) async {
    String url = _url + usuario + '?dia=1';
    return await _getCursos(url);
  }

  Future<List<CursoAsistenciaM>> getTodos(String usuario) async {
    String url = _url + usuario;
    return await _getCursos(url);
  }

}