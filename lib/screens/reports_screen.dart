import 'package:dragonballgo/resources/dimens.dart';
import 'package:dragonballgo/resources/palette_colors.dart';
import 'package:dragonballgo/views/icon_language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class ReportsScreen extends StatefulWidget {
  @override
  _ReportsScreenState createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final tabs = [
    Tab(
      text: translate("saved_reports"),
    ),
    Tab(
      text: translate("sent_reports"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            translate('reports_screen_title'),
            style: TextStyle(
              color: PaletteColors.TEXT_BUTTON,
            ),
          ),
          bottom: TabBar(
            tabs: tabs,
          ),
          backgroundColor: PaletteColors.PRIMARY,
          actions: [IconLanguage()],
        ),
        body: TabBarView(
          children: tabs.map(
            (Tab tab) {
              final String label = tab.text.toLowerCase();
              return Center(
                child: Text(
                  'This is the $label tab',
                  style: const TextStyle(fontSize: Dimens.TEXT_SIZE_BODY),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
