import 'package:flutter/material.dart';
import 'package:plan/src/models/asistencia/CursoAsistenciaM.dart';
import 'package:plan/src/models/asistencia/FechasClaseM.dart';
import 'package:plan/src/models/params/AsistenciaParam.dart';
import 'package:plan/src/utils/MiThema.dart';

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
        return GridView.builder(
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 7,
            mainAxisSpacing: 7,
            childAspectRatio: 2.0
          ),
          itemCount: fs.length,
          itemBuilder: (BuildContext context, int i) {

            return ListTile(
              title: Text(
                fs[i].fecha,
                style: TextStyle(
                  color: fs[i].asistenciaGuardada != 0 ? 
                  Colors.green : Colors.black
                ),
              ),
              subtitle: Text(
                fs[i].horas.toString() + ' horas',
              ),
              onTap: () async {
                curso.horas = fs[i].horas;
                AsistenciaParam asistencia = AsistenciaParam();
                asistencia.curso = curso;
                asistencia.fecha = fs[i].fecha;
                Navigator.pushNamed(
                  context,
                  ruta,
                  arguments: asistencia
                );
              },
              
            );

          }
        );
      } else {
        return cargando(context);
      }
    },
  );
}