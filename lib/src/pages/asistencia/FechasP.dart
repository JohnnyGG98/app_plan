import 'package:flutter/material.dart';
import 'package:plan/src/models/asistencia/CursoAsistenciaM.dart';
import 'package:plan/src/models/asistencia/FechasClaseM.dart';
import 'package:plan/src/providers/asistencia/FechasClasePV.dart';
import 'package:plan/src/utils/FechasComponentes.dart';


class FechasP extends StatelessWidget {

  final fcpv = new FechasClasePV();
  Future<List<FechasClaseM>> fechas;
  CursoAsistenciaM curso; 

  @override
  Widget build(BuildContext context) {
    curso = ModalRoute.of(context).settings.arguments;
    fechas = fcpv.getFechasCurso(curso.idCurso);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fechas ' + 
          curso.curso
        ),
      ),
      body: getFechasLista(
        fechas, 
        curso, 
        'listaasistencia'
      ),
    );
  }

}