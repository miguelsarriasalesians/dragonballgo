import 'package:dragonballgo/resources/dimens.dart';
import 'package:dragonballgo/resources/palette_colors.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final Function onPressed;
  final String name;
  final Color color;
  final Color textColor;

  final double verticalPadding;
  final double horitzontalPadding;

  const AppButton(
      {Key key,
      this.onPressed,
      this.name,
      this.color = PaletteColors.PRIMARY,
      this.verticalPadding = Dimens.PADDING_BASE,
      this.horitzontalPadding = Dimens.PADDING_LARGE,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Dimens.PADDING_LARGE),
      child: ButtonTheme(
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(Dimens.RADIUS_BUTTONS),
          ),
          color: color,
          onPressed: onPressed,
          padding: EdgeInsets.symmetric(
              vertical: verticalPadding, horizontal: horitzontalPadding),
          child: Text(
            name.toUpperCase(),
            style: TextStyle(
              fontSize: Dimens.TEXT_BUTTON,
              color: textColor ?? PaletteColors.TEXT_BUTTON,
              fontWeight: Dimens.FONT_WEIGHT_BOLD,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
