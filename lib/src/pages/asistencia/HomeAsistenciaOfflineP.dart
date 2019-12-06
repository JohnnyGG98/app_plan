import 'package:flutter/material.dart';
import 'package:plan/src/models/asistencia/CursoAsistenciaM.dart';
import 'package:plan/src/providers/asistencia/AsistenciaOfflinePV.dart';

class HomeAsistenciaOfflineP extends StatefulWidget {

  _HomeAsistenciaOfflinePState createState() => _HomeAsistenciaOfflinePState();
}

class _HomeAsistenciaOfflinePState extends State<HomeAsistenciaOfflineP> {
  // Provider  
  final apv = new AsistenciaOfflinePV();
  int currentIndex = 0;

  Future<List<CursoAsistenciaM>> cursosDia, cursos; 

  Future<bool> des;
 
  @override
  Widget build(BuildContext context) {

    if (currentIndex == 0 && cursosDia == null) {
      cursosDia = apv.getCursosPorDia();
    }

    if (currentIndex != 0 && cursos == null) {
      cursos = apv.getCursosAll();
    }

    return Scaffold(
      body: _cargarPagina(currentIndex),
      bottomNavigationBar: _crearBarra(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.cloud_download),
        onPressed: () {
          setState(() {
            currentIndex = 3;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _cargarPagina(int pagActual) {
    switch(pagActual) {
      case 0: return _lista(cursosDia);
      case 1: return _lista(cursos);
      case 3: return _descargando();
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
              return _carta(cs[i], context);
            },
          );
        } else {
          return Center (child: CircularProgressIndicator(),);
        }
      },
    );
  }

  Widget _descargando() {
    
    return FutureBuilder(
      future: des,
      builder:(BuildContext context, AsyncSnapshot<bool> snapshot){
        if (snapshot.hasData) {
          final res = snapshot.data;
          if (res) {

            cursos = null; 
            cursosDia = null;

            return Center(
              child: Column(
                children: <Widget>[
                  Text('Descargamos todo correctamente.')
                ],
              ),
            );
          } else {
            return Center(
              child: Text('Tuvimos un error al descargar los cursos vuelvalo a intentar mas tarde.'),
            );
          }
        } else {
          return Center (
            child: CircularProgressIndicator()
          );
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

  // Duplicado de la clase home asistencia  
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
                    Navigator.pushNamed(
                      context,
                      'listaasistencia',
                      arguments: c
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