import 'package:dragonballgo/resources/dimens.dart';
import 'package:dragonballgo/resources/palette_colors.dart';
import 'package:dragonballgo/texts/texts.dart';
import 'package:dragonballgo/views/icon_language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class InformationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          translate('information_screen_title'),
          style: TextStyle(
            color: PaletteColors.TEXT_BUTTON,
          ),
        ),
        backgroundColor: PaletteColors.PRIMARY,
        actions: [IconLanguage()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(Dimens.PADDING_LARGE),
        child: SingleChildScrollView(
          child: TextBody(translate('information_content')),
        ),
      ),
    );
  }
}
