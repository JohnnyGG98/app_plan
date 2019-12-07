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
  String mensajeFin = '';
  int numDescarga = 0;
  bool fin = false; 

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
             
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(mensajeFin),

                    fin ? 
                      FlatButton(
                      child: Icon(Icons.arrow_back_ios),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ) : 
                    FlatButton(
                    child: Icon(Icons.play_arrow),
                    onPressed: (){
                      setState(() {
                        numDescarga++;
                      });
                    }),
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
      mensajeFin = 'Descargamos todos sus cursos.';
      break; 
      case 1: 
      des = apv.descargarAlumnosDocente(identificacion);
      mensaje = 'Descargando alumnos...';
      mensajeFin = 'Descargamos todos sus alumnos.';
      break; 
      case 2: 
      des = fcpv.descargarFechas(identificacion);
      mensaje = 'Descargando fechas...';
      mensajeFin = 'Descargamos fechas correctamente.';
      break;
      default: 
      mensajeFin = 'Descargamos todo correctamente.';
      fin = true;
      break;
    }
  }

}