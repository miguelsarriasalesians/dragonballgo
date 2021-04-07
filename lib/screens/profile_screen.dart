import 'package:dragonballgo/resources/palette_colors.dart';
import 'package:dragonballgo/utils/navigation_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController,
        emailController,
        passwordController,
        birthdayController;

    String name = 'Guti el Jedi';
    String email = 'guti@gmail.com';
    String password = 'gutinomola';
    String birthday = '26/08/2001';
    void updateName(String newName) {
      name = newName;
      print(name);
    }

    void updateEmail(String newEmail) {
      email = newEmail;
      print(email);
    }

    void updatePassword(String newPassword) {
      password = newPassword;
      print(password);
    }

    void updateBirthday(String newBirthday) {
      birthday = newBirthday;
      print(birthday);
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
                      color: Colors.orange),
                  child: Image(image: AssetImage('assets/images/mcball.png')),
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
                    UserDataRow(
                      text: name,
                      function: updateName,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Email'),
                    ),
                    UserDataRow(
                      isEnabled: false,
                      function: updateEmail,
                      text: email,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Password'),
                    ),
                    UserDataRow(
                      isEnabled: false,
                      function: updatePassword,
                      text: password,
                      obscureText: true,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Birthday'),
                    ),
                    UserDataRow(
                      text: birthday,
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
                              username: name,
                              email: email,
                              password: password,
                              birthday: birthday);
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
  // final TextEditingController controller;

  UserDataRow({
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
              enabled: widget.isEnabled,
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
              decoration: InputDecoration(border: OutlineInputBorder()),
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
