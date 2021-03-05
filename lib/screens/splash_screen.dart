import 'dart:async';
import 'package:dragonballgo/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/global.dart';

class LoadScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LinearProgressIndicatorApp(),
    );
  }
}

class LinearProgressIndicatorApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LinearProgressIndicatorAppState();
  }
}

class LinearProgressIndicatorAppState extends State<LinearProgressIndicatorApp> {
  bool _loading;
  double _progressValue;

  @override
  void initState() {
    super.initState();
    _loading = true;
    _progressValue = 0.0;
    _updateProgress();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width* 0.9,
                    child: Image(image: AssetImage('assets/images/logo.png')),
                  ),
                  //Image(image: AssetImage('assets/images/mcball.png')),
                  /*Container(
                    margin: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                    child : Text(
                      translate('splash_message'),
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                      ),
                    ),
                  ),*/

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Image(image: AssetImage('assets/images/splashAnimation.gif')),
                  ),
                  //Image(image: AssetImage('assets/images/mcball.png')),
                  /*Container(
                    margin: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                    child : Text(
                      translate('splash_message'),
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                      ),
                    ),
                  ),*/

                ],
              ),
              Row(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.01,
                      child:
                      LinearProgressIndicator(
                        backgroundColor: Colors.yellow[300],
                        valueColor: new AlwaysStoppedAnimation<Color>(Colors.orange),
                        value: _progressValue,
                      )),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child:
                      Text(
                        translate('Developed by MuchoCodigoIT\n © 2021 MuchoCodigo TM'),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                  ),
                ],
              )
            ],
            ),
          ),
        ),
      );
  }
  // this function updates the progress value
  void _updateProgress() {
    const oneSec = const Duration(seconds: 1);
    new Timer.periodic(oneSec, (Timer t) {
      setState(() {
        _progressValue += 0.2;
        // we "finish" downloading here
        if (_progressValue.toStringAsFixed(1) == '1.0') {
          _loading = false;
          t.cancel();
          return Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        }
      });
    });
  }
}