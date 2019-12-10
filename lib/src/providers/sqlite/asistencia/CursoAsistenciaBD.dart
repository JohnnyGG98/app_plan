
import 'dart:core';

import 'package:plan/src/models/asistencia/CursoAsistenciaM.dart';
import 'package:plan/src/providers/sqlite/BD.dart';

class CursoAsistenciaBD extends BD {

  Future<bool> guardar(CursoAsistenciaM modelo) async {
    final db = await database; 
    final res = await db.insert('cursoasistencia', modelo.toJson());
    return res > 0;
  }

  Future<List<CursoAsistenciaM>> getByDia(String cedula, int diaSemana) async {
    final db = await database;
    final res = await db.query(
      'cursoasistencia',
      where: 'dia = ? AND docente = ?',
      whereArgs: [
        diaSemana,
        cedula
      ]
    );
    print('Cursos asistencia select ');
    List<CursoAsistenciaM> list = res.isNotEmpty 
      ? res.map((m) => CursoAsistenciaM.getFromJson(m)).toList()
      : [];
    return list;
  }

  Future<CursoAsistenciaM> getCurso(int idCurso) async {
    final db = await database;
    final res = await db.query(
      'cursoasistencia',
      where: 'id_curso = ?',
      whereArgs: [
        idCurso
      ]
    );
    
    return res.isNotEmpty ? CursoAsistenciaM.getFromJson(res.first) : null;
  }

  Future<List<CursoAsistenciaM>> getTodos(String cedula) async {
    final db = await database;
    final res = await db.query(
      'cursoasistencia',
      columns: [
        'id_curso',
        'periodo',
        'materia',
        'curso'
      ],
      where: 'docente = ?',
      whereArgs: [
        cedula
      ],
      groupBy: 'id_curso, periodo, materia, curso ',
      orderBy: 'curso, id_curso DESC'
    );
    List<CursoAsistenciaM> list = res.isNotEmpty 
      ? res.map((m) => CursoAsistenciaM.getFromJson(m)).toList()
      : [];
    return list;
  }

  Future<int> deleteAll(String cedula) async {
    final db = await database;
    final res = await db.rawDelete("DELETE FROM cursoasistencia WHERE docente = '$cedula'");
    return res;
  }

}