import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class QrScan extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QrPageState();
}

class _QrPageState extends State<QrScan> {
  String qrCode = 'Unknown';
  @override
  Widget build(BuildContext context) => InkWell(
      child: Container(
        width: 120,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Añadir',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]),
      ),
      onTap: () => scanQRCode());

  Future<void> scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );

      if (!mounted) return;

      setState(() {
        this.qrCode = qrCode;
      });
    } on PlatformException {
      qrCode = 'Failed to get platform version.';
    }
  }
}
