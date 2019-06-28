import 'package:flutter/material.dart';
import 'package:plan/src/pages/CarreraP.dart';
import 'package:plan/src/pages/HomeP.dart';
import 'package:plan/src/pages/PeriodoP.dart';
import 'package:plan/src/pages/SilaboP.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'carrera',
      initialRoute: '/',
      routes: {
        '/': (BuildContext ct) => HomeP(),
        'carrera': (BuildContext ct) => CarreraP(),
        'periodo': (BuildContext ct) => PeriodoP(),
        'silabo' : (BuildContext ct) => SilaboP(),
      },
    );
  }
}

