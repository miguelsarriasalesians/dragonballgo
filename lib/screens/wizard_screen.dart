import 'package:dragonballgo/widgets/carousel_wizard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WizardScreen extends StatefulWidget {
  WizardScreen({this.screens});
  List<Widget> screens;
  @override
  _WizardScreenState createState() => _WizardScreenState();
}

class _WizardScreenState extends State<WizardScreen> {
  @override
  Widget build(BuildContext context) {
    List<Widget> defaultScreens = [
      Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Image.asset(
              'assets/images/wizard_logo.png',
              height: MediaQuery.of(context).size.width * 0.6,
            ),
            Column(
              children: [
                Text(
                  "Text1",
                  style: TextStyle(
                      letterSpacing: 1.5,
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Text2",
                  style: TextStyle(
                      letterSpacing: 1.5,
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ],
        ),
        color: Colors.blue[600],
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      ),
      Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Image.asset('assets/images/protect.png'),
            Column(
              children: [
                Text(
                  "Screen 2 Title",
                  style: TextStyle(
                      letterSpacing: 1.5,
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Screen 2 text 1",
                  style: TextStyle(
                      letterSpacing: 1.5,
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Image.asset('assets/images/tech_hospital.png'),
                ),
                Text(
                  "Screen 2 text 1",
                  style: TextStyle(
                      letterSpacing: 1.5,
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.normal),
                  textAlign: TextAlign.center,
                ),
                InkWell(
                  onTap: () {
                    //TODO: Implement navigation towards url site
                  },
                  child: Container(
                    child: Center(
                      child: Text(
                        "www.forocoches.es",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.normal),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                        color: Colors.blue[600],
                        borderRadius: BorderRadius.circular(10)),
                    height: 45,
                    width: MediaQuery.of(context).size.width * 0.8,
                  ),
                ),
                InkWell(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                    await prefs.setBool('wizardSeen', true);

                    // NavigationManager(context)
                    //     .openScreenAsNew(
                    //     TermsOfServiceScreen()
                    // );
                  },
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Container(
                          width: 40,
                          height: 40,
                          margin: EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue[600],
                          )),
                      Container(
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.blue[600],
                        ),
                        width: 36,
                        height: 36,
                        margin: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xffE8ECFB)),
                      ),
                    ],
                  ),
                ),
              ],
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
