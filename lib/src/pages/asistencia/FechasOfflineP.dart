import 'package:flutter/material.dart';
import 'package:plan/src/models/asistencia/CursoAsistenciaM.dart';
import 'package:plan/src/providers/asistencia/AsistenciaOfflinePV.dart';

class FechasOfflineP extends StatelessWidget {
  final apv = new AsistenciaOfflinePV();
  Future<List<String>> fechas; 
  CursoAsistenciaM curso; 

  @override
  Widget build(BuildContext context) {
    curso = ModalRoute.of(context).settings.arguments; 
    fechas = apv.getFechasCurso(curso.idCurso);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fechas ' + 
          curso.curso 
        ),
      ),
      body: _page(),
    );
  }

  Widget _page() {
    return FutureBuilder(
      future: fechas,
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.hasData) {
          final fs = snapshot.data;
          return ListView.builder(
            itemCount: fs.length,
            itemBuilder: (BuildContext context, int i) {
              return ListTile(
                title: Text(curso.materia),
                subtitle: Text(fs[i]),
                trailing: FlatButton(
                  child: Icon(
                    Icons.edit
                  ),
                  onPressed: (){
                    print('EDITAR');
                  },
                ),
              );
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

}