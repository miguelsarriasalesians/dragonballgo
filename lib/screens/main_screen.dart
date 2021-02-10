import 'package:dragonballgo/resources/dimens.dart';
import 'package:dragonballgo/resources/palette_colors.dart';
import 'package:dragonballgo/screens/getting_started_screen.dart';
import 'package:dragonballgo/screens/information_screen.dart';
import 'package:dragonballgo/screens/login_screen.dart';
import 'package:dragonballgo/screens/profile_screen.dart';
import 'package:dragonballgo/screens/reports_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final tabs = [
    GettingStartedScreen(),
    ReportsScreen(),
    InformationScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: PaletteColors.PRIMARY,
        selectedFontSize: Dimens.TEXT_SELECTED,
        unselectedFontSize: Dimens.TEXT_UNSELECTED,
        iconSize: Dimens.SIZE_ICON_SELECTED,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: translate("getting_started"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: translate("reports"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: translate("profile"),
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
