import 'package:http/http.dart' as http;

class ApiCalls {
  final String url = 'ec2-13-36-28-3.eu-west-3.compute.amazonaws.com:4000';

  static void login(String email, String password) async {
    final response = await http.post(
        'ec2-13-36-28-3.eu-west-3.compute.amazonaws.com:4000/auth/login/');
    print(response.statusCode);
  }
}
