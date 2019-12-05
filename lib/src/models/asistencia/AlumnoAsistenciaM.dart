
class AlumnoAsistencias {
  List<AlumnoAsistenciaM> als = new List();

  AlumnoAsistencias();

  AlumnoAsistencias.fromJsonList(List<dynamic> jsonlist){
    if(jsonlist == null) return;

    for(var i in jsonlist) {
      final a = AlumnoAsistenciaM.fromJSONMap(i);
      als.add(a);
    } 
  }
}


class AlumnoAsistenciaM {

  int idAsistencia;
  String alumno;
  int numFalta = 0; 

  AlumnoAsistenciaM({
    this.idAsistencia,
    this.alumno,
    this.numFalta
  });

  AlumnoAsistenciaM.fromJSONMap(Map<String, dynamic> json) {
    idAsistencia = json['id_asistencia'];
    alumno = json['alumno'];
    numFalta = json['numero_faltas'];
  }

}