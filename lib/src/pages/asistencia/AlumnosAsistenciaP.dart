import 'package:flutter/material.dart';
import 'package:plan/src/models/asistencia/AlumnoAsistenciaM.dart';
import 'package:plan/src/models/params/AsistenciaParam.dart';
import 'package:plan/src/providers/asistencia/AsistenciaPV.dart';
import 'package:plan/src/utils/MiThema.dart';
import 'package:plan/src/utils/Widgets.dart';
import 'package:spinner_input/spinner_input.dart';

class AlumnosAsistenciaP extends StatefulWidget {
  
  @override
  _AlumnosAsistenciaPState createState() => _AlumnosAsistenciaPState();
}

class _AlumnosAsistenciaPState extends State<AlumnosAsistenciaP> {
  final apv = new AsistenciaPV();
  Future<List<AlumnoAsistenciaM>> alumnos;
  AsistenciaParam param; 

  TextStyle textSize = TextStyle(fontSize: 14);

  double maxHoras = 0.0;

  @override
  Widget build(BuildContext context) {

    if (alumnos == null) {
      param = ModalRoute.of(context).settings.arguments;
      alumnos = apv.getListado(
        param.curso.idCurso, 
        param.fecha
      );
    }

    if (param.curso.horas != null) {
      maxHoras = double.parse(param.curso.horas.toString());
    } 
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          param.curso.curso + ' | ' + 
          param.fecha
        ),
      ),
      body: _page(),
    );
  }

  Widget _page() {
    return Column(
      children: <Widget>[
        ctnInformacion(
          context, 
          param.curso.materia, 
          param.curso.periodo
        ),
        ListTile(
          leading: Text('#'),
          title: Text('Alumno'),
          trailing: Text('Faltas',),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 25.0
          ),
        ),
        
        Expanded(
          child: _listaAlumnos(),
        )
      ],
    );
  }

  Widget _listaAlumnos(){
    return FutureBuilder(
      future: alumnos,
      builder: (BuildContext context, AsyncSnapshot<List<AlumnoAsistenciaM>> snapshot){
        if(snapshot.hasData){
          final als = snapshot.data;
          return ListView.builder(
            itemCount: als.length,
            itemBuilder: (BuildContext context, int i){
              return _alumno(als[i], i);
            },
            padding: EdgeInsets.only(bottom: 25.0),
          );
        }else{
          return cargando(context);
        }
      },
    );
  }

  Widget _alumno(AlumnoAsistenciaM a, int pos) {
    return ListTile(
      title: Text(a.alumno,),
      leading: CircleAvatar(
        child: Text((pos + 1).toString()),
      ),
      trailing: SpinnerInput(
        spinnerValue: double.parse(a.numFalta.toString()),
        minValue: 0.0,
        maxValue: maxHoras,
        onChange: (v){
          setState(() {
            a.numFalta = v.round();  
            apv.actualizar(
              a.idAsistencia, 
              a.numFalta
            );
          });
        },
        plusButton: SpinnerButtonStyle(color: Theme.of(context).primaryColorDark,),
        minusButton: SpinnerButtonStyle(color: Theme.of(context).primaryColor,),
        middleNumberPadding: EdgeInsets.symmetric(horizontal: 10.0),
      ),
      contentPadding: EdgeInsets.symmetric(
        vertical: 4.0, 
        horizontal: 7.0
      ),
    );
  }
  
}