class AlumnoCursoAsistenciaM {

  int idCurso; 
  int idAlmnCurso; 
  String alumno; 

  AlumnoCursoAsistenciaM.fromJSONMap(Map<String, dynamic> json) {
    idCurso = json['id_curso'];
    idAlmnCurso = json['id_almn_curso'];
    alumno = json['alumno'];
  }
  
}


class AlumnoCursoAsistencias {
  List<AlumnoCursoAsistenciaM> acs = new List();

  AlumnoCursoAsistencias(); 

  AlumnoCursoAsistencias.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var j in jsonList) {
      final c = AlumnoCursoAsistenciaM.fromJSONMap(j);
      acs.add(c);
    }
  }

}