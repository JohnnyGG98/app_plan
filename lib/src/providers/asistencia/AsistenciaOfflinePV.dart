import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:plan/src/models/asistencia/AlumnoCursoAsistenciaM.dart';
import 'package:plan/src/models/asistencia/AsistenciaOfflineM.dart';
import 'package:plan/src/models/asistencia/CursoAsistenciaM.dart';
import 'package:plan/src/models/asistencia/FechasClaseM.dart';
import 'package:plan/src/providers/asistencia/FechasClasePV.dart';
import 'package:plan/src/providers/sqlite/asistencia/AlumnoAsistenciaBD.dart';
import 'package:plan/src/providers/sqlite/asistencia/AsistenciaOfflineBD.dart';

import 'package:plan/src/providers/sqlite/asistencia/CursoAsistenciaBD.dart';
import 'package:plan/src/providers/sqlite/asistencia/FechasClaseBD.dart';
import 'package:plan/src/utils/ConsApi.dart';

class AsistenciaOfflinePV {

  String _url = ConsApi.path + 'v2/asistencia/';
  final cabd = new CursoAsistenciaBD();
  final aabd = new AlumnoAsistenciaBD();
  final aobd = new AsistenciaOfflineBD();
  final fcbd = new FechasClaseBD();
  final fcpv = new FechasClasePV();

  Future<bool> descargarTodo(String identificacion) async {
    await _descargarAlumnosDocente(identificacion);
    await _descargarCursosDocente(identificacion);
    await _descargarFechas(identificacion);
    return true;
  }

  Future<bool> _descargarCursosDocente(String identificacion) async {
    final String url = _url + 'cursos/' + identificacion + '?descargar=y';
    Future<bool> des;
    cabd.deleteAll(identificacion);

    print('Cursos descargados desde aqui: ' + url);
    final res = await http.get(url);
    final data = json.decode(res.body);

    final cas = CursosAsistencia.fromJsonList(data['items']);

    cas.cas.forEach((c) {
      c.docente = identificacion;
      print('Dia: ' + c.dia.toString());
      des = cabd.guardar(c);
    });
    
    return des;
  }

  Future<bool> _descargarAlumnosDocente(String identificacion) async {
    final String url = _url + 'alumnos/' + identificacion;
    Future<bool> des;
    aabd.deleteAll();

    final res = await http.get(url);
    final data = json.decode(res.body);

    final aas = AlumnoCursoAsistencias.fromJsonList(data['items']);

     aas.acs.forEach((a) {
      des = aabd.guardar(a);
    });
    return des;
  }

  Future<bool> _descargarFechas(String identificacion) async {
    fcbd.deleteAll();
    print('Descargamos fechas docentes...');
    List<FechasClaseM> fcs = await fcpv.getFechasDocente(identificacion); 
    Future<bool> des;
    fcs.forEach((c) {
      des = fcbd.guardar(c);
    });
    return des;
  }  

  Future<List<CursoAsistenciaM>> getCursosAll(String identificacion) {
    return cabd.getTodos(identificacion);
  }

  Future<CursoAsistenciaM> getCursoById(int idCurso) async {
    return cabd.getCurso(idCurso);
  }

  Future<List<CursoAsistenciaM>> getCursosPorDia(String identificacion) {
    final dia = new DateTime.now();
    print('Fecha: ' + dia.toString());
    print('Dia: ' + dia.weekday.toString());
    return cabd.getByDia(identificacion, dia.weekday);
  }

  Future<List<AlumnoCursoAsistenciaM>> getAlumnosByCurso(int idCurso) {
    return aabd.getByCurso(idCurso);
  }

  Future<List<AsistenciaOfflineM>> getLista(
    int idCurso, 
    String fecha
  ) async {
    List<AsistenciaOfflineM> lista =  await aobd.getByCursoFecha(idCurso, fecha);

    if (lista.length == 0) {
      List<AlumnoCursoAsistenciaM> alumnos = await aabd.getByCurso(idCurso); 

      for(AlumnoCursoAsistenciaM a in alumnos) {
        AsistenciaOfflineM ao = new AsistenciaOfflineM();
        ao.idCurso = a.idCurso;
        ao.idAlmnCurso = a.idAlmnCurso; 
        ao.alumno = a.alumno;
        ao.fecha = fecha; 
        ao.horas = 0;
        
        aobd.guardar(ao);
      }
    }

    lista =  await aobd.getByCursoFecha(idCurso, fecha);

    lista.sort((a, b) {
      return a.alumno.toLowerCase().compareTo(b.alumno.toLowerCase());
    });
    return lista; 
  }

  actualizarFaltas(AsistenciaOfflineM ao) async {
    ao.sincronizado = null;
    bool res = await aobd.editar(ao);
    if (res) {
      print('Editamos correctamente');
    } else {
      print('No editamos');
    }
  }

  Future<List<String>> getFechasCurso(int idCurso) {
    return aobd.getFechasByCurso(idCurso);
  }

  Future<bool> sincronizaAhora(String docente) async {
    return await _sincronizar(docente);
  }

  Future<bool> _sincronizar(String docente) async {
    String url = _url + 'sincronizar/$docente';
    List<AsistenciaOfflineM> fechas = await aobd.getCursoFechaSinSincronizar();

    bool subido = true;

    for(AsistenciaOfflineM f in fechas) {

      List<Map<String, dynamic>> alumnos = new List();
      Map<String, dynamic> request = {
        '"id_curso"': f.idCurso,
        '"fecha"': '"${f.fecha}"',
        '"alumnos"': alumnos
      };

      List<AsistenciaOfflineM> lista = await aobd.getSinSincronizar(
        idCurso: f.idCurso,
        fecha: f.fecha        
      );

      for (AsistenciaOfflineM l in lista) {
        Map<String, dynamic> alu ={
          '"id_almn_curso"': l.idAlmnCurso,
          '"fecha"': '"${l.fecha}"',
          '"horas"': l.horas
        };
        alumnos.add(alu);
      } 

      final res = await http.post(
        url,
        body: {
          "asistencia": request.toString()
        }
      );

      if (esResValida(res)) {
        print('Res BODY: ' + res.body);
        int numAtc = await aobd.estaSincronizado(f.idCurso, f.fecha);
        print('Num actualizados... $numAtc');
      } else {
        subido = false;
      }

    }
    return subido;
  }

}