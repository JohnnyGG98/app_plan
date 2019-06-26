import 'package:flutter/material.dart';

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
    );
  }
}