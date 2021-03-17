import 'package:flutter/material.dart';

class CloseBallsScreen extends StatefulWidget {
  @override
  _CloseBallsScreenState createState() => _CloseBallsScreenState();
}

class _CloseBallsScreenState extends State<CloseBallsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 50,
      color: Colors.green.withOpacity(0.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Text(
                'Bolas mas cercanas',
                style: TextStyle(fontSize: 20),
              ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text('A 50 metros'),
                  SizedBox(
                    height: 15,
                  ),
                  Image(
                      height: 80,
                      image: AssetImage('assets/images/unknown_ball.png')),
                ],
              ),
              Column(
                children: [
                  Text('A 50 metros'),
                  SizedBox(
                    height: 15,
                  ),
                  Image(
                      height: 80,
                      image: AssetImage('assets/images/unknown_ball.png')),
                ],
              ),
              Column(
                children: [
                  Text('A 50 metros'),
                  SizedBox(
                    height: 15,
                  ),
                  Image(
                      height: 80,
                      image: AssetImage('assets/images/unknown_ball.png')),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
