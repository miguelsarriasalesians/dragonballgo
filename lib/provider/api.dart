import 'dart:convert';

import 'package:dragonballgo/objects/UserData.dart';
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

Future<Map<String, dynamic>> FetchBalls(
    {String token, double latitude, double longitude}) async {
  Map<String, String> queryParameters = {
    'latitude': latitude.toString(),
    'longitude': longitude.toString()
  };
  print(token);

  Uri uri = Uri.http(url, "/api/balls", queryParameters);
  final resp = await http.get(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': token
    },
  );
  List<dynamic> decodeResp = json.decode(resp.body);

  if (resp.statusCode == 200) {
    return {ResponseKeys.OK: true, ResponseKeys.BODY: decodeResp};
  } else {
    return {
      ResponseKeys.OK: false,
      ResponseKeys.ERROR_MESSAGE: ResponseKeys.ERROR_MESSAGE
    };
  }
}

Future<UserData> getUserData() async {
  final response = await http.get(Uri.https(url, ''));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return UserData.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<int> FetchUserData(
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

class ResponseKeys {
  static const String OK = 'ok';
  static const String BODY = 'body';
  static const String ERROR_MESSAGE = 'message';
  static const String NOTIFICATION_DATA = 'data';
}
