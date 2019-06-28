class Periodos {
  List<PeriodoM> periodos = new List(); 
  Periodos();

  Periodos.fromJsonList(List<dynamic> jsonList){
    if(jsonList == null) return; 

    for(var item in jsonList){
      final p = new PeriodoM.fromJsonMap(item);
      periodos.add(p);
    }
  }
}

class PeriodoM {
  int id; 
  String nombre; 

  PeriodoM({
    this.id,
    this.nombre
  });

  PeriodoM.fromJsonMap(Map<String, dynamic> json){
    id = json['id_prd_lectivo'];
    nombre = json['prd_lectivo_nombre'];
  }

}