import 'package:flutter/material.dart';
import 'package:plan/src/pages/AlumnoP.dart';
import 'package:plan/src/pages/CarreraP.dart';
import 'package:plan/src/pages/CursoP.dart';
import 'package:plan/src/pages/HomeP.dart';
import 'package:plan/src/pages/PeriodoP.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PLAN',
      initialRoute: 'alumno',
      routes: {
        '/': (BuildContext ct) => HomeP(),
        'carrera': (BuildContext ct) => CarreraP(),
        'periodo': (BuildContext ct) => PeriodoP(),
        'curso': (BuildContext ct) => CursoP(),
        'alumno': (BuildContext ct) => AlumnoP(),
        'alumnoCurso': (BuildContext ct) => AlumnoP.fromCurso(idCurso: 455,),
      },
    );
  }
}

