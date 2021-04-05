import 'package:dragonballgo/objects/ball_model.dart';
import 'package:dragonballgo/screens/listBalls_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NavigationManager {
  BuildContext context;

  NavigationManager(BuildContext context) {
    this.context = context;
  }

  void openScreen(Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }

  void openScreenAsNew(Widget widget) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ),
        (route) => false);
  }

  void back() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      SystemNavigator.pop();
    }
  }

  void gotoListBallsScreen(List<BallModel> listOfBalls) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context) => ListBallsScreen(
                listOfBalls: listOfBalls,
              )),
      (Route<dynamic> route) => false,
    );
  }
}
