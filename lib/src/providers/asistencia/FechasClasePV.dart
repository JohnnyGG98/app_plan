import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:plan/src/models/asistencia/FechasClaseM.dart';
import 'package:plan/src/providers/sqlite/asistencia/FechasClaseBD.dart';
import 'package:plan/src/utils/ConsApi.dart';

class FechasClasePV {

  final String _url = ConsApi.path + 'v2/sesion/';
  final fcbd = new FechasClaseBD();

  Future<List<FechasClaseM>> getFechasDocente(String identificacion) async {
    String url = _url + 'fechas?identificacion=' + identificacion;
    final res = await http.get(url);
    if (esResValida(res)) {
      final data = json.decode(res.body); 
      final fcs = FechasClases.fromJsonList(data['items']); 
      return fcs.fcs;
    }
    return [];
  }

  Future<List<FechasClaseM>> getFechasCurso(int idCurso) async {
    String url = _url + 'fechas?idCurso=' + idCurso.toString();
    final res = await http.get(url);
    if (esResValida(res)) {
      final data = json.decode(res.body); 
      final fcs = FechasClases.fromJsonList(data['items']); 
      return fcs.fcs;
    }
    return [];
  }

  Future<List<FechasClaseM>> getFechasLocal(int idCurso) async {
    return fcbd.getByCurso(idCurso);
  }

  Future<bool> descargarFechas(String identificacion) async {
    fcbd.deleteAll();
    List<FechasClaseM> fcs = await getFechasDocente(identificacion); 
    Future<bool> des;
    fcs.forEach((c) {
      des = fcbd.guardar(c);
    });
    return des;
  }  

}