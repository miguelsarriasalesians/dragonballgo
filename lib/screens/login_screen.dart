import 'package:dragonballgo/provider/api.dart';
import 'package:dragonballgo/resources/palette_colors.dart';
import 'package:dragonballgo/resources/routes.dart';
import 'package:dragonballgo/utils/session_manager.dart';
import 'package:dragonballgo/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class LoginScreen extends StatelessWidget {
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();

  final SessionManager _sm = new SessionManager();

  void login(BuildContext context) {
    FetchLogin(emailController.text, passwordController.text).then((val) {
      if (val == 200)
        Navigator.pushNamed(context, ScreenRoutes.BALLSLIST);
      else {
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
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(translate(text)),
          duration: Duration(seconds: 5),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Image(image: AssetImage('assets/images/logo.png'))),
              Padding(
                child: Text(
                  translate('login_screen_title'),
                  style: TextStyle(
                      fontFamily: "Rozanova",
                      color: PaletteColors.MAINCOLOR,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                padding: EdgeInsets.all(10),
              ),
              Padding(
                child: CustomTextField(
                  context: context,
                  label: translate("email"),
                  type: TextInputType.emailAddress,
                  controller: emailController,
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              ),
              Padding(
                child: CustomTextField(
                  context: context,
                  label: translate("password"),
                  type: TextInputType.visiblePassword,
                  controller: passwordController,
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: PaletteColors.MAINCOLOR),
                      onPressed: () => login(context),
                      child: Text(translate("login_screen_title"))),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              ),
              Padding(
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Color(0x00000000)),
                      onPressed: () =>
                          Navigator.pushNamed(context, ScreenRoutes.REGISTER),
                      child: Text(translate("register"))),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
        ),
      );
}
