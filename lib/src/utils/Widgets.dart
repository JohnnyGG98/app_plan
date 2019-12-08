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
  return Drawer(
    child: ListView(
      children: <Widget>[
        DrawerHeader(
          child: Container(
            child: Text('Menu'),
          ),
        ),

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