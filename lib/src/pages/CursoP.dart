import 'package:flutter/material.dart';
import 'package:plan/src/providers/CursoPV.dart';

class CursoP extends StatelessWidget {
  final cur = new CursoPV();

  @override
  Widget build(BuildContext context) {
    final String query = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Cursos'),
        backgroundColor: Colors.blueGrey,
      ),
      body: _listaCursos(query),
    );
  }

  Widget _listaCursos(String query){
    
    return FutureBuilder(
      //future: cur.getTodos(),
      future: cur.buscar(query),
      builder: (BuildContext context, AsyncSnapshot<List<CursoM>> snapshot){
        if(snapshot.hasData){
          final crs = snapshot.data;
          return ListView.builder(
            itemCount: crs.length,
            itemBuilder: (BuildContext context, int i){
              return _carta(crs[i], context);
            },
          );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _carta(CursoM c, BuildContext context){
    TextStyle s = TextStyle(
      fontSize: 20.0
    );
    return SafeArea(
      child: Container(
        /*padding: EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 5.0
        ),*/
        padding: EdgeInsets.only(
          top: 5.0,
          right: 5.0,
          left: 15.0,
          bottom: 10.0
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(c.getDocente(), style: s,),
                  Text(c.periodoNombre),               Text(c.materiaNombre, style: s,),
                  Text(c.nombre),
                ],
              )
              
              
              /*ListTile(
                title: Text(c.materiaNombre),
                subtitle: Text(c.periodoNombre),
              ),*/
            ),
            Column(
              children: <Widget>[
                FlatButton(
                  child: Icon(Icons.school),
                  onPressed: (){
                    print(c.idCurso);
                    Navigator.pushNamed(context, 'alumno', arguments: c.idCurso);
                  },
                ),
                FlatButton(
                  child: Icon(Icons.book),
                  onPressed: (){
                    print(c.idMateria.toString()+' '+c.idPeriodo.toString());
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

}