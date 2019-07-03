
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:plan/src/models/CursoM.dart';
export 'package:plan/src/models/CursoM.dart';
import 'package:plan/src/utils/ConsApi.dart';

class CursoPV {
  String _url = ConsApi.path+'curso/';

  Future<List<CursoM>> _obtenerCursos(url) async {
    final res = await http.get(url);

    final decodeData = json.decode(res.body);
    final cursos = new Cursos.fromJsonList(decodeData['items']);

    return cursos.cursos;
  }

  Future<List<CursoM>> getTodos() async {
    final url = _url+'todos';
    return await _obtenerCursos(url);
  }
}