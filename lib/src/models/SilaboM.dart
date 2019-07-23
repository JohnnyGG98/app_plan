class Silabos{

  List<SilaboM> silabos = new List(); 
  
  Silabos(); 

  Silabos.fromJsonList(List<dynamic> jsonList){
    if(jsonList == null ) return;

    for(var item in jsonList){
      final s = new SilaboM.fromJsonMap(item);
      silabos.add(s);
    }

  }

}

class SilaboM{

  int idSilabo;

  String prdLectivoNombre;

  String materiaNombre;

  int estadoSilabo;

  String cursos;


  SilaboM({

    this.idSilabo,
    this.prdLectivoNombre,
    this.materiaNombre,
    this.estadoSilabo,
    this.cursos

  });

  SilaboM.fromJsonMap(Map<String,dynamic> json){

    idSilabo          =json['id_silabo'];
    prdLectivoNombre  =json['prd_lectivo_nombre'];
    materiaNombre     =json['materia_nombre'];
    estadoSilabo      =json['estado_silabo'];
    cursos             =json['cursos'];

  }



}