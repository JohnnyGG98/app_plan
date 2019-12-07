import 'package:flutter/material.dart';
import 'package:plan/src/models/asistencia/CursoAsistenciaM.dart';
import 'package:plan/src/models/params/AsistenciaParam.dart';

List<DropdownMenuItem<String>> getCmbFaltas(int limite) {
  List<DropdownMenuItem<String>> opts = new List();
  opts.add(
    DropdownMenuItem(
        child: Text('Horas'),
        value: '0',
    )
  );

  for(var i = 1; i <= limite; i++) {
    opts.add(
      DropdownMenuItem(
        child: Text(i.toString() + ' Hora'),
        value: i.toString(),
      )
    );
  }
  return opts;
}

// Duplicado de la clase home asistencia  
  Widget cartaCursosAsistencia(
    CursoAsistenciaM c, 
    BuildContext context,
    String rutaBtnUno,
    String rutaBtnDos
  ){
    final fecha = new DateTime.now();
    TextStyle s = TextStyle(
      fontSize: 20.0
    );
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(
          top: 5.0,
          right: 5.0,
          left: 15.0,
          bottom: 10.0
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(c.materia, style: s,),
                  Text(c.periodo),       
                  Text(c.curso),
                ],
              )
              
            ),
            Column(
              children: <Widget>[
                FlatButton(
                  child: Icon(Icons.format_list_numbered_rtl),
                  onPressed: (){
                    AsistenciaParam asistencia = AsistenciaParam();
                    asistencia.curso = c;
                    asistencia.fecha = fecha.day.toString() + '/' + 
                      fecha.month.toString() + '/' + 
                      fecha.year.toString();
                    Navigator.pushNamed(
                      context,
                      rutaBtnUno,
                      arguments: asistencia
                    );
                  },
                ),

                FlatButton(
                  child: Icon(Icons.calendar_today),
                  onPressed: (){
                    Navigator.pushNamed(
                      context,
                      rutaBtnDos,
                      arguments: c
                    );
                  },
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }