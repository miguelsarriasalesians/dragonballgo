import 'package:flutter/material.dart';

class UserData {
  final String userName;
  final String email;
  final String password;
  final String birthday;

  UserData(
      {@required this.userName,
      @required this.password,
      @required this.email,
      @required this.birthday});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      userName: json['userName'],
      email: json['email'],
      password: json['password'],
      birthday: json['birthday'],
    );
  }
}
