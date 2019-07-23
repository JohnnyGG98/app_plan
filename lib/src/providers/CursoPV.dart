
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

  Future<List<CursoM>> buscar(String query) async {
    final url = _url+'buscar/'+query;
    print(url);
    return await _obtenerCursos(url);
  }

  Future<List<CursoM>> getPorPeriodo(int idPeriodo) async {
    final url = _url+'periodo/'+idPeriodo.toString();
    print(url);
    return await _obtenerCursos(url);
  }

  Future<List<CursoM>> getPorNombreCursoPeriodo(String p) async {
    final url = _url+'periodo/'+p;
    return await _obtenerCursos(url);
  }

  Future<List<CursoM>> getPorIdCurso(int idCurso) async {
    final url = _url+'buscar/'+idCurso.toString();
    return await _obtenerCursos(url);
  }

  Future<List<String>> getNombreCursoPorPeriodo(int idPeriodo) async {
    final url = _url+'nombre/'+idPeriodo.toString();
    final res = await http.get(url);
    final decodedata = json.decode(res.body);
    List<String> nombres = new List();

    List<dynamic> jsonList = decodedata['items'];
    for(var i in jsonList){
      final n = i['curso_nombre'];
      nombres.add(n);
    }
    return nombres;
  }

  Future<List<MateriaM>> getMateriasPorNombreCursoPeriodo(String curso, int idPeriodo) async {
    final url = _url+'materia/'+curso+'-'+idPeriodo.toString();
    final res = await http.get(url);
    final decodedata = json.decode(res.body);
    final materias = Materias.fromJsonList(decodedata['items']);
    return materias.materias;
  }

}