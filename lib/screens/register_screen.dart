import 'package:dragonballgo/provider/api.dart';
import 'package:dragonballgo/resources/palette_colors.dart';
import 'package:dragonballgo/resources/routes.dart';
import 'package:dragonballgo/utils/router.dart';
import 'package:dragonballgo/utils/session_manager.dart';
import 'package:dragonballgo/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class RegisterScreen extends StatelessWidget {
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();
  final nameController = new TextEditingController();
  final birthdateController = new TextEditingController();

  final manager = new SessionManager();

  void register(BuildContext ctx) {
    Register(
            email: emailController.text,
            password: passwordController.text,
            name: nameController.text,
            birthdate: birthdateController.text)
        .then((val) async {
      if (val.statusCode == 200) {
        await manager.setToken(val.data);
        changeAuthorizationToken(val.data);

        AppRouter.router.navigateTo(ctx, ScreenRoutes.BALLSLIST);
      } else {
        String text;
        switch (val.statusCode) {
          case 400:
            text = "invalid_form_data";
            break;
          case 401:
            text = "user_already_exists";
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
  Widget build(BuildContext ctx) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  Center(
                    child: Text(
                      translate('signin_screen_title'),
                      style: TextStyle(
                          fontFamily: "Rozanova",
                          color: PaletteColors.MAINCOLOR,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  CustomTextField(
                    context: ctx,
                    label: translate("email"),
                    type: TextInputType.emailAddress,
                    controller: emailController,
                  ),
                  CustomTextField(
                    context: ctx,
                    label: translate("password"),
                    type: TextInputType.visiblePassword,
                    controller: passwordController,
                  ),
                  CustomTextField(
                    context: ctx,
                    label: translate("name"),
                    type: TextInputType.name,
                    controller: nameController,
                  ),
                  CustomTextField(
                    context: ctx,
                    label: translate("birthdate"),
                    type: TextInputType.datetime,
                    controller: birthdateController,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: PaletteColors.MAINCOLOR,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25))),
                        onPressed: () => register(ctx),
                        child: Text(translate("register"))),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
