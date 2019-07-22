import 'dart:io';

import 'package:flutter/material.dart';
import 'package:plan/src/models/SilaboM.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:plan/src/providers/CarreraPV.dart';
import 'package:plan/src/providers/SilaboPV.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class HomeP extends StatefulWidget {
  @override
  _HomePState createState() => _HomePState();
}

class _HomePState extends State<HomeP> {
  final CarreraPV carpv = new CarreraPV();
  final SilaboPV silpv = new SilaboPV();
  String pdfUrl ;
  bool downloading = false;
  var progressString = "123";

  Future<List<CarreraM>> carreras;
  Future<List<SilaboM>> silabos;
  String urlPDFPath = "";
  String urlSilabo = "http://192.168.100.7/zero_api//silabo//verpdf/143";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          _paginaPrincipal(),
          _paginaSecundaria(),
          _paginaSilabos(),
          _descargando(),
        ],
      ),
    );
  }
//  @override
//   void initState() {
//     super.initState();

//     getFileFromUrl(urlSilabo).then((f) {
//       setState(() {
//         urlPDFPath = f.path;
//         print(urlPDFPath);
//       });
//     });
//   }

  Widget _paginaPrincipal() {
    return Stack(
      children: <Widget>[_colorFondo(), _imgFondo(), _txtInicio()],
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
      height: double.infinity / 2,
      child: Image(
        image: NetworkImage('https://www.tecazuay.edu.ec/assets/img/logo.png'),

        //fit: BoxFit.cover,
      ),
    );
  }

  Widget _txtInicio() {
    return SafeArea(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Text(
            'P L A N',
            style: TextStyle(color: Colors.white, fontSize: 50.0),
          ),
          Expanded(
            child: Container(),
          ),
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
          SizedBox(
            height: 40.0,
          ),
          Text('Plan'),
          SizedBox(
            height: 40.0,
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
            ),
            autofocus: false,
          ),
          Expanded(
              child: FutureBuilder(
            future: carpv.getTodos(),
            builder: (BuildContext ct, AsyncSnapshot<List<CarreraM>> snapshot) {
              if (snapshot.hasData) {
                return DropdownButton(
                  value: 'Seleccione',
                  items: getCarreras(snapshot.data),
                  onChanged: ((s) {
                    print('Seleccionamos $s');
                  }),
                  isExpanded: true,
                  icon: Icon(Icons.content_paste),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )),
        ],
      ),
    );
  }

  Widget _paginaSilabos() {
    return FutureBuilder(
      future: silpv.getTodos(),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if(downloading){
          return _descargando();
        }else{
          if (snapshot.hasData) {
            return ListView(children: _listarSilabos(snapshot.data));
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      },
    );
  }

  List<Widget> _listarSilabos(List<SilaboM> silabos) {
    final List<Widget> lista = [];

    silabos.forEach((s) {
      final wt = Card(
        elevation: 10.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.attach_file, color: Colors.blue),
              title: Text(s.materiaNombre),
              subtitle: Text(s.prdLectivoNombre),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  child: Column(
                    // Replace with a Row for horizontal icon + text
                    children: <Widget>[
                      Icon(Icons.remove_red_eye, color: Colors.blue),
                      Text("Ver")
                    ],
                  ),
                  onPressed: () {
                    urlSilabo =
                        "http://192.168.100.7/zero_api//silabo//verpdf/" +
                            s.idSilabo.toString();
                    getFileFromUrl(urlSilabo).then((f) {
                      setState(() {
                        urlPDFPath = f.path;
                        print(urlPDFPath);
                        if (urlPDFPath != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PdfViewPage(path: urlPDFPath)));
                        }
                      });
                    });
                  },
                ),
                FlatButton(
                  
                  child: Column(
                    // Replace with a Row for horizontal icon + text
                    children: <Widget>[
                      Icon(Icons.file_download, color: Colors.blue),
                      Text("Descargar")
                    ],
                  ),
                  
                  onPressed: () {
                    
                    urlSilabo="http://192.168.100.7/zero_api//silabo//verpdf/"+s.idSilabo.toString();
                    downloadFile(urlSilabo); 
                  },
                ),
                FlatButton(
                  child: Column(
                    // Replace with a Row for horizontal icon + text
                    children: <Widget>[
                      Icon(Icons.library_books, color: Colors.blue),
                      Text("Tareas")
                    ],
                  ),
                  onPressed: () {},
                )
              ],
            )
          ],
        ),
      );

      lista..add(wt)..add(Divider());
    });

    return lista;
  }

  Widget _descargando(){
    if(downloading){
      return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Downloading File: "+ progressString,
              
              style: TextStyle(
                color: Colors.black,
                fontSize: 30.0
              ),
            )
          ],
        ),
      ),
    );
    }else{
      return Container();
    }
    
  }

  List<DropdownMenuItem<String>> getCarreras(List<CarreraM> carreras) {
    List<DropdownMenuItem<String>> list = new List();

    list.add(DropdownMenuItem(
      child: Text('Seleccione'),
      value: 'Seleccione',
    ));

    carreras.forEach((c) {
      print(c.nombre);

      list.add(DropdownMenuItem(
        child: Text(c.nombre),
        value: c.nombre,
      ));
    });

    print('Numero de items ' + list.length.toString());

    return list;
  }

  Future<void> downloadFile(String pdfUrl) async {
    Dio dio = Dio();

    try {
      var dir = await getApplicationDocumentsDirectory();

      if(!downloading){
        setState(() {
          downloading = true;
        });
      }

      await Future.delayed(Duration(milliseconds: 10000));

      await dio.download(
        pdfUrl, 
        "${dir.path}/mypdf.pdf",
        onReceiveProgress: (rec, total) {
        print("Rec: $rec , Total: $total");
        
        setState(() {
          downloading = true;
          progressString = ((rec / total) * 100).toStringAsFixed(0) + "%";
          print(downloading);
          print(progressString);
        });
      });
    } catch (e) {
      print(e);
    }

    setState(() {
      downloading = false;
      progressString = "";
    });
    print("Download completed");
  }
}

Future<File> getFileFromUrl(String url) async {
  try {
    var data = await http.get(url);
    var bytes = data.bodyBytes;
    var dir = await getApplicationDocumentsDirectory();
    File file = File("${dir.path}/mypdfonline.pdf");

    File urlFile = await file.writeAsBytes(bytes);
    return urlFile;
  } catch (e) {
    throw Exception("Error opening url file");
  }
}

class PdfViewPage extends StatefulWidget {
  final String path;

  const PdfViewPage({Key key, this.path}) : super(key: key);
  @override
  _PdfViewPageState createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {
  int _totalPages = 0;
  int _currentPage = 0;
  bool pdfReady = false;
  PDFViewController _pdfViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Document"),
      ),
      body: Stack(
        children: <Widget>[
          PDFView(
            filePath: widget.path,
            autoSpacing: true,
            enableSwipe: true,
            pageSnap: true,
            swipeHorizontal: true,
            nightMode: false,
            onError: (e) {
              print(e);
            },
            onRender: (_pages) {
              setState(() {
                _totalPages = _pages;
                pdfReady = true;
              });
            },
            onViewCreated: (PDFViewController vc) {
              _pdfViewController = vc;
            },
            onPageChanged: (int page, int total) {
              setState(() {});
            },
            onPageError: (page, e) {},
          ),
          !pdfReady
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Offstage()
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          _currentPage > 0
              ? FloatingActionButton.extended(
                  backgroundColor: Colors.red,
                  label: Text("Go to ${_currentPage - 1}"),
                  onPressed: () {
                    _currentPage -= 1;
                    _pdfViewController.setPage(_currentPage);
                  },
                )
              : Offstage(),
          _currentPage + 1 < _totalPages
              ? FloatingActionButton.extended(
                  backgroundColor: Colors.green,
                  label: Text("Go to ${_currentPage + 1}"),
                  onPressed: () {
                    _currentPage += 1;
                    _pdfViewController.setPage(_currentPage);
                  },
                )
              : Offstage(),
        ],
      ),
    );
  }
}
