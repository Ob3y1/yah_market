
import 'package:flutter_application_task/moduels/register/register_Controler.dart';
import 'package:get/get.dart';

class SiginupBinding implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<RegisterController>(RegisterController());
  }

}