import 'package:dragonballgo/screens/close_balls_screen.dart';
import 'package:dragonballgo/screens/google_maps_screen.dart';
import 'package:dragonballgo/screens/listBalls_screen.dart';
import 'package:dragonballgo/screens/login_screen.dart';
import 'package:dragonballgo/screens/options_screen.dart';
import 'package:dragonballgo/screens/profile_screen.dart';
import 'package:dragonballgo/screens/qrReader_screen.dart';
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
  static final String PROFILE = "/profile";
  static final String GOOGLEMAPS = "/gmaps";
  static final String OPTIONS = "/options";
  static final String QRREADER = "/qrreader";
  static final String CLOSEBALL = "/closeball";

  static final _SPLASH = AppRoute(
      SPLASH, Handler(handlerFunc: (context, parameters) => LoadScreen()));

  static final _LOGIN = AppRoute(
      LOGIN, Handler(handlerFunc: (context, parameters) => LoginScreen()));

  static final _REGISTER = AppRoute(REGISTER,
      Handler(handlerFunc: (context, parameters) => RegisterScreen()));

  static final _BALLSLIST = AppRoute(BALLSLIST,
      Handler(handlerFunc: (context, parameters) => ListBallsScreen()));

  static final _GOOGLEMAPS = AppRoute(GOOGLEMAPS,
      Handler(handlerFunc: (context, parameters) => GoogleMapScreen()));

  static final _SELECTLANGUAGE = AppRoute(SELECTLANGUAGE,
      Handler(handlerFunc: (context, parameters) => SelectLanguageScreen()));

  static final _PROFILE = AppRoute(
      PROFILE, Handler(handlerFunc: (context, parameters) => ProfileScreen()));

  static final _OPTIONS = AppRoute(
      OPTIONS, Handler(handlerFunc: (context, parameters) => OptionsScreen()));

  static final _QRREADER = AppRoute(
      QRREADER, Handler(handlerFunc: (context, parameters) => QrScan()));

  static final _CLOSEBALL = AppRoute(QRREADER,
      Handler(handlerFunc: (context, parameters) => CloseBallsScreen()));

  static final List<AppRoute> routes = [
    _SPLASH,
    _LOGIN,
    _REGISTER,
    _BALLSLIST,
    _SELECTLANGUAGE,
    _PROFILE,
    _GOOGLEMAPS,
    _OPTIONS,
    _QRREADER,
    _CLOSEBALL
  ];
}
