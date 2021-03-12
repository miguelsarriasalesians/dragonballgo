import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';

class QrScan extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return QrScanState();
  }
}

class QrScanState extends State<QrScan> {
  String qrResult = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Lector QR flutter'),
          centerTitle: true,
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                "RESULT",
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text(
                qrResult,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0),
              )
            ],
          ),
        ));
  }
}
