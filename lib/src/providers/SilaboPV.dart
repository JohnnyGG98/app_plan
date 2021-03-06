import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:plan/src/models/ActividadM.dart';
import 'package:plan/src/models/SilaboM.dart';
import 'package:plan/src/utils/ConsApi.dart';

class SilaboPV {
  String _url = ConsApi.path + 'v0/silabo/';

  Future<List<SilaboM>> _obtenerSilabo(url) async {
    final res = await http.get(url);
    if (esResValida(res)) {
      final decodedata = json.decode(res.body);
      final silabos = new Silabos.fromJsonList(decodedata['items']);
      return silabos.silabos;
    }
    return [];
  }

  Future<List<SilaboM>> getTodos() async {
    final url = _url + 'todos';
    return await _obtenerSilabo(url);
  }

  Future<List<SilaboM>> getPorPeriodo(String idPeriodo) async {
    final url = _url + 'periodo/'+idPeriodo;
    return await _obtenerSilabo(url);
  }

  Future<List<SilaboM>> getPorNombreCursoPeriodo(String p) async {
    final url = _url + 'curso/'+p;
    return await _obtenerSilabo(url);
  }

  Future<List<SilaboM>> getPorCurso(String idCurso) async {
    final url = _url + 'curso/'+idCurso;
    return await _obtenerSilabo(url);
  }

  Future<List<ActividadM>> getActividades(String idSilabo) async {
    final url = _url + 'actividades/'+idSilabo;
    final res = await http.get(url);
    if (esResValida(res)) {
      final decodedata = json.decode(res.body);
      final actividades = new Actividades.fromJsonList(decodedata['items']);
      return actividades.actividades;
    }
    return [];
  }
  
}
