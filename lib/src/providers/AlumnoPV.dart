
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:plan/src/models/AlumnoM.dart';
export 'package:plan/src/models/AlumnoM.dart';
import 'package:plan/src/utils/ConsApi.dart';

class AlumnoPV {
  String _url = ConsApi.path+'v0/alumno/'; 

  Future<List<AlumnoM>> _obtenerAlumnos(url) async {
    final res = await http.get(url);

    final decodeData = json.decode(res.body);

    final alumnos = Alumnos.fromJsonList(decodeData['items']);

    return alumnos.alumnos;
  }

  Future<List<AlumnoM>> getTodos() async {
    final url = _url + 'todos'; 
    return await _obtenerAlumnos(url);
  }

   Future<List<AlumnoM>> getPorCurso(int id) async {
    final url = _url + 'curso/'+ id.toString(); 
    return await _obtenerAlumnos(url);
  }


}