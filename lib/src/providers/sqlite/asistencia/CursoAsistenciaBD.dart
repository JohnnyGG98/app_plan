
import 'package:plan/src/models/asistencia/CursoAsistenciaM.dart';
import 'package:plan/src/providers/sqlite/BD.dart';

class CursoAsistenciaBD extends BD {

  Future<bool> guardar(CursoAsistenciaM modelo) async {
    final db = await database; 
    final res = await db.insert('cursoasistencia', modelo.toJson());
    return res > 0;
  }

  Future<List<CursoAsistenciaM>> getByDia(int diaSemana) async {
    final db = await database;
    final res = await db.query(
      'cursoasistencia',
      where: 'dia = ?',
      whereArgs: [
        diaSemana
      ]
    );
    List<CursoAsistenciaM> list = res.isNotEmpty 
      ? res.map((m) => CursoAsistenciaM.getFromJson(m)).toList()
      : [];
    return list;
  }

  Future<List<CursoAsistenciaM>> getTodos() async {
    final db = await database;
    final res = await db.query(
      'cursoasistencia',
      columns: [
        'id_curso',
        'periodo',
        'materia',
        'curso'
      ],
      groupBy: 'id_curso, periodo, materia, curso '
    );
    List<CursoAsistenciaM> list = res.isNotEmpty 
      ? res.map((m) => CursoAsistenciaM.getFromJson(m)).toList()
      : [];
    return list;
  }

  Future<int> deleteAll() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM cursoasistencia');
    return res;
  }

}