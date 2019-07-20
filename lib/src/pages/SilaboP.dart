import 'package:flutter/material.dart';
import 'package:plan/src/models/SilaboM.dart';
import 'package:plan/src/providers/SilaboPV.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_plugin.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';

class SilaboP extends StatelessWidget {
  final silabos = new SilaboPV();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Silabos'),
        backgroundColor: Colors.green,
      ),
      body: _listaSilabos(),
    );
  }

  Widget _listaSilabos() {
    return FutureBuilder(
      future: silabos.getTodos(),
      builder: (BuildContext context, AsyncSnapshot<List<SilaboM>> snapshot){
        if(snapshot.hasData){
          final slbs = snapshot.data;
          return ListView.builder(
            itemCount: slbs.length,
            itemBuilder: (BuildContext context, int i){
              return Card(
                child: ListTile(
                  title: Text('${slbs[i].materiaNombre}'),
                  subtitle: Text('${slbs[i].prdLectivoNombre}'),
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