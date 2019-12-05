class CursoAsistenciaM {
  int idCurso;
  String periodo; 
  String materia; 
  String curso;
  int dia; 
  int horas; 

  CursoAsistenciaM.fromJSONMap(Map<String, dynamic> json){
    idCurso = json['id_curso'];
    periodo = json['prd_lectivo_nombre'];
    materia = json['materia_nombre'];
    curso = json['curso_nombre'];
    dia = json['dia_sesion'];
    horas = json['horas'];
  }

}

class CursosAsistencia {
  List<CursoAsistenciaM> cas = new List();

  CursosAsistencia();

  CursosAsistencia.fromJsonList(List<dynamic> jsonList){
    if (jsonList == null) return;

    for (var j in jsonList) {
      final c = CursoAsistenciaM.fromJSONMap(j);
      cas.add(c);
    }
  }
}