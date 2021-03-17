import 'package:dragonballgo/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class StatisticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Text(
                  "Statistics",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              CustomButton(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.85,
                function: () {
                  print("funciona");
                },
              ),
              SizedBox(
                height: 40,
              ),
              CustomButton(
                color: Colors.green,
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.85,
                function: () {
                  print("funciona");
                },
              ),
              SizedBox(
                height: 40,
              ),
              CustomButton(
                color: Colors.red,
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.85,
                function: () {
                  print("funciona");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
