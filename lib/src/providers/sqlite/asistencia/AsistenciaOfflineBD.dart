
import 'package:plan/src/models/asistencia/AsistenciaOfflineM.dart';
import 'package:plan/src/providers/sqlite/BD.dart';

class AsistenciaOfflineBD extends BD {

  guardar(AsistenciaOfflineM ao) async {
    final db = await database;
    final res = await db.insert(
      'asistenciaoffline', 
      ao.toJson()
    );
    return res;
  }

  Future<bool> editar(AsistenciaOfflineM ao) async {
    final db = await database; 
    final res = await db.update(
      'asistenciaoffline', 
      ao.toJson(),
      where: 'id = ?',
      whereArgs: [ao.id]
    );
    return res > 0;
  }

  Future<List<AsistenciaOfflineM>> getByCursoFecha(int idCurso, String fecha) async {
    final db = await database;
    final res = await db.query(
      'asistenciaoffline',
      where: 'id_curso = ? '
      'AND fecha = ?',
      whereArgs: [
        idCurso,
        fecha
      ]
    );

    List<AsistenciaOfflineM> list = res.isNotEmpty ? res.map((m) => AsistenciaOfflineM.getFromJson(m)).toList() : [];

    return list;
  }

  Future<List<String>> getFechasByCurso(int idCurso) async {
    final db = await database;
    final res = await db.query(
      'asistenciaoffline',
      columns: [
        'fecha'
      ],
      orderBy: 'fecha',
      where: 'id_curso = ?',
      whereArgs: [
        idCurso
      ]
    );

    List<String> list = res.isNotEmpty ? res.map((f) => f['fecha']).toList() : []; 

    return list;
  }

  Future<int> deleteAll() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM asistenciaoffline');
    return res;
  }


}