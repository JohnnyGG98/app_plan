class Alumnos {
  List<AlumnoM> alumnos = new List(); 

  Alumnos(); 

  Alumnos.fromJsonList(List<dynamic> jsonList){
    if(jsonList == null) return; 

    for(var item in jsonList){
      final a = AlumnoM.fromJsonMap(item); 
      alumnos.add(a);
    }
  }
}


//[{"id_alumno":607,"id_persona":755,"persona_primer_nombre":"CRISTINA","persona_primer_apellido":"CALLE","persona_correo":"criscalle19@hotmai.com","persona_celular":"0979254168","persona_telefono":""},
class AlumnoM {
  int id; 
  int idPersona; 
  String nombre; 
  String apellido; 
  String correo; 
  String celular; 
  String telefono; 

  AlumnoM({
    this.id, 
    this.idPersona, 
    this.nombre, 
    this.apellido,
    this.correo,
    this.celular,
    this.telefono
  });

  AlumnoM.fromJsonMap(Map<String, dynamic> json){
    id = json['id_alumno'];
    idPersona = json['id_persona'];
    nombre=json['persona_primer_nombre'];
    apellido=json['persona_primer_apellido'];
    correo=json['persona_correo'];
    celular=json['persona_celular'];
    telefono=json['persona_telefono'];
  }

  String getNombreCompleto(){
    return nombre + ' ' + apellido; 
  }

}