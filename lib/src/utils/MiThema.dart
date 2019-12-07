
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

Icon dropDown = Icon(
  Icons.arrow_drop_down,
  color: Color.fromRGBO(6, 40, 65, 1.0),
  size: 40.0,
);

Widget cargando(BuildContext context) {
  return Center(
    child: CircularProgressIndicator(
      semanticsLabel: 'Cargando...',
      valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
    ),
  );
}