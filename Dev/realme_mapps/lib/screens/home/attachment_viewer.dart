import 'dart:async';

import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

import 'package:photo_view/photo_view.dart';

class AttachmentViewer extends StatefulWidget {
  const AttachmentViewer(
      {Key key, @required this.baHeader, @required this.baValue})
      : super(key: key);
  final String baValue;
  final String baHeader;
  @override
  _AttachmentViewerState createState() =>
      _AttachmentViewerState(baHeader, baValue);
}

class _AttachmentViewerState extends State<AttachmentViewer> {
  String baValue;
  String baHeader;
  _AttachmentViewerState(this.baHeader, this.baValue);
  static ScrollController _hideButtonController;

  String username;
  String _jwt;
  bool _isLoading = true;
  PDFDocument document;

  @override
  void initState() {
    super.initState();
    if (baHeader == "pdf") {
      loadDoc();
    }
  }

  loadDoc() async {
    setState(() => _isLoading = true);
    document = await PDFDocument.fromURL(baValue)
        .catchError((onError) => {print("error")});
    setState(() => _isLoading = false);
  }

  realViewer() {
    if (baHeader != "pdf") {
      return Container(
          child: PhotoView(
        imageProvider: NetworkImage(baValue),
      ));
    } else {
      return Center(
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : PDFViewer(
                  document: document,
                  zoomSteps: 1,
                ));
    }
  }

  @override
  Widget build(BuildContext context) {
    print("initializing..");
    print(baValue);
    return Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'assets/images/onapps_text.png',
            fit: BoxFit.contain,
            height: 100,
          ),
          //centerTitle: true,
          elevation: 0,

          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                  Color(0xFFFFC914),
                  Color(0xFFFFC914),
                ])),
          ),
        ),
        body: realViewer());
  }
}
