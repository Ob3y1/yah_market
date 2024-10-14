
import 'package:flutter_application_task/moduels/login/login_service.dart';
import 'package:flutter_application_task/moduels/users.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class LoginController extends GetxController {
var email ='';
var password='';
var loginStatus = false;
  var message;
LoginService service=LoginService();
  Future <void> LoginOnClick()async {
    Users user=Users(
      email: email,
      password: password,
    );
  // print("object");
  loginStatus= await service.login(user);
  message=service.message;
  if (loginStatus) {
    
      // هنا يمكنك إضافة منطق لتخزين التوكن إذا لزم الأمر
      print("Registration succeeded");
    } else {
      print("Registration failed");
    }
  }
}