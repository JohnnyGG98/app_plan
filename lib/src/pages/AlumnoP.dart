import 'package:flutter/material.dart';
import 'package:plan/src/providers/AlumnoPV.dart';

class AlumnoP extends StatelessWidget {
  final almn = new AlumnoPV();
  final int idCurso;

  AlumnoP({this.idCurso = 0});

  AlumnoP.fromCurso({this.idCurso = 0});
  
  @override
  Widget build(BuildContext context) {
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
              return _carta(context, alumnos[i]);
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
              return _carta(context, alumnos[i]);
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

  Widget _carta(BuildContext ct, AlumnoM a) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(a.getUrlFoto()),
          ),
          title: Text(a.getNombreCompleto()),
          subtitle: Text(a.correo),
          onTap:() => _mostrarInformacionAlumno(ct, a),
        ),
      ),
    );
  }

  void _mostrarInformacionAlumno(BuildContext ct, AlumnoM a){
    showDialog(
      context: ct,
      barrierDismissible: true,
      builder: (context){
        return AlertDialog(
          title: Text('Informacion de: ${a.identificacion}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.network(a.getUrlFoto()),
              Divider(),
              _info('Cedula', a.identificacion),
              _info('Nombre', a.getNombreCompleto()),
              _info('Correo:', a.correo),
              _info('Celular', a.celular),
              _info('Telefono', a.telefono),

            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Salir'),
              onPressed: () {
                Navigator.of(context).pop();
              },
              color: Colors.black,
              textColor: Colors.white,
            ),
          ],
          backgroundColor: Colors.blueGrey,
        );
      }
    );
  } 

  Widget _info(String titulo, String descripcion){
    return Text('$titulo: $descripcion');
  }

}
