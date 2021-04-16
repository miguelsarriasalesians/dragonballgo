import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dragonballgo/provider/api.dart';
import 'package:dragonballgo/resources/palette_colors.dart';
import 'package:dragonballgo/utils/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ImageUpload extends StatefulWidget {
  String code;

  ImageUpload(this.code);

  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
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
  var result;

  fetch() async {
    var response = await http.get('http://192.168.0.8:3000/image');
    result = jsonDecode(response.body);
    print(result[0]['image']);
    setState(() {
      isloaded = true;
    });
  }

  Future<bool> MakeUploadCall() async {
    var resp = await PickBall(code: widget.code, image: _image);

    return resp.statusCode == 201;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            imageSelected
                ? translate('image_selected')
                : translate('select_an_image'),
            style: TextStyle(
                fontFamily: "Rozanova",
                color: PaletteColors.MAINCOLOR,
                fontSize: 30,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          // isloaded
          //     ? Image.network('http://192.168.0.8:3000/${result[0]['image']}')
          //     : CircularProgressIndicator(),
          isloaded ? Image.file(_image) : CircularProgressIndicator(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                child: Container(
                    height: 100,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: PaletteColors.MAINCOLOR),
                    child: Center(
                        child: Text(
                          translate("text_button_browse"),
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ))),
                onPressed: () async {
                  await getImage();
                  setState(() {
                    imageSelected = true;
                  });
                },
                style: TextButton.styleFrom(primary: PaletteColors.MAINCOLOR),
              ),
              TextButton(
                child: Container(
                    height: 100,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.orange),
                    child: Center(
                        child: Text(
                          translate("text_button_upload"),
                          style: TextStyle(
                              color: PaletteColors.TEXT, fontSize: 20),
                        ))),
                onPressed: () async {
                  if (imageSelected) {
                    var res = await MakeUploadCall();
                    if (res) AppRouter.router.pop(context);
                  }
                },
                style: TextButton.styleFrom(primary: PaletteColors.MAINCOLOR),
              ),
            ],
          )
        ],
      ),
    );
  }
}
