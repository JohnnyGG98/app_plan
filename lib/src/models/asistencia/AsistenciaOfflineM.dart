
class AsistenciaOfflineM {

  int idCurso; 
  int idAlmnCurso;
  String alumno; 
  int horas; 
  String fecha; 

  AsistenciaOfflineM({
    this.idCurso,
    this.idAlmnCurso,
    this.alumno,
    this.horas,
    this.fecha
  }); 

  AsistenciaOfflineM.fromJSONMap(Map<String, dynamic> json){
    idCurso = json['id_curso'];
    idAlmnCurso = json['id_almn_curso'];
    alumno = json['alumno'];
    horas = json['horas'];
    fecha = json['fecha'];
  }

  factory AsistenciaOfflineM.getFromJson(Map<String, dynamic> json) => new AsistenciaOfflineM(
    idCurso: json['id_curso'],
    idAlmnCurso: json['id_almn_curso'],
    alumno: json['alumno'],
    horas: json['horas'],
    fecha: json['fecha']
  );

  Map<String, dynamic> toJson() => {
    "idCurso": idCurso,
    "idAlmnCurso": idAlmnCurso,
    "alumno": alumno,
    "horas": horas,
    "fecha": fecha
  };
    
}