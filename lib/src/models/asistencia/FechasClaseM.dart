
class FechasClaseM {

  int idCurso; 
  String fecha; 
  int dia; 
  int horas;
  int asistenciaGuardada; 

  FechasClaseM({
    this.idCurso,
    this.fecha,
    this.dia,
    this.horas,
    this.asistenciaGuardada
  });

  FechasClaseM.fromJSONMap(Map<String, dynamic> json) {
    idCurso = json['id_curso'];
    fecha = json['fecha'];
    dia = json['dia'];
    horas = json['horas'];
    asistenciaGuardada = json['asistencia_guardada'];
  }

  factory FechasClaseM.getFromJson(Map<String, dynamic> json) => new FechasClaseM(
    idCurso: json['id_curso'],
    fecha: json['fecha'],
    dia: json['dia'],
    horas: json['horas'],
    asistenciaGuardada: json['asistencia_guardada']
  );

  Map<String, dynamic> toJson() => {
    "id_curso": idCurso,
    "fecha": fecha,
    "dia": dia,
    "horas": horas,
    "asistencia_guardada": asistenciaGuardada
  };

}

class FechasClases {

  List<FechasClaseM> fcs = new List();

  FechasClases();

  FechasClases.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var j in jsonList) {
      final fc = FechasClaseM.fromJSONMap(j);
      fcs.add(fc);
    }
  }

}