import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color color;
  final String text;
  final double height;
  final double width;
  final Color textColor;
  Function function;
  final FontWeight fontWeight;
  final double fontSize;
  CustomButton(
      {this.text = "pototo",
      this.color = Colors.blue,
      this.height = 50,
      this.width = 100,
      @required this.function,
      this.textColor = Colors.white,
      this.fontWeight = FontWeight.bold,
      this.fontSize = 20});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        this.function();
      },
      child: Container(
        child: Center(
          child: Text(
            this.text,
            style: TextStyle(
                color: this.textColor,
                fontWeight: this.fontWeight,
                fontSize: this.fontSize),
          ),
        ),
        height: this.height,
        width: this.width,
        decoration: BoxDecoration(
          color: this.color,
        ),
      ),
    );
  }
}
