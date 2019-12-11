import 'package:flutter/material.dart';
import 'package:plan/src/providers/ProviderI.dart';
import 'package:plan/src/providers/asistencia/AsistenciaOfflinePV.dart';

class SincronizandoP extends StatefulWidget {

  @override
  _SincronizandoPState createState() => _SincronizandoPState();
}

class _SincronizandoPState extends State<SincronizandoP> {
  final apv = new AsistenciaOfflinePV();

  Future<bool> subido; 

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    subido = apv.sincronizaAhora(bloc.usuario);
    return Scaffold(
      body: _descargando(),
    );
  }

  _btnBack(BuildContext context){
    return FlatButton(
      child: Text('Ok'),
      onPressed: (){
        Navigator.pop(context);
      },
    );
  }

  _template(String msg, Widget w) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(msg),
          SizedBox(height: 20,),
          Divider(),
          SizedBox(height: 20,),
          w
        ],
      ),
    );
  }

  _descargando(){
    return FutureBuilder(
      future: subido,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
        if (snapshot.hasData) {
          final res = snapshot.data;
          if (res) {
            return _template(
              'Subimos todas las asistencia correctamente.', 
              _btnBack(context)
            );
          }  else {
            return _template(
              'Error al subir la asistencia.', 
              _btnBack(context)
            );
          }
        } else {
          return _template(
            'Subiendo toda la asistencia...', 
            CircularProgressIndicator()
          );
        }
      },
    );
  }
}