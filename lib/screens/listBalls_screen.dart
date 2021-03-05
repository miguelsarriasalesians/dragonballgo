import 'package:dragonballgo/resources/palette_colors.dart';
import 'package:dragonballgo/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:dragonballgo/screens/google_maps_screen.dart';

class ListBallsScreen extends StatelessWidget {
  ListBallsScreen({this.title});

  // Fields in a Widget subclass are always marked "final".

  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaletteColors.APP_BACKGROUND,
      body: SafeArea(child: BallsBar()),
    );
  }
}

class BallsBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 80,
              width: 80,
              child: Image(image: AssetImage('assets/images/mcball.png')),
            ),
            Text(
              translate('listBalls_screen_title'),
              style: TextStyle(
                fontSize: 30,
                color: Colors.black,
              ),
            ),
            InkWell(
              child: Icon(
                Icons.account_circle,
                size: 50,
              ),
              onTap: () {
                //TODO LLEVA A LA CONFIGURACION DE TODA LA APP
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
            ),
          ],
        ),
        Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            children: [
              RowBall(),
              RowBall(),
              RowBall(),
              RowBall(),
              RowBall(),
              RowBall(),
              RowBall(),
            ],
          ),
        ),
        Row (
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              child: Container(
                height: 80,
                width: 80,
                child: Image(image: AssetImage('assets/images/world_map.png')),
              ),
              onTap: () {
                //TODO NAVEGAR AL MAPA
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GoogleMapScreen()),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}

class BallContainer extends StatefulWidget {
  final Color ContainerColorBall;
  final String ballImg;

  BallContainer(this.ContainerColorBall, this.ballImg);

  @override
  _BallContainerState createState() => _BallContainerState();
}

class _BallContainerState extends State<BallContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.height * 0.7) * 0.1425,
      width: (MediaQuery.of(context).size.width * 0.9) * 0.3,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black),
        color: widget.ContainerColorBall,
      ),
      child: Image(image: AssetImage(widget.ballImg)),
    );
  }
}

class TextContainer extends StatefulWidget {
  final Color ContainerColor;

  TextContainer(this.ContainerColor);

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
        alignment: Alignment.centerLeft,
        child: new Text(
          translate('information_ball'),
          style: TextStyle(
            color: PaletteColors.TEXT_BUTTON,
          ),
        ),
      ),
    );
  }
}

class RowBall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        BallContainer(Colors.grey, 'assets/images/unknown_ball.png'),
        TextContainer(Colors.grey)
      ],
    );
  }
}
