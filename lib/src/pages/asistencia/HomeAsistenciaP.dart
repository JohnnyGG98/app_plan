import 'package:flutter/material.dart';
import 'package:plan/src/models/asistencia/CursoAsistenciaM.dart';
import 'package:plan/src/models/params/AsistenciaParam.dart';
import 'package:plan/src/providers/ProviderI.dart';
import 'package:plan/src/providers/asistencia/CursoAsistenciaPV.dart';
import 'package:plan/src/utils/AsistenciaComponentes.dart';

class HomeAsistenciaP extends StatefulWidget {
  @override
  _HomeAsistenciaPState createState() => _HomeAsistenciaPState();
}

class _HomeAsistenciaPState extends State<HomeAsistenciaP> {

  final CAPV = new CursoAsistenciaPV();
  Future<List<CursoAsistenciaM>> cursos;
  final fecha = new DateTime.now();

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
              return cartaCursosAsistenciaBtn(
                cs[i], 
                context,
                _btnDia(cs[i])
              );
            },
          );
        } else {
          return Center (child: CircularProgressIndicator(),);
        }
      },
    );
  }

  FlatButton _btnDia(CursoAsistenciaM c) {
    return FlatButton(
      child: Icon(Icons.format_list_numbered_rtl),
      onPressed: (){
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
    );
  }

}