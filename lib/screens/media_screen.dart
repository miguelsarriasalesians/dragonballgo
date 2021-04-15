import 'package:dragonballgo/resources/palette_colors.dart';
import 'package:dragonballgo/utils/navigation_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class MediaScreen extends StatefulWidget {
  final List<Image> imagesList;
  MediaScreen({this.imagesList});
  @override
  _MediaScreenState createState() => _MediaScreenState();
}

class _MediaScreenState extends State<MediaScreen> {
  @override
  Widget build(BuildContext context) {
    // void initState() {
    //   super.initState();
    //   GetMedia().then((value) {
    //     setState(() {
    //       imagesList = value.data;
    //       print(imagesList);
    //     });
    //   });
    // }

    return Scaffold(
      backgroundColor: PaletteColors.APP_BACKGROUND,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
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
                    translate('IMAGENES GUARDADAS'),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Column(
                    children: widget.imagesList
                        .map((e) => Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              height: MediaQuery.of(context).size.width * 0.8,
                              child: e,
                            ))
                        .toList(),
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
      ),
    );
  }
}

class ImgMedia extends StatefulWidget {
  final String param;

  ImgMedia(this.param);

  @override
  _ImgMediaState createState() => _ImgMediaState();
}

class _ImgMediaState extends State<ImgMedia> {
  @override
  Widget build(BuildContext context) {
    String image = widget.param;
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width * 0.9,
      color: Colors.red,
      child: Image(image: AssetImage(image)),
    );
  }
}
