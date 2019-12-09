import 'package:flutter/material.dart';
import 'package:plan/src/models/asistencia/CursoAsistenciaM.dart';
import 'package:plan/src/models/params/AsistenciaParam.dart';
import 'package:plan/src/providers/ProviderI.dart';
import 'package:plan/src/providers/asistencia/CursoAsistenciaPV.dart';
import 'package:plan/src/utils/AsistenciaComponentes.dart';
import 'package:plan/src/utils/MiThema.dart';
import 'package:plan/src/utils/Widgets.dart';

class HomeAsistenciaP extends StatefulWidget {
  @override
  _HomeAsistenciaPState createState() => _HomeAsistenciaPState();
}

class _HomeAsistenciaPState extends State<HomeAsistenciaP> {

  final capv = new CursoAsistenciaPV();
  Future<List<CursoAsistenciaM>> cursos, cursosTodos;
  final fecha = new DateTime.now();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    print('Usuario logeado ${bloc.usuario}');

    if (cursos == null) {
      cursos = capv.getPorDia(bloc.usuario);
    }

    if (cursosTodos == null) {
      cursosTodos = capv.getTodos(bloc.usuario);
    }
    return _tabBar();
  }

  Widget _getTabIcon(String titulo, IconData icon) {
    return Tab(
      child: ListTile(
        title: Text(titulo, style: TextStyle(color: Colors.white),),
        leading: Icon(icon, color: Colors.white,),
      ),
    );
  }


  Widget _tabBar() {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Asistencia'),
          bottom: TabBar(
            
            tabs: [
              _getTabIcon('Día', Icons.today),
              _getTabIcon('Todos', Icons.calendar_today),
            ],
          ),
        ),

        drawer: crearMenuLateral(context),

        body: TabBarView(
          children: [
            _cursosDia(),
            _cursosTodos(),
          ],
        ),
      ),
    );
  }

  Widget _cursosDia() {
    return FutureBuilder(
      future: cursos,
      builder:(BuildContext context, AsyncSnapshot<List<CursoAsistenciaM>> snapshot){
        if (snapshot.hasData) {
          final cs = snapshot.data;
          if (cs.length > 0) {
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
            return sinResultados;
          }
        } else {
          return cargando(context);
        }
      },
    );
  }

  Widget _cursosTodos() {
    return FutureBuilder(
      future: cursosTodos,
      builder:(BuildContext context, AsyncSnapshot<List<CursoAsistenciaM>> snapshot){
        if (snapshot.hasData) {
          final cs = snapshot.data;
          if (cs.length > 0) {
            return ListView.builder(
              itemCount: cs.length,
              itemBuilder: (BuildContext context, int i){
                return cartaCursosAsistenciaBtn(
                  cs[i], 
                  context,
                  _btnFechas(cs[i])
                );
              },
            );
          } else {
            return sinResultados;
          }
        } else {
          return cargando(context);
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

  FlatButton _btnFechas(CursoAsistenciaM c) {
    return FlatButton(
      child: Icon(Icons.calendar_today),
      onPressed: (){
        Navigator.pushNamed(
          context,
          'fechas',
          arguments: c
        );
      },
    );
  }

}