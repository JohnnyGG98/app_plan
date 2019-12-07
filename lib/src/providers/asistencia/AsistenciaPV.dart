import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:plan/src/models/asistencia/AlumnoAsistenciaM.dart';
import 'package:plan/src/utils/ConsApi.dart';

class AsistenciaPV {

  String _url = ConsApi.path + 'v2/asistencia/';

  Future<List<AlumnoAsistenciaM>> getListado(int idCurso, String fecha) async {
    final res = await http.get(_url + 'lista/' + idCurso.toString() + '?fecha=' + fecha);
    if (esResValida(res)) {
      final data = json.decode(res.body);
      final maps = AlumnoAsistencias.fromJsonList(data['items']);

      return maps.als;
    } 
    return [];
  }

  actualizar(int idAsistencia, int numFalta) async {
    final data = {
      'num_falta': numFalta.toString()
    };
    String url = _url + 'actualizar/' +idAsistencia.toString();
    await http.post(
      url,
      body: data
    );
  }

  

}