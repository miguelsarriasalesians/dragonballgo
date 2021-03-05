import 'dart:convert';

import 'package:dragonballgo/utils/session_manager.dart';
import 'package:http/http.dart' as http;

final String url = '34.78.134.219';

final _sm = new SessionManager();

Future<int> FetchLogin(String email, String password) async {
  final res = await http.post(
    Uri.http(url, "/auth/login"),
    body: jsonEncode({"email": email.trim(), "password": password.trim()}),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    },
  );

  print(res.body);

  if (res.statusCode == 200) _sm.setToken(res.body);

  return res.statusCode;
}

Future<int> FetchRegister(
    {String email, String password, String name, String birthdate}) async {
  final res = await http.post(
    Uri.http(url, "/auth/register"),
    body: jsonEncode({
      "email": email.trim(),
      "password": password.trim(),
      "name": name.trim(),
      "birthdate": birthdate.trim()
    }),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    },
  );

  print(res.body);

  if (res.statusCode == 200) _sm.setToken(res.body);

  return res.statusCode;
}
