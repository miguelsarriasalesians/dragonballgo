import 'package:http/http.dart' as http;
import 'package:dragonballgo/models/user.dart';
import 'dart:convert';

final String url = 'ec2-13-36-28-3.eu-west-3.compute.amazonaws.com:4000';

Future<dynamic> FetchLogin(String email, String password) async {
  final res = await http.post(
    Uri.http(url, "/auth/login"),
    body: jsonEncode({email: email.trim(), password: password.trim()}),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (res.statusCode == 200)
    return User.fromJson(jsonDecode(res.body));
  else
    return res.statusCode;
}
