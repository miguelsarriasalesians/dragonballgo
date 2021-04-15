import 'dart:io';

import 'package:dragonballgo/objects/UserData.dart';
import 'package:dragonballgo/provider/api.dart';
import 'package:dragonballgo/resources/palette_colors.dart';
import 'package:dragonballgo/utils/navigation_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  UserData user;

  ProfileScreen({this.user});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool providedProfilePic = false;

  @override
  Widget build(BuildContext context) {
    providedProfilePic = widget.user.profilePic != null;

    final picker = ImagePicker();

    Future<void> updateProfilePic() async {
      var file = await picker.getImage(source: ImageSource.gallery);
      if (file != null) {
        var image = File(file.path);
        await PostUserImage(image: image);
        var user = await FetchUserData();
        if (user.statusCode == 200) {
          widget.user = UserData.fromJson(user.data);
        }
      }
    }

    Future<void> updateUserData({String name, DateTime birthdate}) async {
      var args = {"name": name, "birthdate": birthdate.toIso8601String()};
      args.forEach((key, value) {
        if (value == null) args.remove(key);
      });
      var updateResult = await UpdateUserData(args);
      print(updateResult.statusCode);
      await Future.delayed(const Duration(seconds: 1));
      var userData = await FetchUserData();
      widget.user = UserData.fromJson(userData.data);
    }

    return Scaffold(
      backgroundColor: PaletteColors.APP_BACKGROUND,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Text(
                  translate('profile_title'),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Container(
                  height: 130,
                  width: 130,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(70),
                      color: Colors.transparent),
                  child: InkWell(
                    onTap: updateProfilePic,
                    child: widget.user.profilePic != null
                        ? FadeInImage.assetNetwork(
                            placeholder: 'assets/images/mcball.png',
                            image: widget.user.profilePic,
                          )
                        : Image(image: AssetImage('assets/images/mcball.png')),
                  ),
                ),
                // child: providedProfilePic
                //     ? Image.network(widget.user.profilePic)
                //
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Username'),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    UserDataRow(
                      text: widget.user.name,
                      onChange: (value) {
                        updateUserData(name: value);
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Email'),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    UserDataRow(
                      isEnabled: false,
                      // function: updateEmail,
                      text: widget.user.email,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Password'),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    UserDataRow(
                      isEnabled: false,
                      // function: updatePassword,
                      text: "*********",
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Birthday'),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    UserDataRow(
                      textLength: 10,
                      isDate: true,
                      text: widget.user.birthdate
                          .toIso8601String()
                          .substring(0, 10),
                      // function: updateBirthday,
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        child: Container(
                          height: 30,
                          width: MediaQuery.of(context).size.height * 0.3,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.orange),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              translate('back_lbl'),
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                        ),
                        onTap: () {
                          NavigationManager(context).back();
                        },
                      ),
                      InkWell(
                        onTap: () {
                          updateUserData(
                              name: widget.user.name,
                              birthdate: widget.user.birthdate);
                        },
                        child: Container(
                          child: Icon(
                            Icons.save,
                            color: Colors.orange,
                            size: 50,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UserDataRow extends StatefulWidget {
  final String text;
  final bool obscureText;
  final Function onChange;
  final bool isEnabled;
  final bool isDate;
  final bool readOnly;
  final int textLength;

  UserDataRow(
      {this.readOnly,
      this.isDate,
      this.text,
      this.obscureText = false,
      this.onChange,
      this.isEnabled = true,
      this.textLength});

  @override
  _UserDataRowState createState() => _UserDataRowState();
}

class _UserDataRowState extends State<UserDataRow> {
  TextEditingController controller = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.text = widget.text;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.075,
          child: Align(
            alignment: Alignment.centerLeft,
            child: TextFormField(
              readOnly: widget.readOnly == true ? true : false,
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  letterSpacing: 1.5,
                ),
                hintText: widget.text,
                focusColor: Colors.black,
                fillColor: Colors.black,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.blueAccent, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              enabled: widget.isEnabled,
              onTap: () {
                if (widget.isDate)
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now())
                      .then((value) {
                    if (value != null) {
                      final str = value.toIso8601String();
                      controller.value = TextEditingValue(
                          text:
                              str.substring(0, widget.textLength ?? str.length),
                          selection: TextSelection.fromPosition(
                            TextPosition(offset: str.length),
                          ));
                    }
                  });
              },
              onChanged: (value) {
                setState(() {
                  widget.onChange(value);
                });
              },
              obscureText: widget.obscureText,
              controller: controller,
              // decoration: InputDecoration(border: OutlineInputBorder()),
            ),
          ),
        ),
      ],
    );
  }

  String _showEditDialog(BuildContext context, emailController, name) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Editing'),
              content: TextField(
                  controller: emailController,
                  decoration: InputDecoration(hintText: name)),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      //name = emailController.text;
                      Navigator.of(context).pop(name);
                    }, //  We can return any object from here
                    child: Text('Cancelar')),
                FlatButton(
                    onPressed: () {
                      name = emailController.text;
                      Navigator.of(context).pop(name);
                    }, //  We can return any object from here
                    child: Text('Guardar'))
              ],
            )).then((value) => print(value));
  }
}
