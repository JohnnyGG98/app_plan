import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';

class BD {

  static Database _dataBase;

  Future<Database> get database async {
    if ( _dataBase != null ) return _dataBase;
    // Si no existe la base de datos la iniciamos  
    _dataBase = await initDB();
    return _dataBase;
  }

  // Iniciamos nuestra base de datos 
  initDB() async {
    Directory docsDir = await getApplicationDocumentsDirectory();

    final String path = join(docsDir.path, 'plancuatro.db');

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate:  (Database db, int version ) async {
        List<String> scripts  = _script.trim().split(';');
        scripts.forEach((s) async {
          if (s.isNotEmpty && s.length > 0) {
            await db.execute(s.trim());
          }
        });
      }
    );
  }


  String _script = '''
          CREATE TABLE cursoasistencia (
           id_curso INTEGER, 
           periodo TEXT, 
           materia TEXT, 
           curso TEXT, 
           dia INTEGER, 
           horas INTEGER,
           docente TEXT 
          ); 
          CREATE TABLE alumnocursoasistencia( 
           id_curso INTEGER, 
           id_almn_curso INTEGER, 
           alumno TEXT 
          );  
          CREATE TABLE asistenciaoffline ( 
           id INTEGER PRIMARY KEY, 
           id_curso INTEGER, 
           id_almn_curso INTEGER, 
           alumno TEXT, 
           horas INTEGER, 
           fecha TEXT, 
           sincronizado INT
          );  
          CREATE TABLE fechasclase ( 
           id_curso INTEGER, 
           fecha TEXT, 
           dia INTEGER, 
           horas INTEGER
          ); ''';

}