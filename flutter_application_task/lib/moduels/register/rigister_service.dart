import 'dart:convert';
import 'package:flutter_application_task/moduels/users.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_task/config/service.dart';

class SignUpService {
  var message;
  var token;
  var url = Uri.parse(ServiceConf.domainNameServer + ServiceConf.register);
  Future<bool> register(Users user) async {
    var body = jsonEncode({
      'name': user.name,
      'email': user.email,
      'birth_date': user.birthDate?.toIso8601String(),
      'gender': user.gender,
      'password': user.password,
    });

    var response = await http.post(url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: body);

    print(response.statusCode);
    print(response.body);

    try {
      var jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 201) {
        if (jsonResponse is Map && jsonResponse.containsKey('token')) {
          token = jsonResponse['token'];
          return true; // التسجيل ناجح
        }
      } else {
        // التعامل مع الأخطاء
        if (jsonResponse is Map && jsonResponse.containsKey('error')) {
          var errorMessages = jsonResponse['error'];
          List<String> allErrors = [];

          // تحليل الأخطاء لكل حقل
          if (errorMessages is Map) {
            errorMessages.forEach((key, value) {
              if (value is List) {
                allErrors.addAll(value.map((e) => "$key: $e")); // دمج الرسائل
              }
            });
          }

          // دمج كل الرسائل في سلسلة واحدة
          message = allErrors.join("\n");
        }
      }
    } catch (e) {
      print("Error parsing JSON: $e");
    }

    return false; // فشل التسجيل
  }
}
