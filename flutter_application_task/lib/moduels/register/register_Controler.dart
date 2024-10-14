import 'package:flutter_application_task/moduels/register/rigister_service.dart';
import 'package:flutter_application_task/moduels/users.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class RegisterController extends GetxController {
  var fullName = '';
  var email = '';
  var password = '';
  var gender = '';
  DateTime? birthDate;
  var siginUpStatus = false;
  var message;
  var token;
  SignUpService service = SignUpService();

  Future<void> RegisterOnClick() async {
    Users user = Users(
        name: fullName,
        email: email,
        password: password,
        gender: gender,
        birthDate: birthDate);

    siginUpStatus = await service.register(user);
    message = service.message;
    token=service.token;

    if (siginUpStatus) {
      // هنا يمكنك إضافة منطق لتخزين التوكن إذا لزم الأمر
      print("Registration succeeded");
    } else {
      print("Registration failed");
    }
  }
}
