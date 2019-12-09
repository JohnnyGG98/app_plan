import 'package:flutter/material.dart';
import 'package:plan/src/models/asistencia/AlumnoAsistenciaM.dart';
import 'package:plan/src/models/params/AsistenciaParam.dart';
import 'package:plan/src/providers/asistencia/AsistenciaPV.dart';
import 'package:plan/src/utils/AsistenciaComponentes.dart';
import 'package:plan/src/utils/MiThema.dart';
import 'package:plan/src/utils/Widgets.dart';

class AlumnosAsistenciaP extends StatefulWidget {
  
  @override
  _AlumnosAsistenciaPState createState() => _AlumnosAsistenciaPState();
}

class _AlumnosAsistenciaPState extends State<AlumnosAsistenciaP> {
  final apv = new AsistenciaPV();
  Future<List<AlumnoAsistenciaM>> alumnos;
  List<DropdownMenuItem<String>> opts;
  AsistenciaParam param; 

  TextStyle textSize = TextStyle(fontSize: 14);

  @override
  Widget build(BuildContext context) {

    if (alumnos == null) {
      param = ModalRoute.of(context).settings.arguments;
      alumnos = apv.getListado(
        param.curso.idCurso, 
        param.fecha
      );
      opts =getCmbFaltas(param.curso.horas??0);
    } 
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          param.curso.curso + ' | ' + 
          param.fecha
        ),
      ),
      body: _page(),
    );
  }

  Widget _page() {
    return Column(
      children: <Widget>[
        ctnInformacion(
          context, 
          param.curso.materia, 
          param.curso.periodo
        ),
        Expanded(
          child: _listaAlumnos(),
        )
      ],
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
          return cargando(context);
        }
      },
    );
  }

  Widget _alumno(AlumnoAsistenciaM a, int pos) {
    return ListTile(
      title: Text(a.alumno,),
      leading: CircleAvatar(
        child: Text((pos + 1).toString()),
      ),
      trailing: DropdownButton(
        value: a.numFalta.toString(),
        items: opts,
        onChanged: ((s) {
          setState(() {
            a.numFalta = int.parse(s);
            apv.actualizar(
              a.idAsistencia, 
              a.numFalta
            );
          });
        }),
      ),
      contentPadding: EdgeInsets.symmetric(
        vertical: 4.0, 
        horizontal: 7.0
      ),
    );
  }
  
}