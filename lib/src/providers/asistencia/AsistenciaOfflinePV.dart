import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:plan/src/models/asistencia/AlumnoCursoAsistenciaM.dart';
import 'package:plan/src/models/asistencia/CursoAsistenciaM.dart';
import 'package:plan/src/providers/sqlite/asistencia/AlumnoAsistenciaBD.dart';

import 'package:plan/src/providers/sqlite/asistencia/CursoAsistenciaBD.dart';
import 'package:plan/src/utils/ConsApi.dart';

class AsistenciaOfflinePV {

  String _url = ConsApi.path + 'v2/asistencia/';
  final CursoAsistenciaBD cabd = new CursoAsistenciaBD();
  final AlumnoAsistenciaBD aabd = new AlumnoAsistenciaBD();

  Future<bool> descargarCursosDocente(String identificacion) async {
    final String url = _url + 'cursos/' + identificacion;
    bool des = false;
    cabd.deleteAll();

    final res = await http.get(url);
    final data = json.decode(res.body);

    final cas = CursosAsistencia.fromJsonList(data['items']);

    cas.cas.forEach((c) => {
      des = cabd.guardar(c)
    });
    
    return des;
  }

  Future<bool> descargarAlumnosDocente(String identificacion) async {
    final String url = _url + 'alumnos/' + identificacion;
    bool des = false; 
    aabd.deleteAll();

    final res = await http.get(url);
    final data = json.decode(res.body);

    final aas = AlumnoCursoAsistencias.fromJsonList(data['items']);

    aas.acs.forEach((a) => {
      des = aabd.guardar(a)
    });
    return des;
  }

  Future<List<CursoAsistenciaM>> getCursosAll() {
    return cabd.getTodos();
  }

  Future<List<CursoAsistenciaM>> getCursosPorDia() {
    final dia = new DateTime.now();
    return cabd.getByDia(dia.weekday);
  }

}