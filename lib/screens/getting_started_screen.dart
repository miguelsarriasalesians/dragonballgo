import 'package:dragonballgo/resources/palette_colors.dart';
import 'package:dragonballgo/views/icon_language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class GettingStartedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          translate('getting_started_screen_title'),
          style: TextStyle(
            color: PaletteColors.TEXT_BUTTON,
          ),
        ),
        backgroundColor: PaletteColors.PRIMARY,
        actions: [IconLanguage()],
      ),
      body: SingleChildScrollView(),
    );
  }
}
