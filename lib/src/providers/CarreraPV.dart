import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:plan/src/models/CarreraM.dart';
import 'package:plan/src/utils/ConsApi.dart';
export 'package:plan/src/models/CarreraM.dart';

class CarreraPV {

  String _url = ConsApi.path+'carrera/';


  Future<List<CarreraM>> _obtenerCarrera(url) async{
    final res = await http.get(url);
    //print(res.body);
    final decodeData = json.decode(res.body);
    //print(decodeData['items']);
    final carreras = new Carreras.fromJsonList(decodeData['items']);

    return carreras.carreras;
  }

  Future<List<CarreraM>> getTodos() async {
    final url = _url+'todos';
    print('Esta es la URL '+url.toString());
    return await _obtenerCarrera(url);
  }

}