import 'package:dragonballgo/resources/palette_colors.dart';
import 'package:dragonballgo/utils/navigation_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class ProfileScreen extends StatefulWidget {
  String name;
  String email;
  String profilePic;
  String birthday;
  String password;

  ProfileScreen(
      {this.name,
      this.email,
      this.profilePic,
      this.birthday,
      this.password = "*************"});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool providedProfilePic = false;
  @override
  Widget build(BuildContext context) {
    providedProfilePic = widget.profilePic != null;
    TextEditingController usernameController,
        emailController,
        passwordController,
        birthdayController;

    // String name = 'Guti el Jedi';
    // String email = 'guti@gmail.com';
    // String password = 'gutinomola';
    // String birthday = '26/08/2001';
    void updateName(String newName) {
      widget.name = newName;
      print(widget.name);
    }

    void updateEmail(String newEmail) {
      widget.email = newEmail;
      print(widget.email);
    }

    void updatePassword(String newPassword) {
      widget.password = newPassword;
      print(widget.password);
    }

    void updateBirthday(String newBirthday) {
      widget.birthday = newBirthday;
      print(widget.birthday);
    }

    void updateUserData(
        {String username, String email, String password, String birthday}) {
      //TODO: Falta que este hecho el put para pasarle estos datos y actualizarlos
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
                  child: providedProfilePic
                      ? Image.network(widget.profilePic)
                      : Image(image: AssetImage('assets/images/mcball.png')),
                ),
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
                      text: widget.name,
                      function: updateName,
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
                      function: updateEmail,
                      text: widget.email,
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
                      function: updatePassword,
                      text: widget.password,
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
                      isDate: true,
                      text: widget.birthday,
                      function: updateBirthday,
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
                              username: widget.name,
                              email: widget.email,
                              password: widget.password,
                              birthday: widget.birthday);
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
  final Function function;
  final bool isEnabled;
  final bool isDate;
  final bool readOnly;
  // final TextEditingController controller;

  UserDataRow({
    this.readOnly,
    this.isDate,
    this.text,
    this.obscureText = false,
    this.function,
    this.isEnabled = true,
  });

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
                      final newVal = str.substring(0, str.indexOf("T"));
                      print(newVal);
                      controller.value = TextEditingValue(
                          text: newVal,
                          selection: TextSelection.fromPosition(
                            TextPosition(offset: newVal.length),
                          ));
                    }
                  });
              },
              onChanged: (value) {
                setState(() {
                  widget.function(value);
                });
                // setState(() {
                //   controller.text = value;
                //   controller.
                // });
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
