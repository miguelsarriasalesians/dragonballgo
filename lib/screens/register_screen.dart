import 'dart:async';
import 'dart:io';

import 'package:dragonballgo/provider/api.dart';
import 'package:dragonballgo/resources/palette_colors.dart';
import 'package:dragonballgo/resources/routes.dart';
import 'package:dragonballgo/utils/router.dart';
import 'package:dragonballgo/utils/session_manager.dart';
import 'package:dragonballgo/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = new TextEditingController();

  final passwordController = new TextEditingController();

  final nameController = new TextEditingController();

  final birthdateController = new TextEditingController();

  final manager = new SessionManager();
  File _image;
  final picker = ImagePicker();

  Future<void> getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });

    setState(() {
      isloaded = true;
    });
  }

  bool imageSelected = false;
  bool isloaded = false;

  void register(BuildContext ctx) async {
    var result = await Register(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text,
        birthdate: birthdateController.text);

    if (result.statusCode == 200) {
      await manager.setToken(result.data);
      changeAuthorizationToken(result.data);

      await sleep1();

      if (_image != null) {
        var imageResult = await PostUserImage(image: _image);
        print(imageResult.statusCode);
      }

      AppRouter.router.navigateTo(ctx, ScreenRoutes.BALLSLIST);
    } else {
      String text;
      switch (result.statusCode) {
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
  }

  Future sleep1() {
    return new Future.delayed(const Duration(seconds: 1), () => "1");
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          await getImage();
                          setState(() {
                            imageSelected = true;
                          });
                        },
                        child: Container(
                          height: 130,
                          width: 130,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(70),
                              color: Colors.transparent),
                          child: imageSelected
                              ? Image.file(_image)
                              : Image(
                                  image:
                                      AssetImage('assets/images/mcball.png')),
                        ),
                      ),
                    ],
                  ),
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
                    height: 30,
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
