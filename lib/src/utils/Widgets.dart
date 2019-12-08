import 'dart:math';

import 'package:flutter/material.dart';
import 'package:plan/src/providers/ProviderI.dart';
import 'package:plan/src/utils/MiThema.dart';

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
    return Center(
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

void mostrarError(BuildContext context, String msg) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Error'),
        content: Text(msg),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      );
    }
  );
}


Drawer crearMenuLateral(BuildContext context) {
  final bloc = Provider.of(context);
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Menu',
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                  ),
                ),
                Divider(
                  color: Colors.white,
                ),
                Text(
                  'Usuario: ' + bloc.usuario,
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white70,
                  ),
                ),
              ],
            )
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(6, 40, 65, 1.0),
                Color.fromRGBO(10, 61, 98, 1.0),
              ]
            )
          ),
        ),

        ListTile(
          leading: Icon(Icons.home),
          title: Text('Inicio'),
          onTap: () {
            Navigator.pushReplacementNamed(context, 'home');
          },
        ),

        Divider(),

        ListTile(
          leading: Icon(Icons.close),
          title: Text('Salir'),
          onTap: () {
            Navigator.pushReplacementNamed(context, '/');
          },
        )
      ],
    ),
  );
}

Stack iconAPP = Stack(
  children: <Widget>[
    Transform.rotate(
      //El pi lo importamos de dart math
      angle: -pi / 5.0,
      child: Container(
        width: 160.0,
        height: 100.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80.0),
          //color: Colors.pink
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(6, 40, 65, 1.0),
              Color.fromRGBO(10, 61, 98, 1.0),
            ]
          )
        ),
      ),
    ),


    Transform.rotate(
      //El pi lo importamos de dart math
      angle: pi / 5.0,
      child: Container(
        width: 160.0,
        height: 100.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80.0),
          //color: Colors.pink
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(6, 40, 65, 1.0),
              Color.fromRGBO(10, 61, 98, 1.0),
            ]
          )
        ),
      ),
    ),

    Container(
      width: 160.0,
      height: 100.0,
      child: Image(
        image: AssetImage('assets/SPP2.png'),
        fit: BoxFit.contain,
      ),
    ),
    
    Container(
      child: Text('Plan', 
        style: TextStyle(
          fontSize: 50.0, 
          color: Colors.white, 
          fontWeight: FontWeight.w800,
          letterSpacing: 3.0,
        ),
        textAlign: TextAlign.center,
      ),
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
    )

  ],
);

Widget ctnInformacion(
  BuildContext context,
  String materia,
  String periodo
) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 5.0),
    color: Theme.of(context).primaryColorDark,
    width: double.infinity,
    child: Column(
      children: <Widget>[
        Text(materia, style: tituloInfo,),
        Text(periodo, style: tituloInfo,),
      ],
    ) 
  );
}