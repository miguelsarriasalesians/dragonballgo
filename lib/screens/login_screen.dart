import 'package:dragonballgo/objects/ball_model.dart';
import 'package:dragonballgo/provider/api.dart';
import 'package:dragonballgo/resources/palette_colors.dart';
import 'package:dragonballgo/resources/routes.dart';
import 'package:dragonballgo/utils/navigation_manager.dart';
import 'package:dragonballgo/utils/router.dart';
import 'package:dragonballgo/utils/session_manager.dart';
import 'package:dragonballgo/widgets/custom_textfield.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

import 'listBalls_screen.dart';

class LoginScreen extends StatelessWidget {
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();
  final SessionManager manager = new SessionManager();

  Future<void> login(BuildContext ctx) async {
    var val = await Login(
        email: emailController.text, password: passwordController.text);

    if (val.statusCode == 200) {
      await manager.setToken(val.data);
      changeAuthorizationToken(val.data);

      List<BallModel> balls = await getBalls();
      if (balls.length != 0 || balls.length != null) {
        NavigationManager(ctx).openScreenAsNew(ListBallsScreen(
          listOfBalls: balls,
        ));
      } else {
        print("EMPTY BODY");
      }
    } else {
      String text;
      switch (val.statusCode) {
        case 400:
          text = "invalid_form_data";
          break;
        case 401:
          text = "user_not_exists";
          break;
        case 500:
          text = "internal_error";
          break;
        default:
          text = "Error";
      }
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(translate(text)),
        duration: Duration(seconds: 3),
      ));
    }
  }

  Future<List<BallModel>> getBalls() async {
    var result = await FetchBalls(latitude: 5.123, longitude: 16.12);

    return listToBalls(result.data);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      Center(
                        child:
                            Image(image: AssetImage('assets/images/logo.png')),
                      ),
                      Center(
                        child: Text(
                          translate('login_screen_title'),
                          style: TextStyle(
                              fontFamily: "Rozanova",
                              color: PaletteColors.MAINCOLOR,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      CustomTextField(
                        context: context,
                        label: translate("email"),
                        type: TextInputType.emailAddress,
                        controller: emailController,
                      ),
                      CustomTextField(
                        context: context,
                        label: translate("password"),
                        type: TextInputType.visiblePassword,
                        controller: passwordController,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: PaletteColors.MAINCOLOR,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25))),
                            onPressed: () {
                              login(context);
                            },
                            child: Text(translate("login_screen_title"))),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("No tienes cuenta?"),
                              TextButton(
                                child: Text("Regístrate"),
                                onPressed: () {
                                  AppRouter.router.navigateTo(
                                      context, ScreenRoutes.REGISTER,
                                      transition: TransitionType.material,
                                      transitionDuration:
                                          Duration(milliseconds: 500));
                                },
                                style: TextButton.styleFrom(
                                    primary: PaletteColors.MAINCOLOR),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        onWillPop: () async => false);
  }
}
