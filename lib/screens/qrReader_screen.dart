import 'dart:async';

import 'package:camera/camera.dart';
import 'package:dragonballgo/objects/ball_model.dart';
import 'package:dragonballgo/provider/api.dart';
import 'package:dragonballgo/screens/choose_image_screen.dart';
import 'package:dragonballgo/utils/navigation_manager.dart';
import 'package:dragonballgo/utils/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_translate/global.dart';

class QrScanScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QrPageState();
}

class _QrPageState extends State<QrScanScreen> {
  SessionManager _sm = SessionManager();
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
              translate('add_button'),
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

      var resp = await PickBall(qrCode);
      if (resp.statusCode == 201) {
        // Obtain a list of the available cameras on the device.
        final cameras = await availableCameras();

        // Get a specific camera from the list of available cameras.
        final firstCamera = cameras.first;
        print(qrCode);
        List<BallModel> balls = await getBalls();
        print(balls);
        NavigationManager(context).openScreenAsNew(ImageUpload());
      } else {}
    } on PlatformException {}
  }

  Future<List<BallModel>> getBalls() async {
    var result = await FetchBalls(latitude: 5.123, longitude: 16.12);

    return listToBalls(result.data);
  }
}
