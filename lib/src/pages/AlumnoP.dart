import 'package:flutter/material.dart';
import 'package:plan/src/providers/AlumnoPV.dart';

class AlumnoP extends StatelessWidget {
  final almn = new AlumnoPV();
  final int idCurso;

  AlumnoP({this.idCurso = 0});

  AlumnoP.fromCurso({this.idCurso = 0});
  
  @override
  Widget build(BuildContext context) {
    /*print('Este es el id: ' + idCurso.toString());*/
    final idCurso = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Alumnos'),
        backgroundColor: Colors.blueGrey,
      ),
      body: _cargarAlumnos(idCurso),
    );
  }

  Widget _cargarAlumnos(int idCurso){
    if(idCurso != 0){
      return _listaAlumosCurso(idCurso);
    }else{
      return _listaAlumos();
    }
  }

  Widget _listaAlumos() {
    return FutureBuilder(
      future: almn.getTodos(),
      builder: (BuildContext context, AsyncSnapshot<List<AlumnoM>> snapshot) {
        if (snapshot.hasData) {
          final alumnos = snapshot.data;
          return ListView.builder(
            itemCount: alumnos.length,
            itemBuilder: (BuildContext context, int i) {
              return _carta(alumnos[i]);
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  
  Widget _listaAlumosCurso(int idCurso) {
    return FutureBuilder(
      future: almn.getPorCurso(idCurso),
      builder: (BuildContext context, AsyncSnapshot<List<AlumnoM>> snapshot) {
        if (snapshot.hasData) {
          final alumnos = snapshot.data;
          return ListView.builder(
            itemCount: alumnos.length,
            itemBuilder: (BuildContext context, int i) {
              return _carta(alumnos[i]);
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _carta(AlumnoM a) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: ListTile(
          title: Text(a.getNombreCompleto()),
          subtitle: Text(a.correo),
        ),
      ),
    );
  }
}
