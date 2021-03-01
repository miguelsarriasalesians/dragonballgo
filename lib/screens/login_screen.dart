import 'package:dragonballgo/models/user.dart';
import 'package:dragonballgo/provider/api.dart';
import 'package:dragonballgo/utils/session_manager.dart';
import 'package:dragonballgo/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final emailNode = FocusNode();
  final passwordController = TextEditingController();
  final passwordNode = FocusNode();

  final mainColor = Color.fromARGB(255, 227, 0, 45);

  final SessionManager _sm = new SessionManager();

  void login(BuildContext context) {
    FetchLogin(emailController.text, passwordController.text).then((val) {
      if (val == 200)
        Navigator.pushNamed(context, '/home');
      else {
        var text;
        switch (val) {
          case 400:
            text = "Falten dades a la petició";
            break;
          case 401:
            text = "Usuari/contrasenya incorrecte";
            break;
          case 500:
            text = "Error intern";
            break;
          default:
            text = "Error";
        }
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
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
                        color: mainColor,
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
                    node: emailNode,
                    controller: emailController,
                    type: TextInputType.emailAddress,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                ),
                Padding(
                  child: CustomTextField(
                    context: context,
                    label: translate("password"),
                    node: passwordNode,
                    controller: passwordController,
                    type: TextInputType.visiblePassword,
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
                        style: ElevatedButton.styleFrom(primary: mainColor),
                        onPressed: () {
                          login(context);
                        },
                        child: Text(translate("login_screen_title"))),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                ),
                Padding(
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Color(0x00000000)),
                        onPressed: () {},
                        child: Text(translate("register"))),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          ),
        ),
      );
}
