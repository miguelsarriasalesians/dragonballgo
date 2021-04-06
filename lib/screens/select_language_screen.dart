import 'package:dragonballgo/resources/palette_colors.dart';
import 'package:dragonballgo/texts/texts.dart';
import 'package:dragonballgo/utils/navigation_manager.dart';
import 'package:dragonballgo/utils/session_manager.dart';
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
                  translate('select_lang_title'),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Text(
                  translate('select_lang_desc'),
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
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                getButton('language_french', 'fr'),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                getButton('language_italian', 'it'),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                getButton('language_german', 'gr'),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                InkWell(
                  child: Container(
                    height: 30,
                    width: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
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
                    NavigationManager(context).back();
                  },
                )
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
        } else {
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
