import 'package:flutter/material.dart';
import 'package:plan/src/providers/CursoPV.dart';

class CursoP extends StatelessWidget {
  final cur = new CursoPV();

  @override
  Widget build(BuildContext context) {
    final List param = ModalRoute.of(context).settings.arguments;
    //Titulo de la pagina
    String titulo = '';
    //Aqui cargaremos todos los cursos
    Future<List<CursoM>> cursos;
    switch(param[0]){
      case 'buscar': {
        //print('Estamos buscandoo: '+param[1].toString());
        cursos = cur.buscar(param[1].toString().replaceAll(' ', ''));
        titulo = 'Buscar Curso: '+param[1].toString();
      }
      break;
      case 'curso': {
        //print('Buscaremos por curso: '+param[1]);
        cursos = cur.getPorIdCurso(int.parse(param[1].toString()));
        titulo = 'Curso: '+param[1].toString();
      }
      break;
      case 'nombre': {
        //print('Buscaremos por nombre: '+param[1]);
        cursos = cur.getPorNombreCursoPeriodo(param[1].toString());
        titulo = 'Nombre Curso: '+param[1].toString().split('-')[0];
      }
      break;
      case 'periodo': {
        //print('Buscaremos por periodo: '+param[1]);
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
        backgroundColor: Colors.blueGrey,
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
    TextStyle s = TextStyle(
      fontSize: 20.0
    );
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
                ],
              )
              
            ),
            Column(
              children: <Widget>[
                FlatButton(
                  child: Icon(Icons.school),
                  onPressed: (){
                    print(c.idCurso);
                    Navigator.pushNamed(context, 'alumno', arguments: c.idCurso);
                  },
                ),
                FlatButton(
                  child: Icon(Icons.book),
                  onPressed: (){
                    print(c.idMateria.toString()+' '+c.idPeriodo.toString());
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