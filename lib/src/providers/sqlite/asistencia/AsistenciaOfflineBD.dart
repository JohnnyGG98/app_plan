
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

  editar(AsistenciaOfflineM ao) async {
    final db = await database; 
    final res = await db.update(
      'asistenciaoffline', 
      ao.toJson(),
      where: 'id = ?',
      whereArgs: [ao.id]
    );
    return res;
  }

  Future<List<AsistenciaOfflineM>> getByCursoFecha(int idCurso, String fecha) async {
    final db = await database;
    final res = await db.query(
      '',
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

  Future<int> deleteAll() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM asistenciaoffline');
    return res;
  }


}