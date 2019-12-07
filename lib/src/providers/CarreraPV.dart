import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:plan/src/models/CarreraM.dart';
import 'package:plan/src/utils/ConsApi.dart';
export 'package:plan/src/models/CarreraM.dart';

class CarreraPV {

  String _url = ConsApi.path+'v0/carrera/';

  Future<List<CarreraM>> _obtenerCarrera(url) async{
    final res = await http.get(url);
    if (esResValida(res)) {
      final decodeData = json.decode(res.body);
      final carreras = new Carreras.fromJsonList(decodeData['items']);
      return carreras.carreras;
    }
    return [];
  }

  Future<List<CarreraM>> getTodos() async {
    final url = _url+'todos';
    return await _obtenerCarrera(url);
  }

}