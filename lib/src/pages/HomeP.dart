import 'package:flutter/material.dart';
import 'package:plan/src/providers/CarreraPV.dart';


class HomeP extends StatefulWidget {
  @override
  _HomePState createState() => _HomePState();
}

class _HomePState extends State<HomeP> {

  final CarreraPV carpv = new CarreraPV();
  Future<List<CarreraM>> carreras;

  @override
  Widget build(BuildContext context) {
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
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all( Radius.circular(20)),
                ),
              ),
              autofocus: false,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: FutureBuilder(
                  future: carpv.getTodos(),
                  builder: (BuildContext ct, AsyncSnapshot<List<CarreraM>> snapshot){
                    if(snapshot.hasData){
                      return DropdownButton(
                        value: 'Seleccione',
                        items: getCarreras(snapshot.data),
                        onChanged: ((s){
                          print('Seleccionamos $s');
                        }),
                        isExpanded: true,
                        icon: Icon(Icons.content_paste),
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black
                        ),
                        iconSize: 30.0,
                      );
                    }else{
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )
              ),
            ),
          ],
        ),
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
        _estiloBtn('Silabos'),
        SizedBox(height: 20.0,),
        SizedBox(height: 20.0,),
        _estiloBtn('Silabos'),
        SizedBox(height: 20.0,),
        SizedBox(height: 20.0,),
        _estiloBtn('Silabos'),
        SizedBox(height: 20.0,),
        SizedBox(height: 20.0,),
        _estiloBtn('Silabos'),
        SizedBox(height: 20.0,),
        SizedBox(height: 20.0,),
        _estiloBtn('Silabos'),
        SizedBox(height: 20.0,),
        SizedBox(height: 20.0,),
        _estiloBtn('Silabos'),
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