import 'package:flutter_application_task/moduels/login/login_service.dart';
import 'package:flutter_application_task/moduels/users.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var email = '';        // البريد الإلكتروني
  var password = '';     // كلمة المرور
  var loginStatus = false; // حالة تسجيل الدخول
  var message = '';      // رسالة الحالة

  LoginService service = LoginService();

  // دالة الضغط على زر تسجيل الدخول
  Future<void> loginOnClick() async {
  if (email.isEmpty || password.isEmpty) {
    message = "Please enter both email and password.";
    loginStatus = false;
    print(message);
    return;
  }

  Users user = Users(
    email: email,
    password: password,
  );

  loginStatus = await service.login(user);
  message = service.message;

  if (loginStatus) {
    print("Login succeeded");
    Get.offAllNamed('/first1'); // انتقال إلى الصفحة الرئيسية بعد تسجيل الدخول
  } else {
    print("Login failed: $message");
  }
}

}
