import 'dart:async';

import 'package:camera/camera.dart';
import 'package:dragonballgo/objects/ball_model.dart';
import 'package:dragonballgo/provider/api.dart';
import 'package:dragonballgo/screens/take_photo_screen.dart';
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

      int status = await FetchBallData(json: qrCode);
      if (status == 201) {
        // Obtain a list of the available cameras on the device.
        final cameras = await availableCameras();

        // Get a specific camera from the list of available cameras.
        final firstCamera = cameras.first;
        print(qrCode);
        List<BallModel> balls = await getBalls();
        print(balls);
        NavigationManager(context).openScreenAsNew(TakePictureScreen(
          camera: firstCamera,
          balls: balls,
        ));
      } else {}
    } on PlatformException {}
  }

  Future<List<BallModel>> getBalls() async {
    String token = await _sm.getToken();
    Map<String, dynamic> balls = await FetchBalls(
        latitude: 6.17790967, longitude: 16.17790967, token: token);

    // List<dynamic> list = balls.values.toList();
    List<BallModel> theBalls =
        List<BallModel>.generate(balls["body"].length, (int index) {
      Map currentBall = balls["body"][index];
      return BallModel(
          id: currentBall["num"],
          latitude: currentBall["latitude"],
          longitude: currentBall["longitude"],
          picked: currentBall["picked"],
          pickedDate:
              currentBall.containsKey("date") ? currentBall["date"] : null,
          image:
              currentBall.containsKey("image") ? currentBall["image"] : null);
    });
    return theBalls;
  }
}
