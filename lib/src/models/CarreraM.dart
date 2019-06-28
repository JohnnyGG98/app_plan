
class Carreras {
  List<CarreraM> carreras = new List(); 
  //Constructor vacio
  Carreras(); 

  Carreras.fromJsonList(List<dynamic> jsonList){
    if(jsonList == null ) return;

    for(var item in jsonList){
      final c = new CarreraM.fromJsonMap(item);
      carreras.add(c);
    }
  }
}


class CarreraM {
  int id;
  String nombre;
  String codigo; 

  CarreraM({
    this.id,
    this.nombre,
    this.codigo
  });

  CarreraM.fromJsonMap(Map<String, dynamic> json){
    id = json['id_carrera'];
    nombre = json['carrera_nombre'];
    codigo = json['carrera_codigo'];
  }

  

}