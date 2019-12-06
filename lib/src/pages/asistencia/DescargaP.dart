import 'package:flutter/material.dart';
import 'package:plan/src/providers/ProviderI.dart';
import 'package:plan/src/providers/asistencia/AsistenciaOfflinePV.dart';
import 'package:plan/src/providers/asistencia/FechasClasePV.dart';

class DescargaP extends StatefulWidget {

  @override
  _DescargaPState createState() => _DescargaPState();
}

class _DescargaPState extends State<DescargaP> {
  Future<bool> des;

  final apv = new AsistenciaOfflinePV();
  final fcpv = new FechasClasePV();

  String mensaje = '';
  int numDescarga = 0;

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    descargar(bloc.usuario);

    return Scaffold(
      body: FutureBuilder(
        future: des,
        builder:(BuildContext context, AsyncSnapshot<bool> snapshot){
          if (snapshot.hasData) {
            final res = snapshot.data;
            if (res) {

              setState(() {
                numDescarga++;
              });

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
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(height: 15,),
                  Text(mensaje),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  descargar(String identificacion) async {
    switch(numDescarga) {
      case 0: 
      des = apv.descargarCursosDocente(identificacion);
      mensaje = 'Descargando cursos...';
      break; 
      case 1: 
      des = apv.descargarAlumnosDocente(identificacion);
      mensaje = 'Descargando alumnos...';
      break; 
      case 2: 
      des = fcpv.descargarFechas(identificacion);
      mensaje = 'Descargando fechas...';
      break;
      default: 
      des = await Future.delayed(
        Duration(seconds: 2)
      );
      mensaje = 'Descargando...';
      break;
    }
  }

}