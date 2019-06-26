class ModeloM {
  int id; 
  String nombre; 

  ModeloM({
    this.id,
    this.nombre
  });

  ModeloM.fromJsonMap(Map<String, dynamic> json){
    id = json['id'];
    nombre = json['nombre'];
  }

  //Cualquier metodo que necesiten
}