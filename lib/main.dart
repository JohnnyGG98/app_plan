import 'package:flutter/material.dart';
import 'package:plan/src/pages/CarreraP.dart';
import 'package:plan/src/pages/HomeP.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Plan',
      initialRoute: 'carrera',
      routes: {
        '/': (BuildContext ct) => HomeP(),
        'carrera': (BuildContext ct) => CarreraP(),
      },
    );
  }
}

