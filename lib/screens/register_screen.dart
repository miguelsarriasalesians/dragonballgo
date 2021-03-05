import 'package:dragonballgo/provider/api.dart';
import 'package:dragonballgo/resources/palette_colors.dart';
import 'package:dragonballgo/resources/routes.dart';
import 'package:dragonballgo/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class RegisterScreen extends StatelessWidget {
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();
  final nameController = new TextEditingController();
  final birthdateController = new TextEditingController();

  void register(BuildContext context) {
    FetchRegister(
            email: emailController.text,
            password: passwordController.text,
            name: nameController.text,
            birthdate: birthdateController.text)
        .then((val) {
      if (val == 200)
        Navigator.pushNamed(context, ScreenRoutes.BALLSLIST);
      else {
        String text;
        switch (val) {
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
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(translate(text)),
          duration: Duration(seconds: 5),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext ctx) {
    return SafeArea(
        child: Scaffold(
            body: Center(
                child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          child: Text(
            translate('signin_screen_title'),
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
            context: ctx,
            label: translate("email"),
            type: TextInputType.emailAddress,
            controller: emailController,
          ),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        ),
        Padding(
          child: CustomTextField(
            context: ctx,
            label: translate("password"),
            type: TextInputType.visiblePassword,
            controller: passwordController,
          ),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        ),
        Padding(
          child: CustomTextField(
            context: ctx,
            label: translate("name"),
            type: TextInputType.name,
            controller: nameController,
          ),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        ),
        Padding(
          child: CustomTextField(
            context: ctx,
            label: translate("birthdate"),
            type: TextInputType.datetime,
            controller: birthdateController,
          ),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        ),
        Padding(
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(primary: PaletteColors.MAINCOLOR),
                onPressed: () => register(ctx),
                child: Text(translate("register"))),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        ),
      ],
    ))));
  }
}
