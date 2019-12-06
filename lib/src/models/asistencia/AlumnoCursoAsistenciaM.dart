class AlumnoCursoAsistenciaM {

  int idCurso; 
  int idAlmnCurso; 
  String alumno; 

  AlumnoCursoAsistenciaM({
    this.idCurso,
    this.idAlmnCurso,
    this.alumno
  });

  AlumnoCursoAsistenciaM.fromJSONMap(Map<String, dynamic> json) {
    idCurso = json['id_curso'];
    idAlmnCurso = json['id_almn_curso'];
    alumno = json['alumno'];
  }

  factory AlumnoCursoAsistenciaM.getFromJson(Map<String, dynamic> json) => new AlumnoCursoAsistenciaM(
    idCurso: json['id_curso'],
    idAlmnCurso: json['id_almn_curso'],
    alumno: json['alumno']
  );
  
  Map<String, dynamic> toJson() => {
    "id_curso": idCurso,
    "id_almn_curso": idAlmnCurso,
    "alumno": alumno
  };

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