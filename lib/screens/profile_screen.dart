import 'package:dragonballgo/resources/palette_colors.dart';
import 'package:dragonballgo/utils/navigation_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String name = 'Guti el Jedi';
    String email = 'guti@gmail.com';
    String password = 'gutinomola';
    String birthday = '26/08/2001';
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
                    userDataRow(name),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Email'),
                    ),
                    userDataRow(email),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Password'),
                    ),
                    userDataRow(password),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Birthday'),
                    ),
                    userDataRow(birthday),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                ),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class userDataRow extends StatefulWidget {
  final String param;

  userDataRow(this.param);

  @override
  _userDataRowState createState() => _userDataRowState();
}

class _userDataRowState extends State<userDataRow> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = new TextEditingController();
    String string = widget.param;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 200,
          height: 50,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              string,
              style: TextStyle(fontSize: 25),
            ),
          ),
        ),
        InkWell(
          child: Container(
            width: 50,
            height: 50,
            child: Icon(Icons.edit),
          ),
          onTap: () {
            string = _showEditDialog(context, emailController, string);
          },
        )
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
