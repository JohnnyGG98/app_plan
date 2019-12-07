import 'package:flutter/material.dart';
import 'package:plan/src/models/asistencia/CursoAsistenciaM.dart';
import 'package:plan/src/models/asistencia/FechasClaseM.dart';
import 'package:plan/src/models/params/AsistenciaParam.dart';
import 'package:plan/src/providers/asistencia/FechasClasePV.dart';
import 'package:plan/src/utils/FechasComponentes.dart';

class FechasOfflineP extends StatelessWidget {
  final fcpv = new FechasClasePV();
  Future<List<FechasClaseM>> fechas; 
  CursoAsistenciaM curso; 

  @override
  Widget build(BuildContext context) {
    curso = ModalRoute.of(context).settings.arguments; 
    fechas = fcpv.getFechasLocal(curso.idCurso);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fechas Offline ' + 
          curso.curso 
        ),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 20,),

          Text(curso.materia),

          Text(curso.periodo),

          SizedBox(height: 20,),

          Expanded(
            child: getFechasLista(
              fechas, 
              curso, 
              'asistenciaoffline'
            ),
          )
        ],
      ),
    );
  }

}