import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:async';

final String url = '34.78.134.219';

class ApiProvider {
  final String _baseUrl = "http://34.78.134.219";

  Future<http.Response> postLogin(String email, String password) async =>
      http.post(_baseUrl + "/auth/login",
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          },
          body: jsonEncode({"email": email, "password": password}));

  /* dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      default:
        throw Exception(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  } */
}
