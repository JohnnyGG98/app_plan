import 'package:flutter/material.dart';
import 'package:plan/src/models/asistencia/CursoAsistenciaM.dart';
import 'package:plan/src/models/asistencia/FechasClaseM.dart';
import 'package:plan/src/models/params/AsistenciaParam.dart';

Widget getFechasLista(
  Future<List<FechasClaseM>> fechas,
  CursoAsistenciaM curso, 
  String ruta
) {
  return FutureBuilder(
    future: fechas,
    builder: (BuildContext context, AsyncSnapshot<List<FechasClaseM>> snapshot) {
      if (snapshot.hasData) {
        final fs = snapshot.data;
        return ListView.builder(
          itemCount: fs.length,
          itemBuilder: (BuildContext context, int i) {
            return ListTile(
              title: Text(fs[i].fecha),
              subtitle: Text(curso.materia),
              trailing: FlatButton(
                child: Icon(
                  Icons.edit
                ),
                onPressed: (){
                  AsistenciaParam asistencia = AsistenciaParam();
                  asistencia.curso = curso;
                  asistencia.fecha = fs[i].fecha;
                  Navigator.pushNamed(
                    context,
                    ruta,
                    arguments: asistencia
                  );
                },
              ),
            );
          },
        );
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    },
  );
}