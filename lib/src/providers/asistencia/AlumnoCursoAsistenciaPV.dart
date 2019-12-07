import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:plan/src/models/asistencia/AlumnoCursoAsistenciaM.dart';
import 'package:plan/src/utils/ConsApi.dart';

class AlumnoCursoAsistenciaPV {

  String _url = ConsApi.path + 'v2/asistencia/';

  Future<List<AlumnoCursoAsistenciaM>> getByDocente(String identificacion) async {
    String url = _url + 'alumnos/' + identificacion;
    final res = await http.get(url); 
    if (esResValida(res)) {
      final data = json.decode(res.body);
      final acs = AlumnoCursoAsistencias.fromJsonList(data['items']); 
      return acs.acs;
    } 
    return [];
  }

}