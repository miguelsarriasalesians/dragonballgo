import 'package:dragonballgo/resources/dimens.dart';
import 'package:dragonballgo/resources/palette_colors.dart';
import 'package:flutter/material.dart';

final regExpPattern = r'\[([^\]]+)\]\(([^\s\)]+)\)';
final regExp = RegExp(regExpPattern);

class CustomText extends StatelessWidget {
  final String text;
  final Color defaultColor;
  final double defaultFontSize;
  final FontWeight defaultFontWeight;
  final TextAlign defaultTextAlign;

  const CustomText(this.text, this.defaultColor, this.defaultFontSize,
      this.defaultFontWeight, this.defaultTextAlign,
      {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: _createTextSpans(text),
      ),
      textAlign: defaultTextAlign,
    );
  }

  List<TextSpan> _createTextSpans(String text) {
    return _generateElements(text).map(
      (e) {
        if (e.type == TextElementType.link) {
          return getText(e.text);
        }
        return TextSpan(
          text: e.text,
          style: TextStyle(
              color: defaultColor,
              fontSize: defaultFontSize,
              fontWeight: defaultFontWeight),
        );
      },
    ).toList();
  }

  TextSpan getText(String s) {
    final match = regExp.firstMatch(s);
    if (match?.groupCount == 2) {
      final text1 = match.group(1);
      final text2 = match.group(2);
      switch (text2) {
        case 'B':
          return TextSpan(
            text: text1,
            style: TextStyle(
                color: defaultColor,
                fontSize: defaultFontSize,
                fontWeight: Dimens.FONT_WEIGHT_BOLD),
          );
        case 'I':
          return TextSpan(
            text: text1,
            style: TextStyle(
                color: defaultColor,
                fontSize: defaultFontSize,
                fontWeight: defaultFontWeight,
                fontStyle: FontStyle.italic),
          );
        case 'C':
          return TextSpan(
            text: text1,
            style: TextStyle(
                color: PaletteColors.PRIMARY,
                fontSize: defaultFontSize,
                fontWeight: defaultFontWeight),
          );
        case 'BC':
          return TextSpan(
            text: text1,
            style: TextStyle(
                color: PaletteColors.PRIMARY,
                fontSize: defaultFontSize,
                fontWeight: Dimens.FONT_WEIGHT_BOLD),
          );
        case 'IC':
          return TextSpan(
            text: text1,
            style: TextStyle(
                color: PaletteColors.PRIMARY,
                fontSize: defaultFontSize,
                fontWeight: defaultFontWeight,
                fontStyle: FontStyle.italic),
          );
        case 'IB':
          return TextSpan(
            text: text1,
            style: TextStyle(
                color: defaultColor,
                fontSize: defaultFontSize,
                fontWeight: Dimens.FONT_WEIGHT_BOLD,
                fontStyle: FontStyle.italic),
          );
      }
    }
    return TextSpan(
      text: s,
      style: TextStyle(
          color: defaultColor,
          fontSize: defaultFontSize,
          fontWeight: defaultFontWeight),
    );
  }
}

List<TextElement> _generateElements(String text) {
  if (text.isNotEmpty != true) return [];

  final elements = <TextElement>[];

  final matches = regExp.allMatches(text);

  if (matches.isEmpty) {
    elements.add(TextElement(
      type: TextElementType.text,
      text: text,
    ));
  } else {
    var index = 0;
    matches.forEach((match) {
      if (match.start != 0) {
        elements.add(TextElement(
          type: TextElementType.text,
          text: text.substring(index, match.start),
        ));
      }
      elements.add(TextElement(
        type: TextElementType.link,
        text: match.group(0),
      ));
      index = match.end;
    });

    if (index < text.length) {
      elements.add(TextElement(
        type: TextElementType.text,
        text: text.substring(index),
      ));
    }
  }
  return elements;
}

enum TextElementType { text, link }

class TextElement {
  final TextElementType type;
  final String text;

  TextElement({this.type, this.text});
}
