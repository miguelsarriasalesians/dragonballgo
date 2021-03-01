import 'package:dragonballgo/models/user.dart';
import 'package:dragonballgo/provider/api.dart';
import 'package:dragonballgo/utils/session_manager.dart';
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
    print("hoola");
    FetchLogin(emailController.text, passwordController.text).then((val) {
      if (val is User) {
        _sm.setUser(val);
        Navigator.pushNamed(context, '/home');
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
                          print("lol");
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

  Widget _buildInput(BuildContext context, String label, FocusNode node,
          TextEditingController controller, TextInputType type) =>
      CustomTextField();
}

class CustomTextField extends StatefulWidget {
  BuildContext context;
  String label;
  FocusNode node;
  TextEditingController controller;
  TextInputType type;

  CustomTextField(
      {this.context, this.label, this.node, this.controller, this.type});

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.center,
      focusNode: widget.node,
      controller: widget.controller,
      obscureText: widget.type == TextInputType.visiblePassword ? true : false,
      decoration: InputDecoration(
        hintStyle: TextStyle(
          letterSpacing: 1.5,
        ),
        hintText: widget.label,
        focusColor: Colors.black,
        fillColor: Colors.black,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blueAccent, width: 2.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
      keyboardType: widget.type,
      style: new TextStyle(
          fontFamily: "Poppins",
          color: widget.node.hasFocus ? Colors.blueAccent : Colors.grey),
    );
  }
}
