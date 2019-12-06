import 'package:flutter/material.dart';
import 'package:plan/src/models/asistencia/CursoAsistenciaM.dart';
import 'package:plan/src/models/params/AsistenciaParam.dart';
import 'package:plan/src/providers/ProviderI.dart';
import 'package:plan/src/providers/asistencia/CursoAsistenciaPV.dart';

class HomeAsistenciaP extends StatefulWidget {
  @override
  _HomeAsistenciaPState createState() => _HomeAsistenciaPState();
}

class _HomeAsistenciaPState extends State<HomeAsistenciaP> {

  final CAPV = new CursoAsistenciaPV();
  final fecha = new DateTime.now();
  Future<List<CursoAsistenciaM>> cursos;

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    print('Usuario logeado ${bloc.usuario}');
    
    cursos = CAPV.getPorDia(bloc.usuario);

    return Scaffold(
      body: _page(),
    );
  }

  Widget _page() {
    return FutureBuilder(
      future: cursos,
      builder:(BuildContext context, AsyncSnapshot<List<CursoAsistenciaM>> snapshot){
        if (snapshot.hasData) {
          final cs = snapshot.data;
          return ListView.builder(
            itemCount: cs.length,
            itemBuilder: (BuildContext context, int i){
              return _carta(cs[i], context);
            },
          );
        } else {
          return Center (child: CircularProgressIndicator(),);
        }
      },
    );
  }

  Widget _carta(CursoAsistenciaM c, BuildContext context){
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
                  Text(c.materia, style: s,),
                  Text(c.periodo),       
                  Text(c.curso),
                ],
              )
              
            ),
            Column(
              children: <Widget>[
                FlatButton(
                  child: Icon(Icons.format_list_numbered_rtl),
                  onPressed: (){
                    print('Id Curso: ' + c.idCurso.toString());
                    AsistenciaParam asistencia = AsistenciaParam();
                    asistencia.curso = c;
                    asistencia.fecha = fecha.day.toString() + '/' + 
                      fecha.month.toString() + '/' + 
                      fecha.year.toString();
                    Navigator.pushNamed(
                      context,
                      'listaasistencia',
                      arguments: asistencia
                    );
                  },
                ),
                FlatButton(
                  child: Icon(Icons.calendar_today),
                  onPressed: (){
                    print('Id Curso' + c.idCurso.toString());
                    Navigator.pushNamed(
                      context,
                      'listaasistencia',
                      arguments: c
                    );
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