import 'package:flutter/material.dart';
import 'package:plan/src/models/asistencia/CursoAsistenciaM.dart';
import 'package:plan/src/models/params/AsistenciaParam.dart';
import 'package:plan/src/providers/asistencia/AsistenciaOfflinePV.dart';
import 'package:plan/src/utils/AsistenciaComponentes.dart';

class HomeAsistenciaOfflineP extends StatefulWidget {

  _HomeAsistenciaOfflinePState createState() => _HomeAsistenciaOfflinePState();
}

class _HomeAsistenciaOfflinePState extends State<HomeAsistenciaOfflineP> {
  // Provider  
  final apv = new AsistenciaOfflinePV();
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
      case 0: return _lista(cursosDia);
      case 1: return _lista(cursos);
      default: 
      return _lista(cursosDia);
    }
  }

  Widget _lista(Future<List<CursoAsistenciaM>> cursos) {
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
                'asistenciaoffline',
                'fechasoffline'
              );
            },
          );
        } else {
          return Center (child: CircularProgressIndicator(),);
        }
      },
    );
  }

  Widget _crearBarra() {
    return BottomNavigationBar(
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