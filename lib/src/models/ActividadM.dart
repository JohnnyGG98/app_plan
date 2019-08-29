
class Actividades{
  List<ActividadM> actividades = new List();

  Actividades();

  Actividades.fromJsonList(List<dynamic> jsonList){
    if(jsonList == null) return;

    for(var i in jsonList){
      final a = ActividadM.fromJSONMap(i);
      actividades.add(a);
    }
  }
}

class ActividadM {
  
  String titulo;
  String indicador; 
  String instrumento;
  String valoracion;
  String fechaEnvio;
  String fechaPresentacion;

  ActividadM({
    this.titulo,
    this.indicador,
    this.instrumento,
    this.valoracion,
    this.fechaEnvio,
    this.fechaPresentacion
  });

  ActividadM.fromJSONMap(Map<String, dynamic> json){
    titulo = json['titulo_unidad'];
    indicador = json['indicador'];
    instrumento = json['instrumento'];
    valoracion = json['valoracion'];
    fechaEnvio = json['fecha_envio'];
    fechaPresentacion = json['fecha_presentacion'];
  }

}