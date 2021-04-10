import 'package:dragonballgo/objects/ball_model.dart';
import 'package:dragonballgo/provider/api.dart';
import 'package:dragonballgo/resources/palette_colors.dart';
import 'package:dragonballgo/resources/routes.dart';
import 'package:dragonballgo/screens/google_maps_screen.dart';
import 'package:dragonballgo/screens/profile_screen.dart';
import 'package:dragonballgo/screens/qrReader_screen.dart';
import 'package:dragonballgo/utils/navigation_manager.dart';
import 'package:dragonballgo/utils/router.dart';
import 'package:dragonballgo/utils/session_manager.dart';
import 'package:dragonballgo/widgets/row_ball.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class ListBallsScreen extends StatefulWidget {
  ListBallsScreen({this.title, this.listOfBalls});
  final Widget title;
  final List<BallModel> listOfBalls;

  @override
  _ListBallsScreenState createState() => _ListBallsScreenState();
}

class _ListBallsScreenState extends State<ListBallsScreen> {
  SessionManager manager = new SessionManager();
  Map<String, dynamic> balls;
  bool isLoading = true;
  List<BallModel> ballsList;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<RowBall> rowBalls;

  @override
  void initState() {
    setState(() {});
    ballsList = widget.listOfBalls;
    rowBalls = List.generate(ballsList.length, (index) {
      BallModel currentBall = ballsList[index];
      int ballId = currentBall.id;
      String imageRoute = currentBall.id != null
          ? "assets/images/ball_$ballId.png"
          : "assets/images/unknown_ball.png";
      Color rowColor = currentBall.picked == true ? Colors.orange : Colors.grey;
      String message = currentBall.picked == true
          ? "Has conseguido la bola $ballId!\nEl dia ${currentBall.pickedDate}"
          : translate('information_ball');

      return RowBall(
        rowColor,
        imageRoute,
        message,
      );
    });
  }

  Future<List<BallModel>> getBalls() async {
    String token = await manager.getToken();
    Map<String, dynamic> balls = await FetchBalls(
        latitude: 6.17790967, longitude: 16.17790967, token: token);

    // List<dynamic> list = balls.values.toList();
    List<BallModel> theBalls =
        List<BallModel>.generate(balls["body"].length, (int index) {
      Map currentBall = balls["body"][index];
      return BallModel(
          id: currentBall["num"],
          latitude: currentBall["latitude"],
          longitude: currentBall["longitude"],
          pickedDate:
              currentBall.containsKey("date") ? currentBall["date"] : null,
          image:
              currentBall.containsKey("image") ? currentBall["image"] : null);
    });
    ballsList = theBalls;

    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
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
              SingleChildScrollView(
                child: Column(
                  children: rowBalls,
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
                      NavigationManager(context)
                          .openScreenAsNew(GoogleMapScreen(
                        listOfBalls: this.ballsList,
                      ));
                      // AppRouter.router.navigateTo(
                      //     context, ScreenRoutes.GOOGLEMAPS,
                      //     transition: TransitionType.fadeIn,
                      //     transitionDuration: Duration(milliseconds: 600));
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
                    ],
                  ),
                )),
                ListTile(
                    leading: Icon(Icons.person),
                    title: Text(translate("profile_lbl")),
                    onTap: () async {
                      Map<String, dynamic> userInfo = await FetchUserInfo();
                      userInfo = userInfo[ResponseKeys.BODY];
                      String email, name, birthday, profilePic;
                      email = userInfo["email"];
                      name = userInfo["name"];
                      birthday = userInfo["birthdate"];
                      birthday = birthday.substring(0, 10);
                      profilePic = userInfo["profilepic"];
                      NavigationManager(context).openScreen(ProfileScreen(
                        name: name,
                        email: email,
                        birthday: birthday,
                        profilePic: profilePic,
                      ));
                      // AppRouter.router.pop(context);
                      // AppRouter.router.navigateTo(context, ScreenRoutes.PROFILE,
                      //     transition: TransitionType.fadeIn,
                      //     transitionDuration: Duration(milliseconds: 600));
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

    // }
  }
}
