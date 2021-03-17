import 'package:dragonballgo/resources/palette_colors.dart';
import 'package:dragonballgo/resources/routes.dart';
import 'package:dragonballgo/texts/texts.dart';
import 'package:dragonballgo/utils/router.dart';
import 'package:dragonballgo/utils/session_manager.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/global.dart';
import 'package:flutter_translate/localized_app.dart';

class SelectLanguageScreen extends StatefulWidget {
  @override
  _SelectLanguageScreenState createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaletteColors.APP_BACKGROUND,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Text(
                  'IDIOMA DE LA APP',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Text(
                  'Cambia el idioma de visualización de la app. Por omisión, utiliza el idioma de tu dispositivo. El idioma acabará de cambiarse cuando reinicies DragonBallGo',
                  style: TextStyle(),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                getButton('language_english', 'en'),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                getButton('language_spanish', 'es'),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
                InkWell(
                  child: Container(
                    height: 30,
                    width: MediaQuery.of(context).size.height * 0.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.orange),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        translate('back_lbl'),
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ),
                  onTap: () {
                    AppRouter.router.pop(context);
                    AppRouter.router.navigateTo(context, ScreenRoutes.BALLSLIST,
                        transition: TransitionType.fadeIn,
                        transitionDuration: Duration(milliseconds: 600));
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Image(
                    width: MediaQuery.of(context).size.height * 0.4,
                    image: AssetImage('assets/images/logo.png'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  getButton(String textButton, String languageCode) {
    var localizationDelegate = LocalizedApp.of(context).delegate;
    return FlatButton(
      child: TextBodySmall(
        translate(textButton),
        color: localizationDelegate.currentLocale.languageCode == languageCode
            ? PaletteColors.PRIMARY
            : PaletteColors.TEXT,
      ),
      onPressed: () {
        Locale selectedLocale;
        if (languageCode == 'en') {
          saveLanguage('en');
          selectedLocale = new Locale('en', '');
        } else if (languageCode == 'es') {
          saveLanguage('es');
          selectedLocale = new Locale('es', '');
        }
        localizationDelegate.changeLocale(selectedLocale);
        Future.delayed(new Duration(seconds: 1), () {
          setState(() {});
        });
      },
    );
  }

  saveLanguage(String languageCode) async {
    await SessionManager().setCountry(languageCode);
  }
}
