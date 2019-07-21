import 'dart:async';

import 'package:flutter/material.dart';
import 'package:plan/src/models/PeriodoM.dart';
import 'package:plan/src/providers/CarreraPV.dart';
import 'package:plan/src/providers/CursoPV.dart';
import 'package:plan/src/providers/PeriodoPV.dart';


class HomeP extends StatefulWidget {
  @override
  _HomePState createState() => _HomePState();
}

class _HomePState extends State<HomeP> {

  final CarreraPV carpv = new CarreraPV();
  final PeriodoPV perpv = new PeriodoPV();
  final CursoPV curpv = new CursoPV();

  List<DropdownMenuItem<String>> listPeriodo;
  Future<List<CarreraM>> carreras;
  Future<List<PeriodoM>> periodos;
  Future<List<MateriaM>> materias;
  Future<List<String>> cursosNombre;
  String _query = '';
  String _carreraSelec = '0';
  String _periodoSelec = '0';
  String _cursoNombreSelec = '0';
  String _materiaSelec = '0';
  bool _carrerasCargado = false;

  

  @override
  Widget build(BuildContext context) {
    //Cargamos el item inicial de todos los combos
    listPeriodo = new List();
    //iniciarCombos();
    if(!_carrerasCargado){
      carreras = carpv.getTodos();
      _carrerasCargado = true;
    }

    if(_carreraSelec != '0'){
      periodos = perpv.getPorCarrera(int.parse(_carreraSelec));
    }else{
      periodos = null;
    }

    if(_periodoSelec == '0'){
      cursosNombre = null;
      materias = null;
    }

    if(_cursoNombreSelec == '0'){
      materias = null;
    }

    if(_periodoSelec != '0' && _cursoNombreSelec == '0'){
      cursosNombre = curpv.getNombreCursoPorPeriodo(int.parse(_periodoSelec));
    }

    if(_cursoNombreSelec != '0' && _materiaSelec == '0'){
      print('Buscando materiasss....');
      materias = curpv.getMateriasPorNombreCursoPeriodo(_cursoNombreSelec, int.parse(_periodoSelec));
    }
    
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          _paginaPrincipal(),
          _paginaSecundaria(),
          _terceraPagina()
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
        image: AssetImage('assets/logoISTA.png'),
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
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(
                left: 20.0,
                right: 20.0
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 40.0,),
            Text('Plan', 
            style: TextStyle(fontSize: 50.0),),
            SizedBox(height: 20.0,),
            _buscador(),
            SizedBox(height: 40.0,),
            _comboCarreras(),
            SizedBox(height: 20.0,),
            _comboPeriodoFuture(),
            SizedBox(height: 20.0,),
            _comboCursoNombreFuture(),
            SizedBox(height: 20.0,),
            _comboMateriasFuture(),
            SizedBox(height: 20.0,),
            _botonesCombo(),
          ],
        ),
      ),
    );
  }

  void _llamarPageCurso(List param){ 
    Navigator.pushNamed(context, 'curso', arguments: param);
  }

  Widget _buscador(){
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide()
              ),
            ),
            autofocus: false,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
            ),
            onChanged: (input){
              _query = input;
            },
          ),
        ),
        RaisedButton(
          color: Colors.blue,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Icon(Icons.search, ),
          ),
          onPressed: (){
            _llamarPageCurso(['buscar', _query]);
            //Navigator.pushNamed(context, 'curso', arguments: param);
          },
        )
      ],
    );
  }

  Widget _comboCarreras(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: FutureBuilder(
          future: carreras,
          builder: (BuildContext ct, AsyncSnapshot<List<CarreraM>> snapshot){
            if(snapshot.hasData){
              return DropdownButton(

                value: _carreraSelec,
                items: getCarreras(snapshot.data),
                onChanged: ((s){
                  setState(() {
                    _carreraSelec = s;  
                    _periodoSelec = '0';
                    _cursoNombreSelec = '0';
                    _materiaSelec = '0';
                  });
                }),
                isExpanded: true,
                icon: Icon(Icons.content_paste),
                iconSize: 40.0,
              );
            }else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        )
      ),
    );
  }

  Widget _comboPeriodoFuture() {
    if(periodos == null){
      return Container();
    }else{
      return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: FutureBuilder(
          future: periodos,
            builder: (BuildContext ct, AsyncSnapshot<List<PeriodoM>> snapshot){
              if(snapshot.hasData){
                return DropdownButton(

                  value: _periodoSelec,
                  items: getPeriodos(snapshot.data),
                  onChanged: ((s){
                    setState(() {
                      _periodoSelec = s;  
                      _cursoNombreSelec = '0';
                      _materiaSelec = '0';
                    });
                  }),
                  isExpanded: true,
                  icon: Icon(Icons.content_paste),
                  iconSize: 40.0,
                );
              }else{
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )
        ),
      );
    }
  }

  Widget _comboCursoNombreFuture() {
    if(cursosNombre == null){
      return Container();
    }else{
      return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: FutureBuilder(
          future: cursosNombre,
            builder: (BuildContext ct, AsyncSnapshot<List<String>> snapshot){
              if(snapshot.hasData){
                return DropdownButton(

                  value: _cursoNombreSelec,
                  items: getNombreCurso(snapshot.data),
                  onChanged: ((s){
                    setState(() {
                      _cursoNombreSelec = s;  
                      _materiaSelec = '0';
                    });
                  }),
                  isExpanded: true,
                  icon: Icon(Icons.content_paste),
                  iconSize: 40.0,
                );
              }else{
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )
        ),
      );
    }
  }

  Widget _comboMateriasFuture() {
    if(materias == null){
      return Container();
    }else{
      return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: FutureBuilder(
          future: materias,
            builder: (BuildContext ct, AsyncSnapshot<List<MateriaM>> snapshot){
              if(snapshot.hasData){
                return DropdownButton(

                  value: _materiaSelec,
                  items: getMateria(snapshot.data),
                  onChanged: ((s){
                    setState(() {
                      _materiaSelec = s;  
                    });
                  }),
                  isExpanded: true,
                  icon: Icon(Icons.content_paste),
                  iconSize: 40.0,
                );
              }else{
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )
        ),
      );
    }
  }
  
  List<DropdownMenuItem<String>> getCarreras(List<CarreraM> carreras) {
    List<DropdownMenuItem<String>> listCarreras = new List();
    listCarreras.add(
      DropdownMenuItem(
         child: _stlItem('Seleccione una carrera'),
         value: '0',
      )
    );
    carreras.forEach((c){
      listCarreras.add(
        DropdownMenuItem(
          child: _stlItem(c.nombre),
          value: c.id.toString(),
        )
      );
    });
    return listCarreras; 
  }

  List<DropdownMenuItem<String>> getPeriodos(List<PeriodoM> periodo) {
    List<DropdownMenuItem<String>> listPeriodo = new List();
    listPeriodo.add(
      DropdownMenuItem(
         child: _stlItem('Seleccione un periodo'),
         value: '0',
      )
    );
    periodo.forEach((p){
      listPeriodo.add(
        DropdownMenuItem(
          child: _stlItem(p.nombre),
          value: p.id.toString(),
        )
      );
    });
    return listPeriodo; 
  }

  List<DropdownMenuItem<String>> getNombreCurso(List<String> cursos) {
    List<DropdownMenuItem<String>> listCurso = new List();
    listCurso.add(
      DropdownMenuItem(
         child: _stlItem('Seleccione un curso'),
         value: '0',
      )
    );
    cursos.forEach((c){
      listCurso.add(
        DropdownMenuItem(
          child: _stlItem(c),
          value: c,
        )
      );
    });
    return listCurso; 
  }

  List<DropdownMenuItem<String>> getMateria(List<MateriaM> materias) {
    List<DropdownMenuItem<String>> listMateria = new List();
    listMateria.add(
      DropdownMenuItem(
         child: _stlItem('Seleccione una materia'),
         value: '0',
      )
    );
    materias.forEach((m){
      listMateria.add(
        DropdownMenuItem(
          child: _stlItem(m.materia),
          value: m.idCurso.toString(),
        )
      );
    });
    return listMateria; 
  }

  static Widget _stlItem(String item){
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 5.0
      ),
      child: Text(item, 
        style: TextStyle(fontSize: 15.0),
      ),
    );
  }

  Widget _botonesCombo(){
    if(_periodoSelec != '0'){
      final pading = EdgeInsets.symmetric(horizontal: 35.0,vertical: 15.0);
      return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FlatButton(
              color: Colors.blueGrey,
              child: _txtBtns('Curso'),
              padding: pading,
              onPressed: (){
                if(_periodoSelec != '0' && _cursoNombreSelec == '0' && _materiaSelec == '0'){
                  //print('Buscamos solo por periodo: '+_periodoSelec);
                  _llamarPageCurso(['periodo', _periodoSelec]);
                }else if(_periodoSelec != '0' && _cursoNombreSelec != '0' && _materiaSelec == '0'){
                  //print('Buscamos por periodo: '+_periodoSelec+ ' y nombre curso: $_cursoNombreSelec');
                  //Debemos pasarle en este formato por el link {curso_nombre}-{id_periodo}
                  _llamarPageCurso(['nombre', _cursoNombreSelec+'-'+_periodoSelec]);
                }else{
                  //print('Buscamos por curso: $_materiaSelec');
                  _llamarPageCurso(['curso', _materiaSelec]);
                }
              },
            ),
            FlatButton(
              color: Colors.blueGrey,
              padding: pading,
              child: _txtBtns('Silabo'),
              onPressed: (){
                if(_periodoSelec != '0' && _cursoNombreSelec == '0' && _materiaSelec == '0'){
                  print('Buscamos solo por periodo: '+_periodoSelec);
                }else if(_periodoSelec != '0' && _cursoNombreSelec != '0' && _materiaSelec == '0'){
                  print('Buscamos por periodo: '+_periodoSelec+ ' y nombre curso: $_cursoNombreSelec');
                }else{
                  print('Buscamos por curso: $_materiaSelec');
                }
              },
            )
          ],
        ),
      );
    }else{
      return Container();
    }
  }

  Widget _txtBtns(String txt){
    return Text(
      txt,
      style: TextStyle(
        color: Colors.white,
        fontSize: 25.0
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _terceraPagina(){
    final logo = Image(image: AssetImage('assets/logoISTA.png'),);

    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: <Widget>[
          Center(child: logo,),
          _opciones(),
        ],
      ),
    );
  }

  Widget _opciones(){
    return ListView(
      children: <Widget>[
        SizedBox(height: 400,),
        _estiloBtn('Cursos'),
        SizedBox(height: 20.0,),
        _estiloBtn('Silabos'),
        SizedBox(height: 20.0,),
        SizedBox(height: 20.0,),
        _estiloBtn('Silabos'),
        SizedBox(height: 20.0,),
        SizedBox(height: 20.0,),
      ],
    );
  }

  Widget _estiloBtn(String opt){
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
          onPressed: (){},
        ),
      )
    );
  }

}