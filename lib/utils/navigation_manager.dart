import 'package:dragonballgo/screens/main_screen.dart';
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

  void goToMainScreen() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => MainScreen()),
      (Route<dynamic> route) => false,
    );
  }
}
