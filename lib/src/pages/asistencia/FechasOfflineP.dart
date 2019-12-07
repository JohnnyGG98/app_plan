import 'package:flutter/material.dart';
import 'package:plan/src/models/asistencia/CursoAsistenciaM.dart';
import 'package:plan/src/models/asistencia/FechasClaseM.dart';
import 'package:plan/src/providers/asistencia/FechasClasePV.dart';
import 'package:plan/src/utils/FechasComponentes.dart';
import 'package:plan/src/utils/MiThema.dart';

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
          Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 5.0),
            color: Theme.of(context).primaryColorDark,
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Text(curso.materia, style: tituloInfo,),
                Text(curso.periodo, style: tituloInfo,),
              ],
            ) 
          ),

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