import 'package:flutter/material.dart';
import 'package:plan/src/pages/AlumnoP.dart';
import 'package:plan/src/pages/CarreraP.dart';
import 'package:plan/src/pages/CursoP.dart';
import 'package:plan/src/pages/HomeP.dart';
import 'package:plan/src/pages/LoginP.dart';
import 'package:plan/src/pages/OfflineP.dart';
import 'package:plan/src/pages/PeriodoP.dart';
import 'package:plan/src/pages/SilaboP.dart';
import 'package:plan/src/pages/asistencia/AlumnosAsistenciaP.dart';
import 'package:plan/src/pages/asistencia/HomeAsistenciaOfflineP.dart';
import 'package:plan/src/providers/ProviderI.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PLAN',
        initialRoute: '/',
        routes: {
          '/': (BuildContext ct) => LoginPage(),
          'home': (BuildContext ct) => HomeP(),
          'carrera': (BuildContext ct) => CarreraP(),
          'periodo': (BuildContext ct) => PeriodoP(),
          'curso': (BuildContext ct) => CursoP(),
          'alumno': (BuildContext ct) => AlumnoP(),
          'alumnoCurso': (BuildContext ct) => AlumnoP.fromCurso(idCurso: 455,),
          'offline': (BuildContext ct) => OfflineP(),
          'silabo': (BuildContext ct) => SilaboP(),
          'listaasistencia':(BuildContext ct) => AlumnosAsistenciaP(),
          'cursosoffline': (BuildContext ct) => HomeAsistenciaOfflineP(),
        },
        theme: ThemeData(
          primaryColor: Colors.blueGrey
        ),
      ),
    );
  }
}

