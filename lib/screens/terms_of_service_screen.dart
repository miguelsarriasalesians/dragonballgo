import 'dart:io';

import 'package:dragonballgo/resources/custom_text.dart';
import 'package:dragonballgo/resources/dimens.dart';
import 'package:dragonballgo/resources/palette_colors.dart';
import 'package:dragonballgo/screens/login_screen.dart';
import 'package:dragonballgo/utils/navigation_manager.dart';
import 'package:dragonballgo/views/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TermsOfServiceScreen extends StatefulWidget {
  @override
  _TermsOfServiceScreenState createState() => _TermsOfServiceScreenState();
}

class _TermsOfServiceScreenState extends State<TermsOfServiceScreen> {
  bool _readTerms = true;
  bool yesChecked = false;
  bool noChecked = false;

  var _controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Setup the listener.
    _controller.addListener(() {
      if (_controller.position.atEdge) {
        if (!(_controller.position.pixels == 0)) {
          // You're at the top.
          setState(() {
            _readTerms = true;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaletteColors.APP_BACKGROUND,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Dragon Ball Go",
          style: TextStyle(
            color: Colors.deepOrange,
          ),
        ),
        backgroundColor: Color(0xfff7f7f7),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              controller: _controller,
              child: Padding(
                padding: const EdgeInsets.all(Dimens.PADDING_LARGE),
                child: CustomText(
                    translate("agreement_policy"),
                    PaletteColors.TEXT,
                    Dimens.TEXT_SIZE_BODY_SUPER_SMALL,
                    Dimens.FONT_WEIGHT_LIGHT,
                    TextAlign.start),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      child: CustomText('¿Podemos usar su información?',
                          Colors.black, 18, FontWeight.bold, TextAlign.center),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: Dimens.PADDING_LARGE),
                          child: CustomText(
                              'Sí',
                              _readTerms
                                  ? PaletteColors.TEXT
                                  : PaletteColors.BUTTON_BACKGROUND_INACTIVE,
                              20,
                              FontWeight.normal,
                              TextAlign.center),
                        ),
                        Checkbox(
                          activeColor: PaletteColors.PRIMARY,
                          value: yesChecked,
                          onChanged: (value) {
                            if (_readTerms) {
                              setState(
                                () {
                                  yesChecked = value;
                                  noChecked = !value;
                                },
                              );
                            }
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: Dimens.PADDING_LARGE),
                          child: CustomText(
                              'No',
                              _readTerms
                                  ? PaletteColors.TEXT
                                  : PaletteColors.BUTTON_BACKGROUND_INACTIVE,
                              20,
                              FontWeight.normal,
                              TextAlign.center),
                        ),
                        Checkbox(
                          activeColor: PaletteColors.PRIMARY,
                          value: noChecked,
                          onChanged: (value) {
                            if (_readTerms) {
                              setState(
                                () {
                                  noChecked = value;
                                  yesChecked = !value;
                                },
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    AppButton(
                      textColor: Colors.black,
                      color: Colors.orange,
                      name: "Continue",
                      verticalPadding: 10,
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        if (yesChecked) {
                          await prefs.setBool('termsAccepted', yesChecked);
                          NavigationManager(context)
                              .openScreenAsNew(LoginScreen());
                        } else {
                          await prefs.setBool('termsAccepted', noChecked);
                          exit(0);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  setTosAccepted(bool accepted) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("tos_accepted", accepted);
  }
}
