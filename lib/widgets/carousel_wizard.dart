import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class CarouselWizard extends StatefulWidget {
  final List<Widget> screens;

  CarouselWizard({this.screens});

  @override
  _CarouselWizardState createState() => _CarouselWizardState();
}

class _CarouselWizardState extends State<CarouselWizard> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return carrousel(widget.screens);
  }

  Widget carrousel(List<Widget> screens) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                    enableInfiniteScroll: false,
                    viewportFraction: 1.0,
                    height: MediaQuery.of(context).size.height,
                    onPageChanged: (index, reason) {
                      if (index == widget.screens.length - 1) {}
                      setState(() {
                        _current = index;
                      });
                    }),
                items: screens.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Stack(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height, //255,
                            width: MediaQuery.of(context).size.width,
                            child: i,
                          ),
                        ],
                      );
                    },
                  );
                }).toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: widget.screens.map((screen) {
                        int index = widget.screens.indexOf(screen);
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Container(
                                width: (_current == index) ? 23 : 15,
                                height: (_current == index) ? 23 : 15,
                                margin: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 2.0),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _current == 0
                                        ? Colors.transparent
                                        : Color(0xFF002CCE)),
                              ),
                              Container(
                                width: (_current == index) ? 20 : 12,
                                height: (_current == index) ? 20 : 12,
                                margin: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 2.0),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _current == index
                                        ? Color(0xFF002CCE)
                                        : Color(0xFFF7F6F6)),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
