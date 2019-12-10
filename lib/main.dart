import 'package:flutter/material.dart';
import 'package:plan/src/pages/AlumnoP.dart';
import 'package:plan/src/pages/CarreraP.dart';
import 'package:plan/src/pages/CursoP.dart';
import 'package:plan/src/pages/HomeP.dart';
import 'package:plan/src/pages/LoginP.dart';
import 'package:plan/src/pages/OfflineP.dart';
import 'package:plan/src/pages/PeriodoP.dart';
import 'package:plan/src/pages/SilaboP.dart';
import 'package:plan/src/pages/asistencia/AlumnoAsistenciaOfflineP.dart';
import 'package:plan/src/pages/asistencia/AlumnosAsistenciaP.dart';
import 'package:plan/src/pages/asistencia/DescargaP.dart';
import 'package:plan/src/pages/asistencia/FechasOfflineP.dart';
import 'package:plan/src/pages/asistencia/FechasP.dart';
import 'package:plan/src/pages/asistencia/HomeAsistenciaOfflineP.dart';
import 'package:plan/src/pages/asistencia/SincronizandoP.dart';
import 'package:plan/src/providers/ProviderI.dart';
import 'package:plan/src/utils/PreferenciasUsuario.dart';

void main() async {
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  String _inicialRoute = '/';
  @override
  Widget build(BuildContext context) {
    //final bloc = Provider.of(context);
    final prefs = new PreferenciasUsuario();
    print('Usuario guardado: ' + prefs.username);
    if (prefs.username != '') {
      //bloc.changeUsuario(prefs.username);  
      //_inicialRoute = 'home';
    }

    return  Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PLAN',
        initialRoute: _inicialRoute,
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
          'descarga': (BuildContext ct) => DescargaP(),
          'asistenciaoffline': (BuildContext ct) => AlumnoAsistenciaOfflineP(),
          'fechasoffline': (BuildContext ct) => FechasOfflineP(),
          'fechas': (BuildContext ct) => FechasP(),
          'sincronizar': (BuildContext ct) => SincronizandoP(),
        },
        theme: ThemeData(
          primaryColor: Color.fromRGBO(10, 61, 98, 1.0),
          primaryColorDark: Color.fromRGBO(6, 40, 65, 1.0),

          
        ),
      ),
    );
  }
}

