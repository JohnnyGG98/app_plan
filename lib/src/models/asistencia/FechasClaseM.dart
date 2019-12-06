
class FechasClaseM {

  int idCurso; 
  String fecha; 
  int dia; 
  int horas;

  FechasClaseM({
    this.idCurso,
    this.fecha,
    this.dia,
    this.horas
  });

  FechasClaseM.fromJSONMap(Map<String, dynamic> json) {
    idCurso = json['id_curso'];
    fecha = json['fecha'];
    dia = json['dia'];
    horas = json['horas'];
  }

  factory FechasClaseM.getFromJson(Map<String, dynamic> json) => new FechasClaseM(
    idCurso: json['id_curso'],
    fecha: json['fecha'],
    dia: json['dia'],
    horas: json['horas']
  );

  Map<String, dynamic> toJson() => {
    "id_curso": idCurso,
    "fecha": fecha,
    "dia": dia,
    "horas": horas
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