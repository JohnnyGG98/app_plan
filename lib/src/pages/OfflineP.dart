import 'package:flutter/material.dart';

class OfflineP extends StatelessWidget {
  final logo = Image(image: AssetImage('assets/logoISTA.png'),);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contenido offline'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: <Widget>[
            Center(child: logo,),
            _opciones(context),
          ],
        ),
        color: Colors.white,
      ),
    );
  }

  Widget _opciones(BuildContext context){
    return ListView(
      children: <Widget>[
        SizedBox(height: 300,),
        _estiloBtn(
          'Asistencia', 
          (){
            Navigator.pushNamed(context, 'cursosoffline');
          }
        ),
        SizedBox(height: 20.0,),
      ],
    );
  }

  Widget _estiloBtn(String opt, function){
    return Center(
      child: Container(
        width: 350.0,
        child: RaisedButton(        
          shape: StadiumBorder(),
          color: Color.fromRGBO(20, 82, 139, 0.8),
          textColor: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 15.0
            ),
            child: Text(opt, 
            style: TextStyle(fontSize: 25.0),
            ),
          ),
          onPressed: function,
        ),
      )
    );
  }
}
