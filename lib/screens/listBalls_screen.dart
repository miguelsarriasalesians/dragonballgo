import 'package:dragonballgo/resources/palette_colors.dart';
import 'package:dragonballgo/resources/routes.dart';
import 'package:dragonballgo/screens/google_maps_screen.dart';
import 'package:dragonballgo/screens/qrReader_screen.dart';
import 'package:dragonballgo/utils/router.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_translate/flutter_translate.dart';

class ListBallsScreen extends StatelessWidget {
  ListBallsScreen({this.title});

  // Fields in a Widget subclass are always marked "final".

  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: BallsBar()),
      backgroundColor: PaletteColors.APP_BACKGROUND,
    );
  }
}

class BallsBar extends StatelessWidget {
  String qrCode = 'Unknown';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 70,
                width: 70,
                child: Image(image: AssetImage('assets/images/mcball.png')),
              ),
              Container(
                height: 80,
                width: 220,
                child: Image(
                    image: AssetImage(translate('listBalls_screen_title'))),
              ),
              InkWell(
                child: Icon(
                  Icons.menu_sharp,
                  size: 50,
                ),
                onTap: () {
                  AppRouter.router.navigateTo(context, ScreenRoutes.OPTIONS,
                      transition: TransitionType.fadeIn,
                      transitionDuration: Duration(milliseconds: 800));
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                child: Container(
                  width: 120,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.map_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Mapa',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        )
                      ]),
                ),
                onTap: () {
                  AppRouter.router.navigateTo(context, ScreenRoutes.GOOGLEMAPS,
                      transition: TransitionType.fadeIn,
                      transitionDuration: Duration(milliseconds: 600));
                },
              ),
              QrScan(),
            ],
          ),
        ],
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => GoogleMapScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
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
