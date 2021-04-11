import 'dart:async';

import 'package:dragonballgo/objects/ball_model.dart';
import 'package:dragonballgo/provider/api.dart';
import 'package:dragonballgo/screens/listBalls_screen.dart';
import 'package:dragonballgo/screens/login_screen.dart';
import 'package:dragonballgo/utils/navigation_manager.dart';
import 'package:dragonballgo/utils/session_manager.dart';
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

class LinearProgressIndicatorAppState
    extends State<LinearProgressIndicatorApp> {
  bool _loading;
  double _progressValue;

  final _sm = SessionManager();

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
                    width: MediaQuery.of(context).size.width * 0.9,
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
                    child: Image(
                        image: AssetImage('assets/images/splashAnimation.gif')),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.01,
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.yellow[300],
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.orange),
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
                    child: Text(
                      translate(
                          'Developed by MuchoCodigoIT\n © 2021 MuchoCodigo TM'),
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

  Future<List<BallModel>> getBalls() async {
    var result = await FetchBalls(latitude: 5.123, longitude: 16.12);

    return listToBalls(result.data);
  }

  // this function updates the progress value
  _updateProgress() async {
    const oneSec = const Duration(seconds: 1);
    final token = await this._sm.getToken();
    var result = false;

    if (token != null) {
      var validation = await ValidateToken(token);
      if (validation.statusCode == 200) result = true;
    }

    new Timer.periodic(oneSec, (Timer t) async {
      setState(() {
        _progressValue += 0.2;
      });
      if (_progressValue.toStringAsFixed(1) == '1.0') {
        _loading = false;
        t.cancel();
        // AppRouter.router.pop(context);

        //Get balls
        if (result) {
          List<BallModel> balls = await getBalls();

          NavigationManager(context).openScreenAsNew(ListBallsScreen(
            listOfBalls: balls,
          ));
        } else {
          NavigationManager(context).openScreenAsNew(LoginScreen());
        }
      }
    });
  }
}
