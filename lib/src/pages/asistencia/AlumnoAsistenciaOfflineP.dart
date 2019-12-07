import 'package:flutter/material.dart';
import 'package:plan/src/models/asistencia/AsistenciaOfflineM.dart';
import 'package:plan/src/models/params/AsistenciaParam.dart';
import 'package:plan/src/providers/asistencia/AsistenciaOfflinePV.dart';
import 'package:plan/src/utils/AsistenciaComponentes.dart'; 

class AlumnoAsistenciaOfflineP extends StatefulWidget {

  _AlumnoAsistenciaOfflinePState createState() => _AlumnoAsistenciaOfflinePState();
}

class _AlumnoAsistenciaOfflinePState extends State<AlumnoAsistenciaOfflineP> {

  final aopv = new AsistenciaOfflinePV();
  
  Future<List<AsistenciaOfflineM>> alumnos;
  List<DropdownMenuItem<String>> _opts;
  AsistenciaParam param; 

  @override
  Widget build(BuildContext context) {    
    _iniciar();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          param.curso.curso + ' ' + 
          param.curso.materia 
        ),
      ),
      body: _page(),
    );
  }

  _iniciar() async {
    if (alumnos == null) {
      param = ModalRoute.of(context).settings.arguments; 

      if (param.curso.horas != null) {
        _opts = getCmbFaltas(param.curso.horas);
      } else {
        param.curso = await aopv.getCursoById(param.curso.idCurso);
        _opts = getCmbFaltas(param.curso.horas);
      }
    
      alumnos = aopv.getLista(
        param.curso.idCurso, 
        param.fecha
      ); 

      setState(() {});
    }
  }

  Widget _page() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 2.0,
        vertical: 0.0
      ),
      child: _listaAlumnos(),
    );
  }

  Widget _listaAlumnos(){
    return FutureBuilder(
      future: alumnos,
      builder: (BuildContext context, AsyncSnapshot<List<AsistenciaOfflineM>> snapshot){
        if(snapshot.hasData){
          final als = snapshot.data;
          return ListView.builder(
            itemCount: als.length,
            itemBuilder: (BuildContext context, int i){
              return _alumno(als[i]);
            },
          );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }


  Widget _alumno(AsistenciaOfflineM a) {
    return Card(
      child: ListTile(
        title: Text(a.alumno),
        trailing: DropdownButton(
          value: a.horas.toString(),
          items: _opts,
          onChanged: ((s) {
            setState(() {
              a.horas = int.parse(s);
              aopv.actualizarFaltas(a);
            });
          }),
        ),
      ),
    );
  }

}