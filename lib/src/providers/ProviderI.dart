import 'package:flutter/material.dart';
import 'package:plan/src/bloc/LoginB.dart';

export 'package:plan/src/bloc/LoginB.dart';

class Provider extends InheritedWidget {

  final loginBloc = LoginB();

  Provider({Key key, Widget child})
    : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginB of ( BuildContext context ) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider ).loginBloc; 
  }
}