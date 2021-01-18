import 'package:dragonballgo/resources/palette_colors.dart';
import 'package:dragonballgo/screens/main_screen.dart';
import 'package:dragonballgo/texts/texts.dart';
import 'package:dragonballgo/utils/session_manager.dart';
import 'package:dragonballgo/views/app_button.dart';
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
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          translate('select_language'),
          style: TextStyle(
            color: PaletteColors.TEXT_BUTTON,
          ),
        ),
        backgroundColor: PaletteColors.PRIMARY,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Image.asset(
                  'assets/images/mundo.png',
                  color: PaletteColors.PRIMARY,
                  height: 150,
                ),
              ),
              getButton('language_english', 'en'),
              getButton('language_spanish', 'es'),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: AppButton(
                    name: translate('next_button'),
                    onPressed: () => Navigator.of(context).pushReplacement(
                        new MaterialPageRoute(
                            builder: (BuildContext context) => MainScreen())),
                  )),
            ],
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
        textAlign: TextAlign.center,
      ),
      onPressed: () {
        Locale selectedLocale;
        if (languageCode == 'en') {
          print("changing to english");
          saveLanguage('en');
          selectedLocale = new Locale('en', '');
        } else if (languageCode == 'es') {
          print("changing to spanish");
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
