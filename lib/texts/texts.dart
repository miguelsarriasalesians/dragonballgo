import 'package:dragonballgo/resources/dimens.dart';
import 'package:dragonballgo/resources/palette_colors.dart';
import 'package:dragonballgo/texts/custom_text.dart';
import 'package:flutter/material.dart';

class TextTitle extends StatelessWidget {
  final String text;
  final Color color;
  final TextAlign textAlign;

  const TextTitle(this.text,
      {Key key,
      this.color = PaletteColors.TEXT,
      this.textAlign = TextAlign.start})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomText(text, color, Dimens.TEXT_SIZE_TITLE,
        Dimens.FONT_WEIGHT_LIGHT, textAlign);
  }
}

class TextBody extends StatelessWidget {
  final String text;
  final Color color;
  final TextAlign textAlign;

  const TextBody(this.text,
      {Key key,
      this.color = PaletteColors.TEXT,
      this.textAlign = TextAlign.start})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomText(text, color, Dimens.TEXT_SIZE_BODY,
        Dimens.FONT_WEIGHT_LIGHT, textAlign);
  }
}

class TextBodySmall extends StatelessWidget {
  final String text;
  final Color color;
  final TextAlign textAlign;

  const TextBodySmall(this.text,
      {Key key,
      this.color = PaletteColors.TEXT,
      this.textAlign = TextAlign.start})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomText(text, color, Dimens.TEXT_SIZE_BODY_SMALL,
        Dimens.FONT_WEIGHT_LIGHT, textAlign);
  }
}
