import 'dart:async';

import 'package:dragonballgo/resources/routes.dart';
import 'package:dragonballgo/utils/router.dart';
import 'package:dragonballgo/utils/session_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_translate/localization_delegate.dart';
import 'package:flutter_translate/localized_app.dart';

var prefLanguageCode;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SessionManager().getCountry().then((language) {
    if (language != null) {
      print("Language of shared preferencies " + language);
      prefLanguageCode = language;
    }
  });

  var delegate = await LocalizationDelegate.create(
      fallbackLocale: 'es',
      supportedLocales: ['en', 'es'],
      basePath: 'locale/i18n');

  // await SentryFlutter.init(
  //   (options) => options.dsn =
  //       'https://a39c138a5d9f4145b284ff7e7da8a462@o547290.ingest.sentry.io/5669562',
  //   appRunner: () => runApp(LocalizedApp(delegate, MyApp())),
  // );
  runApp(LocalizedApp(delegate, MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    AppRouter appRouter = AppRouter(
      routes: ScreenRoutes.routes,
    );

    appRouter.setupRoutes();
  }

  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;

    if (prefLanguageCode != null) {
      print('prefLanguageCode ' + prefLanguageCode);
      localizationDelegate.changeLocale(new Locale(prefLanguageCode, ''));
    }

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
        onGenerateRoute: AppRouter.router.generator,
        localizationsDelegates: [
          localizationDelegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: localizationDelegate.supportedLocales,
        locale: prefLanguageCode == null
            ? localizationDelegate.currentLocale
            : new Locale(prefLanguageCode, ''),
        theme: ThemeData(
            appBarTheme: AppBarTheme(brightness: Brightness.light),
            primaryColor: Colors.white,
            accentColor: Colors.blue,
            accentColorBrightness: Brightness.light));
  }
}
