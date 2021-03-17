import 'package:dragonballgo/resources/routes.dart';
import 'package:dragonballgo/utils/router.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class OptionsScreen extends StatelessWidget {
  final String text = translate('options_lbl');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 40,
              ),
              child: Container(
                child: Text(
                  this.text,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.black),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 60, bottom: 20),
              child: OptionsButton(
                text: translate("select_lenguage_tittle"),
                textcolor: Colors.white,
                width: MediaQuery.of(context).size.width * 0.9,
                height: 75,
                buttoncolor: Colors.blueAccent,
                fontsize: 24,
                ontap: () {
                  AppRouter.router.pop(context);
                  AppRouter.router
                      .navigateTo(context, ScreenRoutes.SELECTLANGUAGE);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
              child: OptionsButton(
                  text: "STATISTICS",
                  textcolor: Colors.white,
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 75,
                  buttoncolor: Colors.green,
                  fontsize: 24),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
              child: OptionsButton(
                text: translate("back_lbl"),
                textcolor: Colors.white,
                width: MediaQuery.of(context).size.width * 0.9,
                height: 75,
                buttoncolor: Colors.red,
                fontsize: 24,
                ontap: () {
                  AppRouter.router.pop(context);
                  AppRouter.router.navigateTo(context, ScreenRoutes.BALLSLIST,
                      transition: TransitionType.fadeIn,
                      transitionDuration: Duration(milliseconds: 600));
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 40,
              ),
              child: Container(
                child: Text(
                  translate(
                      'Developed by MuchoCodigoIT\n © 2021 MuchoCodigo TM'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[20],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OptionsButton extends StatelessWidget {
  final String text;
  final Color buttoncolor;
  final Color textcolor;
  final double fontsize;
  final double width;
  final double height;
  final Function ontap;

  OptionsButton({
    this.text,
    this.textcolor,
    this.width,
    this.height,
    this.buttoncolor,
    this.fontsize,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        this.ontap();
      },
      child: Container(
        height: this.height,
        width: this.width,
        color: this.buttoncolor,
        child: Center(
          child: Text(
            this.text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: this.fontsize,
              color: this.textcolor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
