import 'package:plan/src/utils/ConsApi.dart';

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

class AlumnoM {
  int id; 
  int idPersona; 
  String nombre; 
  String apellido; 
  String segNombre;
  String segApellido;
  String identificacion;
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
    this.telefono,
    this.segApellido,
    this.segNombre,
    this.identificacion
  });

  AlumnoM.fromJsonMap(Map<String, dynamic> json){
    id = json['id_alumno'];
    idPersona = json['id_persona'];
    nombre=json['persona_primer_nombre'];
    apellido=json['persona_primer_apellido'];
    correo=json['persona_correo'];
    celular=json['persona_celular'];
    telefono=json['persona_telefono'];
    segNombre = json['persona_segundo_nombre'];
    segApellido = json['persona_segundo_apellido'];
    identificacion = json['persona_identificacion'];
  }

  String getNombreCompleto(){
    return nombre + ' ' + segNombre+ ' ' + apellido + ' ' + segApellido; 
  }

  String getNombreCorto(){
    return nombre + ' ' + apellido; 
  }

  String getUrlFoto(){
    return ConsApi.path+'/persona/verfoto/'+this.identificacion;
  }

}