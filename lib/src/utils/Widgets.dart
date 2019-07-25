import 'package:flutter/material.dart';

class MisWidgets {

  static const stlTxtTituloCard = TextStyle(
    color: Colors.black,
    fontSize: 20.0,
    fontWeight: FontWeight.w600
  );

  static const stlTxtDescripcionCard = TextStyle(
    color: Colors.black,
    fontSize: 18.0
  );

  static Widget cargando(String msg){
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(height: 15.0,),
          Text(msg)
        ],
      ),
    );
  }

  static Widget info(String titulo, String descripcion){
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(titulo, style: stlTxtTituloCard,),
        SizedBox(height: 5.0,),
        Text(descripcion, style: stlTxtDescripcionCard,),
        SizedBox(height: 5.0,),
      ],
    );
  }
}