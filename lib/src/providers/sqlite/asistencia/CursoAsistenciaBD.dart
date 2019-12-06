
import 'package:plan/src/models/asistencia/CursoAsistenciaM.dart';
import 'package:plan/src/providers/sqlite/BD.dart';

class CursoAsistenciaBD extends BD {

  guardar(CursoAsistenciaM modelo) async {
    final db = await database; 
    final res = await db.insert('cursoasistencia', modelo.toJson());
    return res;
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
    return _getFromRes(res);
  }

  Future<List<CursoAsistenciaM>> getTodos() async {
    final db = await database;
    final res = await db.query('cursoasistencia');
    return _getFromRes(res);
  }

  List<CursoAsistenciaM> _getFromRes(res) {
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