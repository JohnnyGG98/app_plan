import 'package:flutter/material.dart';
import 'package:plan/src/models/SilaboM.dart';
import 'package:plan/src/providers/CarreraPV.dart';
import 'package:plan/src/providers/SilaboPV.dart';


class HomeP extends StatefulWidget {
  @override
  _HomePState createState() => _HomePState();
}

class _HomePState extends State<HomeP> {

  final CarreraPV carpv = new CarreraPV();
  final SilaboPV silpv = new SilaboPV();
  Future<List<CarreraM>> carreras;
  Future<List<SilaboM>> silabos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          _paginaPrincipal(),
          _paginaSecundaria()
        ],
      ),
    );
  }

  
  Widget _paginaPrincipal() {
    return Stack(
      children: <Widget>[
        _colorFondo(),
        _imgFondo(),
        _txtInicio()
      ],
    );
  }

  Widget _colorFondo() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color.fromRGBO(20, 82, 139, 0.8),
    );
  }

  Widget _imgFondo() {
    return Container(
      width: double.infinity,
      height: double.infinity/2,
      child: Image(
        image: NetworkImage('https://www.tecazuay.edu.ec/assets/img/logo.png'),
        //fit: BoxFit.cover,
      ),
    );
  }

  Widget _txtInicio(){
    return SafeArea(
      child: Column(
        children: <Widget>[
          SizedBox(height: 20.0,),
          Text('P L A N', style: 
            TextStyle(
              color: Colors.white, 
              fontSize: 50.0),
          ),
          Expanded(child: Container(),),
          Icon(
            Icons.keyboard_arrow_down, 
            size: 70.0, 
            color: Colors.white,
          )
        ],
      ),
    );
  }

  Widget _paginaSecundaria() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color.fromRGBO(20, 82, 139, 0.8),
      child: Column(
        children: <Widget>[
          SizedBox(height: 40.0,),
          Text('Plan'),
          SizedBox(height: 40.0,),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  topRight: Radius.circular(20)
                ),
              ),
            ),
            autofocus: false,
          ),
          Expanded(
            child: FutureBuilder(
              future: silpv.getTodos(),
              builder: (BuildContext ct, AsyncSnapshot<List<SilaboM>> snapshot){
                if(snapshot.hasData){
                  return DropdownButton(
                    value: 'Seleccione',
                    items: getSilabos(snapshot.data),
                    onChanged: ((s){
                      print('Seleccionamos $s');
                    }),
                    isExpanded: true,
                    icon: Icon(Icons.content_paste),
                  );
                }else{
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )
          ),

        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> getCarreras(List<CarreraM> carreras) {

    List<DropdownMenuItem<String>> list = new List();
    list.add(
      DropdownMenuItem(
         child: Text('Seleccione'),
         value: 'Seleccione',
      )
    );

    carreras.forEach((c){
      print(c.nombre);
      list.add(
        DropdownMenuItem(
        child: Text(c.nombre),
        value: c.nombre,
        )
      );
    });

    print('Numero de items '+list.length.toString());

    return list; 
  }


  List<DropdownMenuItem<String>> getSilabos(List<SilaboM> silabos) {

    List<DropdownMenuItem<String>> list = new List();
    list.add(
      DropdownMenuItem(
         child: Text('Seleccione'),
         value: 'Seleccione',
      )
    );

    silabos.forEach((s){
      print(s.materiaNombre);
      list.add(
        DropdownMenuItem(
        child: Text(s.materiaNombre),
        value: s.materiaNombre,
        )
      );
    });

    print('Numero de items '+list.length.toString());

    return list; 
  }
}