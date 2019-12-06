import 'package:flutter/material.dart';
import 'package:plan/src/providers/ProviderI.dart';
import 'package:plan/src/providers/asistencia/AsistenciaOfflinePV.dart';

class DescargaP extends StatelessWidget {

  Future<bool> des;
  final apv = new AsistenciaOfflinePV();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    des = apv.descargarCursosDocente(bloc.usuario);

    return Scaffold(
      body: FutureBuilder(
        future: des,
        builder:(BuildContext context, AsyncSnapshot<bool> snapshot){
          if (snapshot.hasData) {
            final res = snapshot.data;
            if (res) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Descargamos todo correctamente.'),

                    FlatButton(
                      child: Icon(Icons.arrow_back_ios),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),

                  ],
                ),
              );
            } else {
              return Center(
                child: Text('Tuvimos un error al descargar los cursos vuelvalo a intentar mas tarde.'),
              );
            }
          } else {
            return Center (
              child: CircularProgressIndicator()
            );
          }
        },
      ),
    );
  }
}