import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plan/src/providers/ProviderI.dart';
import 'package:plan/src/providers/UsuarioPV.dart';
import 'package:plan/src/utils/MiThema.dart';
import 'package:plan/src/utils/PreferenciasUsuario.dart';
import 'package:plan/src/utils/Widgets.dart';

class LoginPage extends StatelessWidget {

  final usuarioPV = new UsuarioPV();
  final _prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _existeUsuario(context) ?
          _usuarioGuardados(context) 
          : _formulario(context),
        ],
      ),
    );
  }

  bool _existeUsuario(BuildContext context) {
    final bloc = Provider.of(context);
    if (_prefs.username != '') {
      bloc.changeUsuario(_prefs.username);  
      return true;
    }
    return false;
  }

  Widget _usuarioGuardados(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,
        height: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Usuario logueado', 
              style: TextStyle(fontSize: 25.0),
            ),
            Divider(
              color: Theme.of(context).primaryColor, 
              height: 30.0,
              endIndent: 30.0,
              indent: 30.0,
              thickness: 5.0,
            ),
            RaisedButton(
              child: btnLoginOpt('Continuar con el usuario'),
              onPressed: (){
                Navigator.pushReplacementNamed(context, 'home');
              },
              color: Theme.of(context).primaryColorDark,
              textColor: Colors.white,
            ),
            RaisedButton(
              child: btnLoginOpt('Cambiar de usuario'),
              onPressed: (){
                Navigator.pushReplacementNamed(context, '/');
                _prefs.username = '';
              },
              color: Theme.of(context).primaryColorDark,
              textColor: Colors.white,
            ),
          ],
        ),
      )
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
                _crearRecordarUsuario(bloc),
                SizedBox(height: 25.0),
                _crearBtn(bloc),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _crearRecordarUsuario(LoginB bloc) {
    return StreamBuilder(
      stream: bloc.recordarUsuarioStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return SwitchListTile(
          value: bloc.recordarUsuario,
          title: Text('Recordar usuario'),
          onChanged: (v) => bloc.changeRecordarUsuario(v),
        );
      },
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
              errorText: snapshot.error
            ),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _crearBtn(LoginB bloc) {
    return StreamBuilder(
      stream: bloc.formValidLogin,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
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
          color: Theme.of(context).primaryColorDark,
          textColor: Colors.white,
          onPressed: snapshot.hasData ? () => _login(bloc, context) : null,

        );
      },
    );
  }

  _login(LoginB bloc, BuildContext context) async {
    bool res = await usuarioPV.login(bloc.usuario, bloc.password);
    if (res) {
      if (bloc.recordarUsuario) {
        _prefs.username = bloc.usuario;
      }
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      mostrarError(context, 'Usuario o contraseña incorrectas.');
    }
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fondoPantalla = Container(
      height: size.height,
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