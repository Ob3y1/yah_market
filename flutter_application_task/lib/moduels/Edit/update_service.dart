import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_task/config/service.dart';
import 'package:flutter_application_task/moduels/users.dart';

class UpdateService {
  Future<Users> getUserInfo(String token) async {
    var url = Uri.parse(ServiceConf.domainNameServer + ServiceConf.showUserInfo);
    var response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return Users.fromJson(jsonResponse['user']);
    } else {
      throw Exception('Failed to load user info');
    }
  }

  Future<bool> updateUser(Users user, String token) async {
    var url = Uri.parse(ServiceConf.domainNameServer + ServiceConf.update);
    var body = jsonEncode({
      'name': user.name,
      'email': user.email,
      'gender': user.gender,
      'birth_date': user.birthDate?.toIso8601String(),
    });

    var response = await http.put(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 201) {
      return true;
    } else if (response.statusCode == 422) {
    
      var jsonResponse = jsonDecode(response.body);
      throw Exception(jsonResponse['error'] ?? 'Invalid input.');
    } else {
      return false;
    }
  }

  Future<void> logout(String token) async {
    var url = Uri.parse(ServiceConf.domainNameServer + ServiceConf.logout);
    await http.get(url, headers: {
      'Authorization': 'Bearer $token',
    });
  }
}