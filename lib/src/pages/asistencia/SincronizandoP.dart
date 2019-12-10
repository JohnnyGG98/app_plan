import 'package:flutter/material.dart';
import 'package:plan/src/providers/ProviderI.dart';
import 'package:plan/src/providers/asistencia/AsistenciaOfflinePV.dart';

class SincronizandoP extends StatefulWidget {

  @override
  _SincronizandoPState createState() => _SincronizandoPState();
}

class _SincronizandoPState extends State<SincronizandoP> {
  final apv = new AsistenciaOfflinePV();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return Stack(
      children: <Widget>[
        _fondo(),
        _descargando(bloc.usuario)
      ],
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

  _btnReload(BuildContext context) {
    return FlatButton(
      child: Text('Reintentar'),
      onPressed: (){
        setState(() {});
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
          Divider(),
          w
        ],
      ),
    );
  }

  _fondo() {
    return Container(
      color: Colors.brown,
    );
  }

  _descargando(String docente){
    return FutureBuilder(
      future: apv.sincronizar(docente),
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
              _btnReload(context)
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