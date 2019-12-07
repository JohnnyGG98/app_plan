import 'package:flutter/material.dart';
import 'package:plan/src/models/asistencia/AlumnoAsistenciaM.dart';
import 'package:plan/src/models/params/AsistenciaParam.dart';
import 'package:plan/src/providers/asistencia/AsistenciaPV.dart';
import 'package:plan/src/utils/AsistenciaComponentes.dart';

class AlumnosAsistenciaP extends StatefulWidget {
  
  @override
  _AlumnosAsistenciaPState createState() => _AlumnosAsistenciaPState();
}

class _AlumnosAsistenciaPState extends State<AlumnosAsistenciaP> {
  final APV = new AsistenciaPV();
  Future<List<AlumnoAsistenciaM>> alumnos;
  List<DropdownMenuItem<String>> opts;
  AsistenciaParam param; 

  TextStyle textSize = TextStyle(fontSize: 14);

  @override
  Widget build(BuildContext context) {

    if (alumnos == null) {
      param = ModalRoute.of(context).settings.arguments;
      alumnos = APV.getListado(
        param.curso.idCurso, 
        param.fecha
      );
      opts =getCmbFaltas(param.curso.horas);
    } 
    
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
      builder: (BuildContext context, AsyncSnapshot<List<AlumnoAsistenciaM>> snapshot){
        if(snapshot.hasData){
          final als = snapshot.data;
          return ListView.builder(
            itemCount: als.length,
            itemBuilder: (BuildContext context, int i){
              return _alumno(als[i], i);
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

  Widget _alumno(AlumnoAsistenciaM a, int pos) {
    return ListTile(
      title: Text(
        a.alumno,
        style: textSize,
      ),
      leading: CircleAvatar(
        child: Text((pos + 1).toString()),
        backgroundColor: Colors.blueGrey,
      ),
      trailing: DropdownButton(
        value: a.numFalta.toString(),
        items: opts,
        onChanged: ((s) {
          setState(() {
            a.numFalta = int.parse(s);
            APV.actualizar(
              a.idAsistencia, 
              a.numFalta
            );
          });
        }),
      ),
    );
  }
  
}