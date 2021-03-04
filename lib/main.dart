import 'package:dragonballgo/resources/shared_preferences_consts.dart';
import 'package:dragonballgo/screens/login_screen.dart';
import 'package:dragonballgo/screens/main_screen.dart';
import 'package:dragonballgo/utils/session_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_translate/localization_delegate.dart';
import 'package:flutter_translate/localized_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

var prefLanguageCode;

void main() async {
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

  runApp(LocalizedApp(delegate, MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _sm = new SessionManager();

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
    return FutureBuilder(
        future: this.isLoggedIn(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return snapshot.hasData
              ? MaterialApp(
                  initialRoute: snapshot.data ? "/home" : "/",
                  routes: {
                    '/': (context) => LoginScreen(),
                    '/home': (context) => MainScreen()
                  },
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
                      accentColorBrightness: Brightness.light))
              : Scaffold(
                  backgroundColor: Colors.white,
                  body: Center(
                    child: new CircularProgressIndicator(),
                  ));
        });
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // tiempo d espera harcodeado
    return await Future.value(
            prefs.getString(SharedPreferencesConsts.TOKEN) != null)
        .timeout(const Duration(seconds: 3));
  }
}
