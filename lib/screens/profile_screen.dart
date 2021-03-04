import 'package:dragonballgo/resources/palette_colors.dart';
import 'package:dragonballgo/views/icon_language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaletteColors.APP_BACKGROUND,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          translate('profile_screen_title'),
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
