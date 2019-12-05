import 'package:flutter/material.dart';
import 'package:plan/src/models/asistencia/AlumnoAsistenciaM.dart';
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

  @override
  Widget build(BuildContext context) {

    if (alumnos == null) {
      final int idCurso = ModalRoute.of(context).settings.arguments;
      alumnos = APV.getListado(idCurso, fecha.day.toString() + '/' + fecha.month.toString() + '/' + fecha.year.toString());
      opts = _getFaltas(5);
    } 
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Listado alumnos '),
      ),
      body: _listaAlumnos(alumnos),
    );
  }

  Widget _listaAlumnos(Future<List<AlumnoAsistenciaM>> alumnos){
    return FutureBuilder(
      future: alumnos,
      builder: (BuildContext context, AsyncSnapshot<List<AlumnoAsistenciaM>> snapshot){
        if(snapshot.hasData){
          final als = snapshot.data;
          return ListView.builder(
            itemCount: als.length,
            itemBuilder: (BuildContext context, int i){
              return Card(
                child: ListTile(
                  title: Text(als[i].alumno),
                  trailing: DropdownButton(
                    value: als[i].numFalta.toString(),
                    items: opts,
                    onChanged: ((s) {
                      setState(() {
                        als[i].numFalta = int.parse(s);
                        print('FALTAAAAA');
                        APV.actualizar(als[i].idAsistencia, als[i].numFalta);
                      });
                    }),

                  ),
                ),
              );
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
}