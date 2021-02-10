import 'package:dragonballgo/resources/palette_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:dragonballgo/provider/api.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final ApiCalls _api = new ApiCalls();

  final mainColor = Color.fromARGB(255, 227, 0, 45);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        centerTitle: true,
        title: Text(
          translate('login_screen_title'),
          style: TextStyle(
            color: PaletteColors.TEXT_BUTTON,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
      ), */
      body: Column(
        children: [
          Image(image: AssetImage('assets/images/logo.png')),
          Padding(
            child: Text(
              translate('login_screen_title'),
              style: TextStyle(
                  fontFamily: "Rozanova",
                  color: mainColor,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            padding: EdgeInsets.all(10),
          ),
          Padding(
            child: TextField(
              controller: emailController,
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: translate('email'),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          ),
          Padding(
            child: TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: translate('password'),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          ),
          Padding(
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: mainColor),
                  onPressed: () async {
                    final response = await http.post(
                        'http://ec2-13-36-28-3.eu-west-3.compute.amazonaws.com:4000/auth/login/');
                    print(response.statusCode);
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
                  style: ElevatedButton.styleFrom(primary: Color(0x00000000)),
                  onPressed: () {},
                  child: Text(translate("register"))),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
    );
  }
}
