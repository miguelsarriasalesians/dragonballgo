import 'package:dragonballgo/provider/api.dart';
import 'package:dragonballgo/resources/palette_colors.dart';
import 'package:dragonballgo/resources/routes.dart';
import 'package:dragonballgo/utils/router.dart';
import 'package:dragonballgo/widgets/custom_textfield.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class LoginScreen extends StatelessWidget {
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();

  void login(BuildContext ctx) {
    FetchLogin(emailController.text, passwordController.text).then((val) {
      if (val == 200) {
        AppRouter.router.pop(ctx);
        AppRouter.router.navigateTo(ctx, ScreenRoutes.BALLSLIST,
            transition: TransitionType.fadeIn,
            transitionDuration: Duration(milliseconds: 600));
      } else {
        String text;
        switch (val) {
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
    });
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
                            onPressed: () => login(context),
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
