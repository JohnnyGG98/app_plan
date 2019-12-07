import 'package:flutter/material.dart';
import 'package:plan/src/models/asistencia/CursoAsistenciaM.dart';
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
              return cartaCursosAsistencia(
                cs[i], 
                context,
                'listaasistencia',
                'fechas'
              );
            },
          );
        } else {
          return Center (child: CircularProgressIndicator(),);
        }
      },
    );
  }

}