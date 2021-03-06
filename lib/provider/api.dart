import 'dart:convert';

import 'package:dragonballgo/utils/session_manager.dart';
import 'package:http/http.dart' as http;

final String url = '34.78.80.85';

final _sm = new SessionManager();

Future<int> FetchLogin(String email, String password) async {
  final res = await http.post(
    Uri.http(url, "/api/auth/login"),
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
    Uri.http(url, "/api/auth/register"),
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

Future<bool> FetchValidation(String token) async {
  print(token);
  final res = await http.get(
    Uri.http(url, "/api/auth/validate"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': token
    },
  );
  
  print(res.body);

  return res.statusCode == 200;
}
