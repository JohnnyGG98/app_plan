import 'package:flutter/material.dart';
import 'package:plan/src/models/asistencia/AlumnoAsistenciaM.dart';
import 'package:plan/src/models/asistencia/CursoAsistenciaM.dart';
import 'package:plan/src/providers/asistencia/AsistenciaPV.dart';

class AlumnosAsistenciaP extends StatefulWidget {
  
  @override
  _AlumnosAsistenciaPState createState() => _AlumnosAsistenciaPState();
}

class _AlumnosAsistenciaPState extends State<AlumnosAsistenciaP> {
  final APV = new AsistenciaPV();
  Future<List<AlumnoAsistenciaM>> alumnos;
  final fecha = new DateTime.now();
  List<DropdownMenuItem<String>> opts;
  CursoAsistenciaM curso; 

  @override
  Widget build(BuildContext context) {

    if (alumnos == null) {
      curso = ModalRoute.of(context).settings.arguments;
      alumnos = APV.getListado(
        curso.idCurso, 
        fecha.day.toString() + '/' + 
        fecha.month.toString() + '/' + 
        fecha.year.toString()
      );
      opts = _getFaltas(curso.horas);
    } 
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Listado alumnos '),
      ),
      body: _page(),
    );
  }

  Widget _page() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 2.0,
        vertical: 3.0
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ListTile(
            title: Text(
              curso.materia + ' ' + 
              curso.curso
            ),
            leading: CircleAvatar(
              child: Text(curso.horas.toString()),
              backgroundColor: Colors.blueGrey,
            ),
          ),

          SizedBox(height: 5),
          _listaAlumnos(),
        ],
      ),
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

  List<DropdownMenuItem<String>> _getFaltas(int limite) {
    List<DropdownMenuItem<String>> opts = new List();
    opts.add(
      DropdownMenuItem(
         child: Text('Horas'),
         value: '0',
      )
    );

    for(var i = 1; i <= limite; i++) {
      opts.add(
        DropdownMenuItem(
          child: Text(i.toString() + ' Hora'),
          value: i.toString(),
        )
      );
    }
    return opts;
  }

  Widget _alumno(AlumnoAsistenciaM a) {
    return Card(
      child: ListTile(
        title: Text(a.alumno),
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
      ),
    );
  }
}