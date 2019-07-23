import 'package:flutter/material.dart';
import 'package:plan/src/providers/CarreraPV.dart';

class CarreraP extends StatelessWidget {
  final carreras = new CarreraPV();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carreras'),
        backgroundColor: Colors.green,
      ),
      body: _listaCarreras(),
    );
  }

  Widget _listaCarreras() {
    return FutureBuilder(
      future: carreras.getTodos(),
      builder: (BuildContext context, AsyncSnapshot<List<CarreraM>> snapshot){
        if(snapshot.hasData){
          final cars = snapshot.data;
          return ListView.builder(
            itemCount: cars.length,
            itemBuilder: (BuildContext context, int i){
              return Card(
                child: ListTile(
                  title: Text('${cars[i].nombre}'),
                  subtitle: Text('${cars[i].codigo}'),
                )
              );
            },
          );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}