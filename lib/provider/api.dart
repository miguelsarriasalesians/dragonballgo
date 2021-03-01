import 'package:dragonballgo/resources/shared_preferences_consts.dart';
import 'package:http/http.dart' as http;
import 'package:dragonballgo/models/user.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

final String url = '34.78.134.219';

Future<int> FetchLogin(String email, String password) async {
  final res = await http.post(
    Uri.http(url, "/auth/login"),
    body: jsonEncode({"email": email.trim(), "password": password.trim()}),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    },
  );

  print(res.body);

  if (res.statusCode == 200) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(SharedPreferencesConsts.TOKEN, res.body);
  }

  return res.statusCode;
}
