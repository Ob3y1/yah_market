import 'dart:convert';
import 'package:flutter_application_task/moduels/users.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_task/config/service.dart';
import 'package:get_storage/get_storage.dart';

class LoginService {
  var message = '';
  var token = '';
  var url = Uri.parse(ServiceConf.domainNameServer + ServiceConf.login);

  Future<bool> login(Users user) async {
    var body = jsonEncode({
      'email':user.email,
      'password': user.password,
    });

    var response = await http.post(url, 
        headers: {'Content-Type': 'application/json'}, 
        body: body);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      token = jsonResponse['token'];
      GetStorage().write('token', token);
      return true;
    } else if (response.statusCode == 401) {
      message = 'Unauthorized. Invalid email or password.';
    } else if (response.statusCode == 422) {
      var jsonResponse = jsonDecode(response.body);
      message = jsonResponse['error'] ?? 'Invalid input.';
    } else {
      message = 'Something went wrong. Please try again.';
    }

    return false;
  }
}