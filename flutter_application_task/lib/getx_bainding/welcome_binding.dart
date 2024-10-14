import 'package:flutter_application_task/moduels/landing/welcome_controller.dart';
import 'package:get/instance_manager.dart';

class WelcomeBinding implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
      Get.put<WelcomeController>(WelcomeController());
  }

}