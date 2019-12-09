import 'package:flutter/material.dart';
import 'package:plan/src/providers/CursoPV.dart';

class CursoP extends StatelessWidget {
  final cur = new CursoPV();
  TextStyle s = TextStyle(fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    final List param = ModalRoute.of(context).settings.arguments;
    String titulo = '';
    Future<List<CursoM>> cursos;
    switch(param[0]){
      case 'buscar': {
        cursos = cur.buscar(param[1].toString().replaceAll(' ', ''));
        titulo = 'Buscar Curso: '+param[1].toString();
      }
      break;
      case 'curso': {
        cursos = cur.getPorIdCurso(int.parse(param[1].toString()));
        titulo = 'Curso: '+param[1].toString();
      }
      break;
      case 'nombre': {
        cursos = cur.getPorNombreCursoPeriodo(param[1].toString());
        titulo = 'Nombre Curso: '+param[1].toString().split('-')[0];
      }
      break;
      case 'periodo': {
        cursos = cur.getPorPeriodo(int.parse(param[1].toString()));
        titulo = 'Periodo Curso: '+param[1].toString();
      }
      break;
      default: {
        cursos = cur.getTodos();
      }
      break;
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
      ),
      body: _listaCursos(cursos),
    );
  }

  Widget _listaCursos(Future<List<CursoM>> cursos){
    return FutureBuilder(
      future: cursos,
      builder: (BuildContext context, AsyncSnapshot<List<CursoM>> snapshot){
        if(snapshot.hasData){
          final crs = snapshot.data;
          return ListView.builder(
            itemCount: crs.length,
            itemBuilder: (BuildContext context, int i){
              return _carta(crs[i], context);
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

  Widget _carta(CursoM c, BuildContext context){
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(
          top: 5.0,
          right: 5.0,
          left: 15.0,
          bottom: 10.0
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(c.getDocente(), style: s,),
                  Text(c.periodoNombre),               Text(c.materiaNombre, style: s,),
                  Text(c.nombre),
                  Divider()
                ],
              )
              
            ),
            Column(
              children: <Widget>[
                FlatButton(
                  child: Icon(Icons.school),
                  onPressed: (){
                    Navigator.pushNamed(context, 'alumno', arguments: c.idCurso);
                  },
                ),
                FlatButton(
                  child: Icon(Icons.picture_as_pdf,),
                  onPressed: (){
                    Navigator.pushNamed(context, 'silabo', arguments: ['curso', c.idCurso.toString()] );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

}