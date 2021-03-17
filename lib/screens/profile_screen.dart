import 'package:dragonballgo/resources/palette_colors.dart';
import 'package:dragonballgo/resources/routes.dart';
import 'package:dragonballgo/utils/router.dart';
import 'package:dragonballgo/views/icon_language.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class ProfileScreen extends StatelessWidget {
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
                  translate('profile_lbl'),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey),
                  child: Image(
                      width: 20, image: AssetImage('assets/images/mcball.png')),
                ),
                TextField(decoration: InputDecoration(hintText: 'Nombre')),
                TextField(decoration: InputDecoration(hintText: 'Contraseña')),
                TextField(decoration: InputDecoration(hintText: 'Correo')),
                TextField(decoration: InputDecoration(hintText: 'Localidad')),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                InkWell(
                  child: Container(
                    height: 30,
                    width: MediaQuery.of(context).size.height * 0.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.orange),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        translate('Guardar'),
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                InkWell(
                  child: Container(
                    height: 30,
                    width: MediaQuery.of(context).size.height * 0.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
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
                Image(
                    width: MediaQuery.of(context).size.height * 0.4,
                    image: AssetImage('assets/images/logo.png'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
