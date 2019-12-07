import 'package:flutter/material.dart';
import 'package:plan/src/models/PeriodoM.dart';
import 'package:plan/src/providers/CarreraPV.dart';
import 'package:plan/src/providers/CursoPV.dart';
import 'package:plan/src/providers/PeriodoPV.dart';
import 'package:plan/src/providers/ProviderI.dart';
import 'package:plan/src/utils/MiThema.dart';

class HomeCursoP extends StatefulWidget {
  @override
  _HomeCursoPState createState() => _HomeCursoPState();
}

class _HomeCursoPState extends State<HomeCursoP> {

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
      materias = curpv.getMateriasPorNombreCursoPeriodo(_cursoNombreSelec, int.parse(_periodoSelec));
    }

    // Datos del login 
    final bloc = Provider.of(context);
    print('Usuario logeado ${bloc.usuario}');

    return _paginaSecundaria();
  }

  Widget _paginaSecundaria() {
    if(!_carrerasCargado){
      carreras = carpv.getTodos();
      _carrerasCargado = true;
    }

    return ListView(
      children: <Widget>[
        _headerPage(),
        SizedBox(height: 40.0,),
        _combos(),
      ]
    );
  }

  void _llamarPageCurso(List param){ 
    Navigator.pushNamed(context, 'curso', arguments: param);
  }

  void _llamarPageSilabo(List  param){
    Navigator.pushNamed(context, 'silabo', arguments: param);
  }

  Widget _paddingWidgets(Widget w){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: w,
    );
  }

  Widget _headerPage(){
    final header = Column(
      children: <Widget>[
        SizedBox(height: 40.0,),
        Text('Plan', 
        style: TextStyle(fontSize: 50.0),),
        SizedBox(height: 20.0,),
        _buscador(),
      ],
    );

    return _paddingWidgets(header);
  }

  Widget _combos(){
    final body = Column(
      children: <Widget>[
        _comboCarreras(),
        SizedBox(height: 20.0,),
        _comboPeriodoFuture(),
        SizedBox(height: 20.0,),
        _comboCursoNombreFuture(),
        SizedBox(height: 20.0,),
        _comboMateriasFuture(),
        SizedBox(height: 20.0,),
        _botonesCombo(),
        SizedBox(height: 20.0,),
      ],
    );
    return _paddingWidgets(body);
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
                icon: dropDown,
                iconSize: 40.0,
              );
            }else{
              return cargando(context);
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
                  icon: dropDown,
                  iconSize: 40.0,
                );
              }else{
                return cargando(context);
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
                  icon: dropDown,
                );
              }else{
                return cargando(context);
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
                  icon: dropDown,
                );
              }else{
                return cargando(context);
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
          child: _stlItem(c.codigo),
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
                  _llamarPageCurso(['periodo', _periodoSelec]);
                }else if(_periodoSelec != '0' && _cursoNombreSelec != '0' && _materiaSelec == '0'){
                  _llamarPageCurso(['nombre', _cursoNombreSelec+'-'+_periodoSelec]);
                }else{
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
                  _llamarPageSilabo(['periodo', _periodoSelec]);
                }else if(_periodoSelec != '0' && _cursoNombreSelec != '0' && _materiaSelec == '0'){
                  _llamarPageSilabo(['nombre', _cursoNombreSelec+'-'+_periodoSelec]);
                }else{
                  _llamarPageSilabo(['curso', _materiaSelec]);
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

}