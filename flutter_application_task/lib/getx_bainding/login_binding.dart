import 'package:flutter_application_task/moduels/login/login_controller.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get.dart';

class LoginBinding implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<LoginController>(LoginController());
  }

}