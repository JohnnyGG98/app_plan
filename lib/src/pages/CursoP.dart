import 'package:flutter/material.dart';
import 'package:plan/src/providers/CursoPV.dart';

class CursoP extends StatelessWidget {
  final cur = new CursoPV();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cursos'),
        backgroundColor: Colors.blueGrey,
      ),
      body: _listaCursos(),
    );
  }

  Widget _listaCursos(){
    return FutureBuilder(
      future: cur.getTodos(),
      builder: (BuildContext context, AsyncSnapshot<List<CursoM>> snapshot){
        if(snapshot.hasData){
          final crs = snapshot.data;
          return ListView.builder(
            itemCount: crs.length,
            itemBuilder: (BuildContext context, int i){
              return _carta(crs[i]);
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

  Widget _carta(CursoM c){
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: ListTile(
                title: Text(c.materiaNombre),
                subtitle: Text(c.periodoNombre),
              ),
            ),
            Icon(Icons.bookmark_border, color: Colors.blue, size: 30.0,),
            Icon(Icons.school, color: Colors.blue, size: 30.0,)
          ],
        ),
      ),
    );
  }
}