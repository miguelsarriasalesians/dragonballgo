import 'package:flutter/material.dart';

class UserData {
  String name;
  String email;
  String profilePic;
  DateTime birthdate;

  UserData(
      {@required this.name,
      @required this.profilePic,
      @required this.email,
      @required this.birthdate});

  UserData.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        email = json["email"],
        birthdate = DateTime.parse(json["birthdate"]),
        profilePic = json["profilepic"];
}
