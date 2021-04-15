import 'package:animate_do/animate_do.dart';
import 'package:dragonballgo/screens/terms_of_service_screen.dart';
import 'package:dragonballgo/utils/navigation_manager.dart';
import 'package:dragonballgo/widgets/carousel_wizard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WizardScreen extends StatefulWidget {
  List<Widget> screens;

  WizardScreen({this.screens});

  @override
  _WizardScreenState createState() => _WizardScreenState();
}

class _WizardScreenState extends State<WizardScreen> {
  @override
  Widget build(BuildContext context) {
    List<Widget> defaultScreens = [
      Container(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.1,
            left: MediaQuery.of(context).size.height * 0.03,
            right: MediaQuery.of(context).size.height * 0.03),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: MediaQuery.of(context).size.width * 0.5,
            ),
            Text(
              "Welcome to Dragon Ball Go!",
              style: TextStyle(
                  letterSpacing: 1.5,
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              "We challenge you to pick the 7 Dragon Balls.",
              style: TextStyle(
                  letterSpacing: 1.5,
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              "Your adventure begins now...",
              style: TextStyle(
                  letterSpacing: 1.5,
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        color: Colors.orange[400],
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      ),
      Container(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.1,
            left: MediaQuery.of(context).size.height * 0.03,
            right: MediaQuery.of(context).size.height * 0.03),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('assets/images/mcball.png'),
            Text(
              "Screen 2 Title",
              style: TextStyle(
                  letterSpacing: 1.5,
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.normal),
              textAlign: TextAlign.center,
            ),
            Text(
              "This project is possible \nthanks to: ",
              style: TextStyle(
                  letterSpacing: 1.5,
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            InkWell(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setBool('wizardSeen', true);

                NavigationManager(context)
                    .openScreenAsNew(TermsOfServiceScreen());
              },
              child: Container(
                child: Center(
                  child: Text(
                    "www.muchocodigo.com",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.normal),
                    textAlign: TextAlign.center,
                  ),
                ),
                margin: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                    color: Colors.orange[400],
                    borderRadius: BorderRadius.circular(10)),
                height: 45,
                width: MediaQuery.of(context).size.width * 0.8,
              ),
            ),
            InkWell(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();

                await prefs.setBool('wizardSeen', true);

                NavigationManager(context)
                    .openScreenAsNew(TermsOfServiceScreen());
              },
              child: Bounce(
                duration: Duration(milliseconds: 3000),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Container(
                        width: 60,
                        height: 60,
                        margin: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.deepOrange,
                        )),
                    Container(
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.deepOrange,
                      ),
                      width: 42,
                      height: 42,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xffffffff)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      )
    ];
    widget.screens = widget.screens ?? defaultScreens;

    return Material(
      child: CarouselWizard(
        screens: widget.screens,
      ),
    );
  }
}
