import 'package:dragonballgo/resources/palette_colors.dart';
import 'package:dragonballgo/resources/routes.dart';
import 'package:dragonballgo/screens/google_maps_screen.dart';
import 'package:dragonballgo/utils/router.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:dragonballgo/models/ball.dart';
import 'package:dragonballgo/provider/api.dart';

class ListBallsScreen extends StatefulWidget {
  ListBallsScreen({this.title});

  final Widget title;

  @override
  _ListBallsScreenState createState() => _ListBallsScreenState();
}

class _ListBallsScreenState extends State<ListBallsScreen> {

  /*@override
  void initState() {
    loading = false;
  }

  bool loading;
  List<BallModel> balls;*/

  Future<List<BallModel>> getBalls(BuildContext ctx) async {
    print("fetcheando");
    final result = await FetchBalls();
    /*print(result);
    if (result is List<BallModel>)
      return result;
    else {
      String msg;
      switch (result) {
        case 401:
          msg = "No autorizado";
          break;
        case 404:
          msg = "No hay bolas :(";
          break;
        default:
          msg = "No se que error";
          break;
      }
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(msg),
        duration: Duration(seconds: 3),
      ));
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaletteColors.APP_BACKGROUND,
      body: SafeArea(
        child: Column(
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
                    Icons.settings_system_daydream,
                    size: 30,
                  ),
                  onTap: () {
                    AppRouter.router.navigateTo(context, ScreenRoutes.PROFILE,
                        transition: TransitionType.material,
                        transitionDuration: Duration(milliseconds: 500));
                  },
                ),
              ],
            ),
            Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width * 0.9,
              child: FutureBuilder(
                future: this.getBalls(context),
                builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                  return Column(
                    children: snapshot.hasData
                        ? snapshot.data.map((BallModel x) => RowBall())
                        : [
                            RowBall(),
                            RowBall(),
                            RowBall(),
                            RowBall(),
                            RowBall(),
                            RowBall(),
                            RowBall(),
                          ],
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  child: Container(
                    height: 80,
                    width: 80,
                    child:
                        Image(image: AssetImage('assets/images/world_map.png')),
                  ),
                  onTap: () {
                    AppRouter.router.navigateTo(
                        context, ScreenRoutes.GOOGLEMAPS,
                        transition: TransitionType.inFromBottom,
                        transitionDuration: Duration(milliseconds: 800));
                  },
                ),
              ],
            ),
          ],
        ),
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
