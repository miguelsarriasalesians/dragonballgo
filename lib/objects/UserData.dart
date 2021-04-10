import 'package:flutter/material.dart';

class UserData {
  final String name;
  final String email;
  final String password;
  final String birthdate;

  UserData(
      {@required this.name,
      @required this.password,
      @required this.email,
      @required this.birthdate});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      name: "Guti",
      email: "guti@gmail.com",
      password: "gutinomola",
      birthdate: "26/08/2001",
    );
  }
}
