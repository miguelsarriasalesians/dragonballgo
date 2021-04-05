import 'package:dragonballgo/widgets/text_container.dart';
import 'package:flutter/material.dart';

import 'ball_container.dart';

class RowBall extends StatelessWidget {
  final Color containerColor;
  final String ballImg;
  final String message;

  RowBall(this.containerColor, this.ballImg, this.message);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        BallContainer(containerColor, ballImg),
        TextContainer(containerColor, message)
      ],
    );
  }
}
