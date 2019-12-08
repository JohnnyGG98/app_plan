import 'package:flutter/material.dart';
import 'package:plan/src/bloc/LoginB.dart';

export 'package:plan/src/bloc/LoginB.dart';

class Provider extends InheritedWidget {

  static Provider _instancia; 

  factory Provider({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new Provider._internal(
        key: key,
        child: child,
      );
    }
    return _instancia;
  }
  
  Provider._internal({Key key, Widget child})
    : super(key: key, child: child);


  final loginBloc = LoginB();
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginB of ( BuildContext context ) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider ).loginBloc; 
  }
}