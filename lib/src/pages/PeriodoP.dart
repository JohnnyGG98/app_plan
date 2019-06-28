import 'package:flutter/material.dart';
import 'package:plan/src/models/PeriodoM.dart';
import 'package:plan/src/providers/PeriodoPV.dart';

class PeriodoP extends StatelessWidget {
  final prd = new PeriodoPV();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Periodos'),
        backgroundColor: Colors.blueGrey,
      ),
      body: _listaPeriodos(),
    );
  }

  Widget _listaPeriodos() {
    return FutureBuilder(
      future: prd.getTodos(),
      builder: (BuildContext context, AsyncSnapshot<List<PeriodoM>> snapshot){
        if(snapshot.hasData){
          final pers = snapshot.data;
          return ListView.builder(
            itemCount: pers.length,
            itemBuilder: (BuildContext context, int i){
              return Card(
                child: ListTile(
                  title: Text('${pers[i].nombre}'),
                  subtitle: Text('${pers[i].id}'),
                ),
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