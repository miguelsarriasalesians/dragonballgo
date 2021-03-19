import 'package:dragonballgo/resources/palette_colors.dart';
import 'package:dragonballgo/resources/routes.dart';
import 'package:dragonballgo/utils/router.dart';
import 'package:dragonballgo/widgets/custom_button.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class StatisticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  translate('statistics_title'),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Text(
                  translate('statistics_desc'),
                  style: TextStyle(),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                ),
                StatisticsList('Balls', '23'),
                StatisticsList('Km', '1543'),
                StatisticsList('Km', '23'),
                StatisticsList('Km', '23'),
                StatisticsList('Time Played', '23d 3h'),
                StatisticsList('Account Created', '19-03-21'),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
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
                    AppRouter.router.pop(context);
                    AppRouter.router.navigateTo(context, ScreenRoutes.BALLSLIST,
                        transition: TransitionType.fadeIn,
                        transitionDuration: Duration(milliseconds: 600));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StatisticsList extends StatefulWidget {
  final String typeStat;
  final String Stat;

  StatisticsList(this.typeStat, this.Stat);

  @override
  _StatisticsListState createState() => _StatisticsListState();
}

class _StatisticsListState extends State<StatisticsList> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          height: 50,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.typeStat,
              style: TextStyle(fontSize: 25),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.3,
          height: 50,
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              widget.Stat,
              style: TextStyle(fontSize: 25),
            ),
          ),
        ),
      ],
    );
  }
}
