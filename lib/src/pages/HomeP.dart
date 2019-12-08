import 'package:flutter/material.dart';
import 'package:plan/src/pages/asistencia/HomeAsistenciaP.dart';
import 'package:plan/src/pages/cursos/HomeCursoP.dart';

class HomeP extends StatefulWidget {
  @override
  _HomePState createState() => _HomePState();
}

class _HomePState extends State<HomeP> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plan'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          )
        ],
      ),

      body: _cargarPagina(currentIndex),
      bottomNavigationBar: _crearBarra(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.cloud_off),
        onPressed: (){
          Navigator.pushNamed(context, 'offline');
        },
      ),
    );
  }

  Widget _cargarPagina(int pagActual) {
    switch(pagActual){
      case 0: return HomeAsistenciaP();
      case 1: return HomeCursoP();

      default:
      return HomeAsistenciaP();
    }
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
          icon: Icon(Icons.list),
          title: Text('Asistencia')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.class_),
          title: Text('Cursos')
        )
      ],

    );
  }

}