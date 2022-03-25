// import 'package:share_plus/share.dart';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';




class PdfPreviewScreen extends StatefulWidget {
  final String path;

  PdfPreviewScreen({required this.path});

  @override
  State<PdfPreviewScreen> createState() => _PdfPreviewScreenState();
}

class _PdfPreviewScreenState extends State<PdfPreviewScreen> {
  @override
  ReceivePort _receivePort = ReceivePort();
  static downloadingCallback(id, status, progress) {
    ///Looking up for a send port
    SendPort? sendPort = IsolateNameServer.lookupPortByName("downloading");

    ///sending the data
    sendPort!.send([id, status, progress]);
  }

  Future sharePdf(String filePath) async {
    Share.shareFiles(['$filePath']);
  }

  @override
  void initState() {
    // getPermission();
    super.initState();
    IsolateNameServer.registerPortWithName(
        _receivePort.sendPort, "downloading");

    ///Listening for the data is coming other isolates
    _receivePort.listen((message) {
      setState(() {
        progress = message[2];
      });

      print(progress);
    });

    FlutterDownloader.registerCallback(downloadingCallback);
  }

  int progress = 0;
  var dio = Dio();
  // final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  Widget build(BuildContext context) {
    return PDFViewerScaffold(
      // key: widget.key,
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios),
          onPressed: () {
            print("go to home page");
            Navigator.pop(context);
          },
        ),
        title: Text("Certificate"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.file_download),
            tooltip: 'Download file',
            onPressed: () async {
              // _downloadFile(widget.url);
              print("download");
              //start
              String name = "${DateTime.now().millisecondsSinceEpoch}.pdf";
              final status = await Permission.storage.request();

              if (status.isGranted) {
                final externalDir = await getExternalStorageDirectory();

                final id = await FlutterDownloader.enqueue(
                  url: widget.path,
                  savedDir: externalDir!.path,
                  fileName: name,
                  showNotification: true,
                  openFileFromNotification: true,
                );
                debugPrint(id);
              } else {
                print("Permission denied");
              }

              //end
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            tooltip: 'Share file',
            onPressed: () {
              print("download");
              sharePdf(widget.path);
            },
          ),
        ],
      ),
      path: widget.path,
    );
  }
}
