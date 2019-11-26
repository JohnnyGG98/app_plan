import 'dart:math';

import 'package:flutter/material.dart';
import 'package:plan/src/providers/ProviderI.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _formulario(context),
        ],
      ),
    );
  }

  Widget _formulario(BuildContext context) {
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[

          SafeArea(
            child: Container(
              height: 200.0,
            ),
          ),

          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: <BoxShadow> [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 2.0
                )
              ]
            ),
            child: Column(
              children: <Widget>[
                Text(
                  'Login', 
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 40.0),
                _crearUser(bloc),
                SizedBox(height: 25.0),
                _crearPassword(bloc),
                SizedBox(height: 25.0),
                _crearBtn(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _crearUser(LoginB bloc) {
    return StreamBuilder(
      stream: bloc.usuarioStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              icon: Icon(
                Icons.person_pin,
                color: Colors.blueGrey,
              ),
              hintText: '0000000000',
              labelText: 'Usuario:',
              counterText: snapshot.data,
              errorText: snapshot.error
            ),
            onChanged: (v) => bloc.changeUsuario(v),
          ),
        );
      },
    );
  }

  Widget _crearPassword(LoginB bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(
                Icons.lock,
                color: Colors.blueGrey,
              ),
              labelText: 'Contraseña:',
              counterText: snapshot.data,
              errorText: snapshot.error
            ),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _crearBtn() {
    return RaisedButton(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 80.0,
          vertical: 10.0
        ),
        child: Text(
          'Ingresar',
          style: TextStyle(
            fontSize: 20.0
          ),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0)
      ),
      elevation: 0.0,
      color: Colors.blueGrey,
      textColor: Colors.white,
      onPressed: () {},
    );
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fondoPantalla = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color> [
            Color.fromRGBO(10, 61, 98, 1.0),
            Color.fromRGBO(6, 40, 65, 1.0),
          ]
        )
      ),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.09)
      ),
    );

    

    return Stack(
      children: <Widget>[
        fondoPantalla,
        _circuloRandom(circulo),
        _circuloRandom(circulo),
        _circuloRandom(circulo),
        _circuloRandom(circulo),
        _circuloRandom(circulo),
        _circuloRandom(circulo),

        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              Icon( 
                Icons.bookmark, 
                color: Colors.white,
                size: 100.0,
              ),
              SizedBox(
                height: 10.0, 
                width: double.infinity,
              ),
              Text(
                'PLAN',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0
                ),
              ),
              SizedBox(
                height: 10.0, 
                width: double.infinity,
              ),
              Text(
                'by: Zero Team',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0
                ),
              ),
            ],
          ),
        )
        

      ],
    );

    
  }

  Widget _circuloRandom(Widget circulo) {
    final rng = new Random();
    return Positioned(
      top: double.parse(rng.nextInt(100).toString()),
      left: double.parse(rng.nextInt(320).toString()),
      child: circulo,
    );
  }

}