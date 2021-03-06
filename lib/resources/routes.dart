import 'package:dragonballgo/screens/listBalls_screen.dart';
import 'package:dragonballgo/screens/login_screen.dart';
import 'package:dragonballgo/screens/register_screen.dart';
import 'package:dragonballgo/screens/select_language_screen.dart';
import 'package:dragonballgo/screens/splash_screen.dart';
import 'package:fluro/fluro.dart';

class ScreenRoutes {
  static final String SPLASH = "/";
  static final String LOGIN = "/login";
  static final String HOME = "/home";
  static final String REGISTER = "/register";
  static final String BALLSLIST = "/ballslist";
  static final String SELECTLANGUAGE = "/selectlang";

  static final _SPLASH = AppRoute(
      SPLASH, Handler(handlerFunc: (context, parameters) => LoadScreen()));

  static final _LOGIN = AppRoute(
      LOGIN, Handler(handlerFunc: (context, parameters) => LoginScreen()));

  static final _REGISTER = AppRoute(REGISTER,
      Handler(handlerFunc: (context, parameters) => RegisterScreen()));

  static final _BALLSLIST = AppRoute(BALLSLIST,
      Handler(handlerFunc: (context, parameters) => ListBallsScreen()));

  static final _SELECTLANGUAGE = AppRoute(SELECTLANGUAGE,
      Handler(handlerFunc: (context, parameters) => SelectLanguageScreen()));

  static final List<AppRoute> routes = [
    _SPLASH,
    _LOGIN,
    _REGISTER,
    _BALLSLIST,
    _SELECTLANGUAGE
  ];
}
