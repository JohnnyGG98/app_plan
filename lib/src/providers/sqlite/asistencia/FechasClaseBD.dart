

import 'package:plan/src/models/asistencia/FechasClaseM.dart';
import 'package:plan/src/providers/sqlite/BD.dart';

class FechasClaseBD extends BD {

  Future<List<FechasClaseM>> getByCurso(int idCurso) async {
    final db = await database; 
    final res = await db.query(
      'fechasclase',
      where: 'id_curso = ?',
      whereArgs: [
        idCurso
      ]
    );

    List<FechasClaseM> list = res.isNotEmpty ? res.map((f) => FechasClaseM.getFromJson(f)).toList() : []; 
    return list; 
  }

  Future<bool> guardar(FechasClaseM fc) async {
    final bd = await database; 
    final res = await bd.insert('fechasclase', fc.toJson());
    return res > 0;
  }

  Future<int> deleteAll() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM fechasclase');
    return res;
  }

}