class Cursos {
  List<CursoM> cursos = new List();
  
  Cursos();

  Cursos.fromJsonList(List<dynamic> jsonList){
    if(jsonList == null) return;

    for(var item in jsonList){
      final c = new CursoM.fromJsonMap(item);
      cursos.add(c);
    }
  }
}

class CursoM {
  int idPeriodo;
  String periodoNombre;
  String docenteNombre;
  String docenteApellido;
  int idCurso;
  String nombre; 
  int ciclo; 
  int capacidad;
  int idMateria;
  String materiaNombre;

  CursoM({
    this.idPeriodo,
    this.periodoNombre,
    this.docenteNombre,
    this.docenteApellido,
    this.idCurso,
    this.nombre,
    this.ciclo,
    this.capacidad,
    this.idMateria,
    this.materiaNombre
  });

  CursoM.fromJsonMap(Map<String, dynamic> json){
    idPeriodo = json['id_prd_lectivo'];
    periodoNombre = json['prd_lectivo_nombre'];
    docenteNombre = json['persona_primer_nombre'];
    docenteApellido = json['persona_primer_apellido'];
    idCurso = json['id_curso'];
    nombre = json['curso_nombre'];
    ciclo = json['curso_ciclo'];
    capacidad = json['curso_capacidad'];
    idMateria = json['id_materia'];
    materiaNombre = json['materia_nombre'];
  }

  getDocente(){
    return docenteNombre + ' ' + docenteApellido;
  }

}