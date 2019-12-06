import 'package:flutter/material.dart';
import 'package:plan/src/models/asistencia/CursoAsistenciaM.dart';
import 'package:plan/src/models/params/AsistenciaParam.dart';
import 'package:plan/src/providers/asistencia/AsistenciaOfflinePV.dart';

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
              return _carta(cs[i], context);
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}