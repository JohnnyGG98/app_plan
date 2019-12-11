
import 'package:plan/src/models/asistencia/AlumnoCursoAsistenciaM.dart';
import 'package:plan/src/providers/sqlite/BD.dart';

class AlumnoAsistenciaBD extends BD {

  Future<bool> guardar(AlumnoCursoAsistenciaM ac) async {
    final db = await database; 
    final res = await db.insert(
      'alumnocursoasistencia', 
      ac.toJson()
    );
    return res > 0; 
  }

  Future<List<AlumnoCursoAsistenciaM>> getByCurso(int idCurso) async {
    final db = await database;
    final res = await db.query(
      'alumnocursoasistencia',
      where: 'id_curso = ?',
      whereArgs: [
        idCurso
      ],
      orderBy: 'alumno'
    );
    // Mapeamos todo en nuestros modelos  
    List<AlumnoCursoAsistenciaM> list = res.isNotEmpty 
      ? res.map((m) => AlumnoCursoAsistenciaM.getFromJson(m)).toList()
      : [];
    return list;
  }

  Future<int> deleteAll() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM alumnocursoasistencia');
    return res;
  }
  
}