
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:plan/src/models/CursoM.dart';
export 'package:plan/src/models/CursoM.dart';
import 'package:plan/src/utils/ConsApi.dart';

class CursoPV {
  String _url = ConsApi.path+'v0/curso/';

  Future<List<CursoM>> _obtenerCursos(url) async {
    final res = await http.get(url);
    if (esResValida(res)) {
      final decodeData = json.decode(res.body);
      final cursos = new Cursos.fromJsonList(decodeData['items']);
      return cursos.cursos;
    }
    return [];
  }

  Future<List<CursoM>> getTodos() async {
    final url = _url+'todos';
    return await _obtenerCursos(url);
  }

  Future<List<CursoM>> buscar(String query) async {
    query = quitarAsentos(query);
    final url = _url+'buscar/'+query;
    return await _obtenerCursos(url);
  }

  Future<List<CursoM>> getPorPeriodo(int idPeriodo) async {
    final url = _url+'periodo/'+idPeriodo.toString();
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
    if (esResValida(res)) {
      final decodedata = json.decode(res.body);
      List<String> nombres = new List();

      List<dynamic> jsonList = decodedata['items'];
      for(var i in jsonList){
        final n = i['curso_nombre'];
        nombres.add(n);
      }
      return nombres;
    }
    return [];
  }

  Future<List<MateriaM>> getMateriasPorNombreCursoPeriodo(String curso, int idPeriodo) async {
    final url = _url+'materia/'+curso+'-'+idPeriodo.toString();
    final res = await http.get(url);
    final decodedata = json.decode(res.body);
    final materias = Materias.fromJsonList(decodedata['items']);
    return materias.materias;
  }

  String quitarAsentos(String txt){
    txt = txt.replaceAll('Á','A');
    txt = txt.replaceAll('á','a');
    txt = txt.replaceAll('É','E');
    txt = txt.replaceAll('Í','I');
    txt = txt.replaceAll('Ó','O');
    txt = txt.replaceAll('Ú','U');
    txt = txt.replaceAll('á','a');
    txt = txt.replaceAll('é','e');
    txt = txt.replaceAll('í','i');
    txt = txt.replaceAll('ó','o');
    txt = txt.replaceAll('ú','u');
    return txt;
  }

}