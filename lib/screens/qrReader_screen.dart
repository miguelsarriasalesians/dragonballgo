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
      String qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );
      // qrCode = qrCode.toString();
      // String alternativa =
      //     '{"iv":"1cd83a854688b8d0df6193b606907bd7","encryptedData":"a882f4b74b4d125af312faeed78edaeff4ca5fc5c59748d878adc6713db6e90bcdd7f41ac9363a4c60dcbfcb5e0aaebbaf100506f7aa1da331ac400b9d0c8f9d"}';
      //
      // qrCode = qrCode ?? alternativa;

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
