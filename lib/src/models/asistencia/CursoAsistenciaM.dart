class CursoAsistenciaM {
  int idCurso;
  String periodo; 
  String materia; 
  String curso;
  int dia; 
  int horas;
  String docente;  


  CursoAsistenciaM({
    this.idCurso,
    this.periodo,
    this.materia,
    this.curso,
    this.dia,
    this.horas,
    this.docente
  });

  CursoAsistenciaM.fromJSONMap(Map<String, dynamic> json){
    idCurso = json['id_curso'];
    periodo = json['prd_lectivo_nombre'];
    materia = json['materia_nombre'];
    curso = json['curso_nombre'];
    dia = json['dia_sesion'];
    horas = json['horas'] ?? 0;
  }

  factory CursoAsistenciaM.getFromJson(Map<String, dynamic> json) => new CursoAsistenciaM(
    idCurso: json['id_curso'],
    periodo: json['periodo'],
    materia: json['materia'],
    curso: json['curso'],
    dia: json['dia'],
    horas: json['horas'],
    docente: json['docente']
  );

  Map<String, dynamic> toJson() => {
    "id_curso": idCurso,
    "periodo": periodo,
    "materia": materia,
    "curso": curso,
    "dia": dia,
    "horas": horas,
    "docente": docente
  };

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