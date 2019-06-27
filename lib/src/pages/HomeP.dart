import 'package:flutter/material.dart';
import 'package:plan/src/providers/CarreraPV.dart';

class HomeP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
        backgroundColor: Colors.black87,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              print("Estamos buscado");
            },
          )
        ],
      ),
      body: Center(
        child: Text('Hola Mundo'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          print('Si funciona el boton');
          
            final car = CarreraPV();
            car.getTodos(); 
        },
      ),
    );
  }

}