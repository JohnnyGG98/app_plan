import 'package:flutter/material.dart';

class MisWidgets {
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
}