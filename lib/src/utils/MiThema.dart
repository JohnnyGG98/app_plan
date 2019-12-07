
import 'package:flutter/material.dart';

TextStyle tituloInfo = TextStyle(
  fontSize: 16.0, 
  color: Colors.white
);

TextStyle _noData = TextStyle(
  fontSize: 25.0,
);

Center sinResultados = Center(
  child: Text('No encontramos resultados.', style: _noData,),
);

Widget cargando(BuildContext context) {
  return Center(
    child: CircularProgressIndicator(
      backgroundColor: Theme.of(context).primaryColorDark,
      semanticsLabel: 'Cargando...',
    ),
  );
}