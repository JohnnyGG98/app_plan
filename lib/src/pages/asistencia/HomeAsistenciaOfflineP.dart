import 'package:flutter/material.dart';
import 'package:plan/src/models/asistencia/CursoAsistenciaM.dart';
import 'package:plan/src/models/params/AsistenciaParam.dart';
import 'package:plan/src/providers/asistencia/AsistenciaOfflinePV.dart';
import 'package:plan/src/utils/AsistenciaComponentes.dart';
import 'package:plan/src/utils/MiThema.dart';
import 'package:plan/src/utils/Widgets.dart';

class HomeAsistenciaOfflineP extends StatefulWidget {

  _HomeAsistenciaOfflinePState createState() => _HomeAsistenciaOfflinePState();
}

class _HomeAsistenciaOfflinePState extends State<HomeAsistenciaOfflineP> {
  // Provider  
  final apv = new AsistenciaOfflinePV();
  final fecha = new DateTime.now();
  int currentIndex = 0;
  Future<List<CursoAsistenciaM>> cursosDia, cursos; 
 
  @override
  Widget build(BuildContext context) {

    if (currentIndex == 0 && cursosDia == null) {
      cursosDia = apv.getCursosPorDia();
    }

    if (currentIndex != 0 && cursos == null) {
      cursos = apv.getCursosAll();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Asistencia Offline'),
      ),

      drawer: crearMenuLateral(context),
      
      body: _cargarPagina(currentIndex),
      bottomNavigationBar: _crearBarra(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.cloud_download),
        onPressed: () {
          Navigator.pushNamed(context, 'descarga');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _cargarPagina(int pagActual) {
    switch(pagActual) {
      case 0: return _listaDia(cursosDia);
      case 1: return _listaFechas(cursos);
      default: 
      return _listaFechas(cursos);
    }
  }

  FlatButton _btnFechas(CursoAsistenciaM c) {
    return FlatButton(
      child: Icon(
        Icons.calendar_today,
        color: Theme.of(context).primaryColorDark,
      ),
      onPressed: (){
        Navigator.pushNamed(
          context,
          'fechasoffline',
          arguments: c
        );
      },
    );
  }

  FlatButton _btnDia(CursoAsistenciaM c) {
    return FlatButton(
      child: Icon(
        Icons.format_list_numbered_rtl,
        color: Theme.of(context).primaryColorDark,
      ),
      onPressed: (){
        AsistenciaParam asistencia = AsistenciaParam();
        asistencia.curso = c;
        asistencia.fecha = fecha.day.toString() + '/' + 
          fecha.month.toString() + '/' + 
          fecha.year.toString();
        Navigator.pushNamed(
          context,
          'asistenciaoffline',
          arguments: asistencia
        );
      },
    );
  }

  Widget _listaDia(Future<List<CursoAsistenciaM>> cursos) {
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

  Widget _listaFechas(Future<List<CursoAsistenciaM>> cursos) {
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

  Widget _crearBarra() {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).primaryColorDark,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white60,
      currentIndex: currentIndex,
      onTap: (index){
        setState(() {
          currentIndex = index;          
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.today),
          title: Text('Dia')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          title: Text('Todos')
        )
      ],
    );
  }

}