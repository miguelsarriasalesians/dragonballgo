import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dragonballgo/utils/session_manager.dart';

final _sm = new SessionManager();

var options = BaseOptions(
    baseUrl: 'http://35.205.121.147',
    connectTimeout: 5000,
    receiveTimeout: 3000,
    contentType: "application/json");

var service = Dio(options);

void changeAuthorizationToken(String token) {
  service.options.headers["Authorization"] = token;
}

Future<Response<dynamic>> Login({String email, String password}) =>
    service.post("/api/auth/login",
        data: jsonEncode({"email": email.trim(), "password": password.trim()}));

Future<Response<dynamic>> Register(
        {String email, String password, String name, String birthdate}) =>
    service.post("/api/auth/register",
        data: jsonEncode({
          "email": email.trim(),
          "password": password.trim(),
          "name": name.trim(),
          "birthdate": birthdate.trim()
        }));

Future<Response<dynamic>> ValidateToken(String token) =>
    service.get("/api/auth/validate");

Future<Response<List<dynamic>>> FetchBalls(
    {double latitude, double longitude}) {
  Map<String, String> queryParams = {
    'latitude': latitude.toString(),
    'longitude': longitude.toString()
  };

  return service.get("/api/balls", queryParameters: queryParams);
}

Future<Response<dynamic>> FetchUserData() => service.get("/api/user/");

Future<Response<dynamic>> PickBall({String code, File image}) async {
  var formData =
      FormData.fromMap({'image': await MultipartFile.fromFile(image.path)});

  return service.post("/api/balls/picked/$code", data: formData);
}

Future<Response<dynamic>> PostUserImage({File image}) async {
  var formData =
      FormData.fromMap({'image': await MultipartFile.fromFile(image.path)});

  return service.post('/api/user/image', data: formData);
}

Future<Response<dynamic>> UpdateUserData(Map<String, String> args) =>
    service.put("/api/user", data: jsonEncode(args));

Future<Response<dynamic>> GetMedia() => service.get("/api/balls/media");

class ResponseKeys {
  static const String OK = 'ok';
  static const String BODY = 'body';
  static const String ERROR_MESSAGE = 'message';
  static const String NOTIFICATION_DATA = 'data';
}
