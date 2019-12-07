import 'package:plan/src/models/PeriodoM.dart';
import 'package:plan/src/utils/ConsApi.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class PeriodoPV {
  String _url = ConsApi.path+'v0/periodo/';

  Future<List<PeriodoM>> _obtenerPeriodo(url) async {
    final res = await http.get(url);
    if (esResValida(res)) {
      final decodeData = json.decode(res.body);
      final periodos = new Periodos.fromJsonList(decodeData['items']);

      return periodos.periodos;
    }
    return [];
  }

  Future<List<PeriodoM>> getTodos() async {
    final url = _url+'todos';
    return await _obtenerPeriodo(url);
  }

  Future<List<PeriodoM>> getPorCarrera(int idCarrera) async {
    final url = _url+'carrera/'+idCarrera.toString();
    return await _obtenerPeriodo(url);
  }
}