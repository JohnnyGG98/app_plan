import 'package:flutter/material.dart';
import 'package:plan/src/pages/HomeP.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plan',
      initialRoute: '/',
      routes: {
        '/': (BuildContext ct) => HomeP(),
      },
    );
  }
}