import 'package:dragonballgo/resources/palette_colors.dart';
import 'package:flutter/material.dart';

class TextContainer extends StatefulWidget {
  final Color ContainerColor;
  final String message;

  TextContainer(this.ContainerColor, this.message);

  @override
  _TextContainerState createState() => _TextContainerState();
}

class _TextContainerState extends State<TextContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.height * 0.7) * 0.1426,
      width: (MediaQuery.of(context).size.width * 0.9) * 0.65,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black),
        color: widget.ContainerColor,
      ),
      child: Align(
        alignment: Alignment.center,
        child: new Text(
          widget.message,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: PaletteColors.TEXT_BUTTON,
          ),
        ),
      ),
    );
  }
}
