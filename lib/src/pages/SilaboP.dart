import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:plan/src/models/ActividadM.dart';
import 'package:plan/src/models/SilaboM.dart';
import 'package:plan/src/providers/SilaboPV.dart';
import 'package:plan/src/utils/ConsApi.dart';
import 'package:plan/src/utils/MiThema.dart';
import 'package:plan/src/utils/Widgets.dart';

class SilaboP extends StatefulWidget {
  @override
  _SilaboPState createState() => _SilaboPState();
}

class _SilaboPState extends State<SilaboP> {
  final slpv = new SilaboPV();
  String pdfUrl;
  bool downloading = false;
  var progressString = "";
  String urlPDFPath = "";
  String urlSilabo = "";
  @override
  Widget build(BuildContext context) {
    final List param = ModalRoute.of(context).settings.arguments;
    //Titulo de la pagina
    String titulo = '';
    //Aqui cargamos todos los silabos
    Future<List<SilaboM>> silabos;

    switch (param[0]) {
      case 'curso':
        {
          silabos = slpv.getPorCurso(param[1].toString());
          titulo = 'Silabo: ' + param[1].toString();
        }
        break;
      case 'nombre':
        {
          silabos = slpv.getPorNombreCursoPeriodo(param[1].toString());
          titulo = 'Silabo Curso: ' + param[1].toString().split('-')[0];
        }
        break;
      case 'periodo':
        {
          silabos = slpv.getPorPeriodo(param[1].toString());
          titulo = 'Silabo por Periodo: ' + param[1].toString();
        }
        break;
      default:
        {
          silabos = slpv.getTodos();
        }
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
      ),
      body: _listaSilabos(silabos),
    );
  }

  void _verActividades(BuildContext ct, SilaboM s){
    showDialog(
      context: ct,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0))
          ),
          elevation: 5.0,
          contentPadding: EdgeInsets.only(
            top: 0.0, 
          ),
          content: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                MisWidgets.alertInfoHeader(context, s.materiaNombre, s.cursos),
                Expanded(
                  child: informacionActividades(s.idSilabo),
                )
              ],
            ),
          ),
        );
      }
    );
  }

  Widget informacionActividades(int idSilabo){
    return FutureBuilder(
      future: slpv.getActividades(idSilabo.toString()),
      builder: (BuildContext context, AsyncSnapshot<List<ActividadM>> snapshot){
        if(snapshot.hasData){
          final actividades = snapshot.data;
          return ListView.builder(
            itemCount: actividades.length,
            itemBuilder: (BuildContext context, int i){
              return ListTile(
                title: Text(actividades[i].titulo),
                subtitle: Text(actividades[i].indicador),
                trailing: CircleAvatar(
                  child: Text(actividades[i].valoracion),
                ),
              );
            },
          );
        }else{
          return cargando(context);
        }
      },
    );
  }

  Widget _listaSilabos(Future<List<SilaboM>> silabos) {
    return FutureBuilder(
      future: silabos,
      builder: (BuildContext context, AsyncSnapshot<List<SilaboM>> snapshot) {
        if (downloading) {
          return _descargando();
        } else {
          if (snapshot.hasData) {
            final slbs = snapshot.data;
            return ListView.builder(
              itemCount: slbs.length,
              itemBuilder: (BuildContext context, int i) {
                return _listarSilabo(
                  '${slbs[i].materiaNombre}',
                  '${slbs[i].prdLectivoNombre}', 
                  '${slbs[i].idSilabo}', 
                  slbs[i].getUrlPDF(),
                  slbs[i],
                  context
                );
              },
            );
          } else {
            return cargando(context);
          }
        }
      },
    );
  }

  Widget _listarSilabo(
      String materiaNombre, 
      String prdLectivoNombre, 
      String idSilabo, 
      String urlSilabo, 
      SilaboM s, 
      BuildContext ct
  ) {
    final wt = SafeArea(
      child: Container(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(materiaNombre),
              subtitle: Text(prdLectivoNombre),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.remove_red_eye, color: Theme.of(context).primaryColor,),
                      Text("Ver")
                    ],
                  ),
                  onPressed: () {
                    getFileFromUrl(urlSilabo).then((f) {
                      setState(() {
                        urlPDFPath = f.path;
                        print(urlPDFPath);
                        if (urlPDFPath != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => 
                                PdfViewPage(path: urlPDFPath)
                              )
                          );
                        }
                      });
                    });
                  },
                ),
                FlatButton(
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.file_download, color: Theme.of(context).primaryColor),
                      Text("Descargar")
                    ],
                  ),
                  onPressed: () {
                    urlSilabo = ConsApi.path + "/silabo/verpdf/" + idSilabo;
                    downloadFile(urlSilabo);
                  },
                ),
                FlatButton(
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.library_books, color: Theme.of(context).primaryColor),
                      Text("Tareas"),
                    ],
                  ),
                  onPressed: () {
                    _verActividades(ct, s);
                  },
                )
              ],
            ),
            Divider(),
          ],
        ),
  
      ),
    );
    return wt;
  }

  Widget _descargando() {
    if (downloading) {
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
                "Downloading File " + progressString,
                style: TextStyle(color: Colors.black, fontSize: 30.0),
              )
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Future<void> downloadFile(String pdfUrl) async {
    Dio dio = Dio();

    try {
      var dir = await getExternalStorageDirectory();

      if (!downloading) {
        setState(() {
          downloading = true;
        });
      }

      await Future.delayed(Duration(milliseconds: 10000));

      List <String> f=pdfUrl.split("/");
      await dio.download(pdfUrl, "${dir.path}/silabo" + f[f.length-1]+".pdf",
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

    progressString = "✔";

    await Future.delayed(Duration(milliseconds: 500));

    setState(() {
      downloading = false;
      progressString = "";
    });
    print("Download completed");
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }
}

Future<File> getFileFromAsset(String asset, String url) async {
  try {
    var data = await rootBundle.load(asset);
    if (data == null) {
      getFileFromUrl(url);
    } else {
      var bytes = data.buffer.asUint8List();
      var dir = await getExternalStorageDirectory();
      File file = File("${dir.path}/mypdf.pdf");

      File assetFile = await file.writeAsBytes(bytes);
      return assetFile;
    }
  } catch (e) {
    throw Exception("Error opening asset file");
  }
}

Future<File> getFileFromUrl(String url) async {
  try {
    var data = await http.get(url);
    var bytes = data.bodyBytes;
    var dir = await getExternalStorageDirectory();
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
        title: Text("Silabo"),
        backgroundColor: Colors.blueGrey,
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
                  label: Text("Anterior ${_currentPage - 1}"),
                  onPressed: () {
                    _currentPage -= 1;
                    _pdfViewController.setPage(_currentPage);
                  },
                )
              : Offstage(),
          _currentPage + 1 < _totalPages
              ? FloatingActionButton.extended(
                  backgroundColor: Colors.green,
                  label: Text("Siguiente ${_currentPage + 1}"),
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
