import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:plan/src/providers/AlumnoPV.dart';
import 'package:plan/src/utils/Abrir.dart';
import 'package:plan/src/utils/MiThema.dart';
import 'package:plan/src/utils/Widgets.dart';

class AlumnoP extends StatelessWidget {
  final almn = new AlumnoPV();
  final int idCurso;
  AlumnoP({this.idCurso = 0});
  AlumnoP.fromCurso({this.idCurso = 0});
  
  @override
  Widget build(BuildContext context) {
    final idCurso = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Alumnos'),
      ),
      body: _cargarAlumnos(idCurso),
    );
  }

  Widget _cargarAlumnos(int idCurso){
    if(idCurso != 0){
      return _listaAlumosCurso(idCurso);
    }else{
      return _listaAlumos();
    }
  }

  Widget _listaAlumos() {
    return FutureBuilder(
      future: almn.getTodos(),
      builder: (BuildContext context, AsyncSnapshot<List<AlumnoM>> snapshot) {
        if (snapshot.hasData) {
          final alumnos = snapshot.data;
          return ListView.builder(
            itemCount: alumnos.length,
            itemBuilder: (BuildContext context, int i) {
              return _carta(context, alumnos[i]);
            },
          );
        } else {
          return cargando(context);
        }
      },
    );
  }

  
  Widget _listaAlumosCurso(int idCurso) {
    return FutureBuilder(
      future: almn.getPorCurso(idCurso),
      builder: (BuildContext context, AsyncSnapshot<List<AlumnoM>> snapshot) {
        if (snapshot.hasData) {
          final alumnos = snapshot.data;
          return ListView.builder(
            itemCount: alumnos.length,
            itemBuilder: (BuildContext context, int i) {
              return _carta(context, alumnos[i]);
            },
          );
        } else {
          return cargando(context);
        }
      },
    );
  }

  Widget _carta(BuildContext ct, AlumnoM a) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(a.getUrlFoto()),
          ),
          title: Text(a.getNombreCompleto()),
          subtitle: Text(a.correo),
          onTap:() => _mostrarInformacionAlumno(ct, a),
        ),
      ),
    );
  }

  void _mostrarInformacionAlumno(BuildContext ct, AlumnoM a){
    showDialog(
      context: ct,      
      barrierDismissible: true,
      builder: (context){
        return AlertDialog(   
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0))
          ),
          elevation: 5.0,
          contentPadding: EdgeInsets.only(
            top: 0.0,   
            bottom: 15.0
          ),
          content: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                MisWidgets.alertInfoHeader(context, 'Información de: ', a.getNombreCorto()),
                SizedBox(height: 15.0,),
                Expanded(
                  child: _listaInformacion(context, a),
                )
              ],
            ),
          ),
          backgroundColor: Colors.white,
        );
      }
    );
  }

  Widget _listaInformacion(BuildContext context, AlumnoM a){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: ListView(
        children: <Widget>[
          _foto(a.id, a.getUrlFoto()),
          SizedBox(height: 10.0,),
          Divider(color: Colors.black, height: 5.0,),
          SizedBox(height: 10.0,),
          MisWidgets.info('Cedula:', a.identificacion),
          MisWidgets.info('Nombre:', a.getNombreCompleto()),
          MisWidgets.info('Correo:', a.correo),
          MisWidgets.info('Celular:', a.celular),
          MisWidgets.info('Telefono:', a.telefono),

          Divider(thickness: 3.0,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, 
            children: <Widget>[

              IconButton(
                icon: Icon(
                  Icons.email, 
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: (){
                  abrirEmail(a.correo);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.sms, 
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: (){
                  abrir('sms:'+a.celular);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.phone_in_talk, 
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: (){
                  abrir('tel:'+a.celular);
                },
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _foto(int id, String url){
    return ClipRRect(

      borderRadius: BorderRadius.circular(15.0),
      child: FadeInImage(
        height: 250.0,
        image: NetworkImage(url),
        placeholder: AssetImage('assets/no-image.jpg'),
        fit: BoxFit.cover,
      ),
    );
  }

}
