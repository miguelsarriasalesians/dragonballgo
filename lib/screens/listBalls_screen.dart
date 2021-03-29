import 'package:dragonballgo/objects/ball_model.dart';
import 'package:dragonballgo/provider/api.dart';
import 'package:dragonballgo/resources/palette_colors.dart';
import 'package:dragonballgo/resources/routes.dart';
import 'package:dragonballgo/screens/qrReader_screen.dart';
import 'package:dragonballgo/utils/router.dart';
import 'package:dragonballgo/utils/session_manager.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class ListBallsScreen extends StatefulWidget {
  ListBallsScreen({this.title});
  final Widget title;

  @override
  _ListBallsScreenState createState() => _ListBallsScreenState();
}

class _ListBallsScreenState extends State<ListBallsScreen> {
  SessionManager manager = new SessionManager();
  Map<String, dynamic> balls;
  List<BallModel> ballsList;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  Future<Map<String, dynamic>> getBalls() async {
    Future<dynamic> token = await manager.getToken().then((token) async {
      balls = await FetchBalls(
              latitude: 6.17790967, longitude: 16.17790967, token: token)
          .then((balls) {
        List<dynamic> list = balls.values.toList();
        ballsList = List<BallModel>.generate(balls["body"].length, (int index) {
          Map currentBall = balls["body"][index];
          return BallModel(
              id: currentBall["num"],
              latitude: currentBall["latitude"],
              longitude: currentBall["longitude"],
              date:
                  currentBall.containsKey("date") ? currentBall["date"] : null,
              image: currentBall.containsKey("image")
                  ? currentBall["image"]
                  : null);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // getBalls();

    return Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 80,
                    width: 260,
                    child: Image(
                        image: AssetImage(translate('listBalls_screen_title'))),
                  ),
                  InkWell(
                    child: Image(
                        width: 80,
                        image: AssetImage('assets/images/mcball.png')),
                    onTap: () => _scaffoldKey.currentState.openEndDrawer(),
                  ),
                  SizedBox(
                    width: 0,
                  )
                ],
              ),
              Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  children: [
                    RowBall(Colors.grey, 'assets/images/unknown_ball.png',
                        translate('information_ball')),
                    RowBall(Colors.orange, 'assets/images/ball_2.png',
                        'Has conseguido la bola 2!\nEl dia 21/03/2021'),
                    RowBall(Colors.grey, 'assets/images/unknown_ball.png',
                        translate('information_ball')),
                    RowBall(Colors.grey, 'assets/images/unknown_ball.png',
                        translate('information_ball')),
                    RowBall(Colors.grey, 'assets/images/unknown_ball.png',
                        translate('information_ball')),
                    RowBall(Colors.orange, 'assets/images/ball_6.png',
                        'Has conseguido la bola 6!\nEl dia 17/03/2021'),
                    RowBall(Colors.grey, 'assets/images/unknown_ball.png',
                        translate('information_ball')),
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
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            )
                          ]),
                    ),
                    onTap: () {
                      AppRouter.router.navigateTo(
                          context, ScreenRoutes.GOOGLEMAPS,
                          transition: TransitionType.fadeIn,
                          transitionDuration: Duration(milliseconds: 600));
                    },
                  ),
                  QrScanScreen(),
                ],
              ),
            ],
          ),
        ),
        backgroundColor: PaletteColors.APP_BACKGROUND,
        endDrawer: Container(
          width: 200,
          child: Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                    child: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image(
                          width: 80,
                          image: AssetImage('assets/images/mcball.png')),
                      Text(
                        'Guti Jedi',
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                )),
                ListTile(
                    leading: Icon(Icons.person),
                    title: Text(translate("profile_lbl")),
                    onTap: () {
                      AppRouter.router.pop(context);
                      AppRouter.router.navigateTo(context, ScreenRoutes.PROFILE,
                          transition: TransitionType.fadeIn,
                          transitionDuration: Duration(milliseconds: 600));
                    }),
                ListTile(
                    leading: Icon(Icons.menu_book),
                    title: Text(translate("statistics_lbl")),
                    onTap: () {
                      AppRouter.router.pop(context);
                      AppRouter.router.navigateTo(
                          context, ScreenRoutes.STATISTICS,
                          transition: TransitionType.fadeIn,
                          transitionDuration: Duration(milliseconds: 600));
                    }),
                ListTile(
                    leading: Icon(Icons.perm_media),
                    title: Text(translate("media_lbl")),
                    onTap: () {
                      AppRouter.router.pop(context);
                      AppRouter.router.navigateTo(context, ScreenRoutes.MEDIA,
                          transition: TransitionType.fadeIn,
                          transitionDuration: Duration(milliseconds: 600));
                    }),
                ListTile(
                    leading: Icon(Icons.language),
                    title: Text(translate("language_lbl")),
                    onTap: () {
                      AppRouter.router.pop(context);
                      AppRouter.router.navigateTo(
                          context, ScreenRoutes.SELECTLANGUAGE,
                          transition: TransitionType.fadeIn,
                          transitionDuration: Duration(milliseconds: 600));
                    }),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                ),
                ListTile(
                    trailing: Icon(Icons.logout),
                    title: Text(translate("logout_lbl")),
                    onTap: () {
                      manager.setToken(null);
                      AppRouter.router.pop(context);
                      AppRouter.router.navigateTo(context, ScreenRoutes.LOGIN,
                          transition: TransitionType.fadeIn,
                          transitionDuration: Duration(milliseconds: 600));
                    }),
                Text(
                  'Developed by MuchoCodigoIT\n © 2021 MuchoCodigo TM',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
        ));
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
