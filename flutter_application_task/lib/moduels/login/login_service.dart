import 'dart:convert';
import 'package:flutter_application_task/moduels/users.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_task/config/service.dart';
import 'package:get_storage/get_storage.dart'; // لتخزين التوكن

class LoginService {
  var message = ''; // رسالة حالة تسجيل الدخول
  var token = '';   // التوكن الذي سيتم تخزينه
  var url = Uri.parse(ServiceConf.domainNameServer +ServiceConf.login); // رابط الـ API

  // دالة تسجيل الدخول
  Future<bool> login(Users user) async {
    // تحضير بيانات الطلب
    var body = jsonEncode({
      'email': user.email,
      'password': user.password,
    });

    try {
      // إرسال طلب POST إلى الـ API
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      // إذا كانت حالة الاستجابة 200 (نجاح)
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        token = jsonResponse['token'] ?? ''; // استلام التوكن

        // التأكد من وجود التوكن وتخزينه
        if (token.isNotEmpty) {
          GetStorage().write('token', token); // تخزين التوكن
          message = 'Login successful!';
          return true; // نجاح تسجيل الدخول
        } else {
          message = 'Token not found in response.';
          return false;
        }
      } 
      // حالة الخطأ 401 (عدم مصرح)
      else if (response.statusCode == 401) {
        message = 'Unauthorized. Invalid email or password.';
      } 
      // حالة الخطأ 422 (خطأ في المدخلات)
      else if (response.statusCode == 422) {
        var jsonResponse = jsonDecode(response.body);
        message = jsonResponse['error'] ?? 'Invalid input.';
      } 
      // أي حالة خطأ أخرى
      else {
        message = 'Something went wrong. Please try again.';
      }
    } catch (e) {
      message = 'Error occurred: $e'; // في حالة حدوث خطأ استثنائي
    }

    return false; // إذا فشل تسجيل الدخول
  }
}
