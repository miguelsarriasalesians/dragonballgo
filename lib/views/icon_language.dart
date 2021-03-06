import 'package:dragonballgo/resources/palette_colors.dart';
import 'package:dragonballgo/resources/routes.dart';
import 'package:dragonballgo/utils/router.dart';
import 'package:flutter/material.dart';

class IconLanguage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset(
        'assets/images/language_icon.png',
        color: PaletteColors.TEXT_BUTTON,
        height: 30,
      ),
      onPressed: () =>
          AppRouter.router.navigateTo(context, ScreenRoutes.SELECTLANGUAGE),
    );
  }
}
