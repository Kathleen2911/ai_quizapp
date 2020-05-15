import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

class PdfKurzVersion extends StatefulWidget {
  final String chapter;

  PdfKurzVersion({Key key, @required this.chapter}) : super(key: key);

  @override
  _PdfKurzVersionState createState() => _PdfKurzVersionState(chapter);
}

class _PdfKurzVersionState extends State<PdfKurzVersion> {
  String chapter;
  _PdfKurzVersionState(this.chapter);

  String assettoload;
  String url;



  bool _isLoading = false; //circular waiting symbol
  bool _isInit = true; //text
  PDFDocument document;

  //TODO: für alle Themen überarbeiten
  //TODO: loadFromUrl funktionieren lassen
  setAsset() {
    switch(chapter){
      case 'Motivation': assettoload = 'assets/placeholder.pdf'; break;
      case 'Behaviorismus': assettoload = 'assets/placeholder.pdf'; break;
      case 'Gedächtnis': assettoload = 'assets/placeholder.pdf'; break;
      case 'Informationstheorie': assettoload = 'assets/placeholder.pdf'; break;
      }

  }

  @override
  void initState() {
    super.initState();
    setAsset();
      try {
       // loadFromAssets().then((value) => print('geladen'));
        loadFromAssets().then((value) => print('geladen'));
      }
      catch(e){
        print(e);
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(chapter),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: _isInit
                    ? Text('Press button to load PDF file')
                    : _isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : PDFViewer(
                            document: document,
                          ), //vorgefertigtes Layout
              ),
            ),
          ],
        ));
  }

  Future<void> loadFromAssets() async {
    setState(() {
      _isInit = false; //remove Text
      _isLoading = true; // show loading
    });
    document = await PDFDocument.fromAsset(assettoload);
    setState(() {
      _isLoading = false; //remove loading
    });
  }

  /*Future<void> loadFromUrl() async {
    setState(() {
      _isInit = false; //remove Text
      _isLoading = true; // show loading
    });
    document = await PDFDocument.fromURL(url);
    setState(() {
      _isLoading = false; //remove loading
    });
  }*/






}
