import 'package:flutter_application_task/moduels/Edit/update_service.dart';
import 'package:flutter_application_task/moduels/users.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UpdateController extends GetxController {
  var name = '';
  var email = '';
  var gender = '';
  DateTime? birthDate;
  var userInfo = Users().obs;

  UpdateService service = UpdateService();

  @override
  void onInit() {
    super.onInit();
    loadUserInfo();
  }

  Future<void> loadUserInfo() async {
    String? token = GetStorage().read('token');
    if (token != null) {
      userInfo.value = await service.getUserInfo(token);
    }
  }

  Future<void> updateUser() async {
    String? token = GetStorage().read('token');
    if (token != null) {
      var success = await service.updateUser(
        Users(name: name, email: email, gender: gender, birthDate: birthDate),
        token,
      );
      if (success) {
        Get.snackbar('Success', 'User info updated successfully.');
      } else {
        Get.snackbar('Error', 'Failed to update user info.');
      }
    }
  }

  Future<void> logout() async {
    String? token = GetStorage().read('token');
    if (token != null) {
      await service.logout(token);
      GetStorage().remove('token');
      Get.offAllNamed('/login');
    }
  }
}