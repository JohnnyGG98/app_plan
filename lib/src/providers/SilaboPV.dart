import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:plan/src/models/SilaboM.dart';
import 'package:plan/src/utils/ConsApi.dart';

class SilaboPV {
  String _url = ConsApi.path + 'silabo/';

  Future<List<SilaboM>> _obtenerSilabo(url) async {
    final res = await http.get(url);

    final decodedata = json.decode(res.body);
  
    //print(decodedata['items']);

    final silabos = new Silabos.fromJsonList(decodedata['items']);

    return silabos.silabos;
  }

  Future<List<SilaboM>> getTodos() async {
    final url = _url + 'todos';
    print('Esta es la URL ' + url.toString());
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
  
}
