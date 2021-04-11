import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:dragonballgo/provider/api.dart';
import 'package:dragonballgo/resources/palette_colors.dart';
import 'package:dragonballgo/resources/routes.dart';
import 'package:dragonballgo/utils/router.dart';
import 'package:dragonballgo/utils/session_manager.dart';
import 'package:dragonballgo/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

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

  upload(File imageFile) async {
    // open a bytestream
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();

    // string to uri
    var uri = Uri.parse("http://192.168.0.8:3000/upload");

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFile = new http.MultipartFile('myFile', stream, length,
        filename: basename(imageFile.path));

    // add file to multipart
    request.files.add(multipartFile);

    // send
    var response = await request.send();
    print(response.statusCode);

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  bool imageSelected = false;
  bool isloaded = false;

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
