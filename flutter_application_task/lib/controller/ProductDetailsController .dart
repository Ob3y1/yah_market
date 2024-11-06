import 'package:flutter_application_task/config/service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProductDetailsController extends GetxController {
  var isLoading = true.obs;
  var product = {}.obs;
  final storage = GetStorage();

  void fetchProductDetails(int productId) async {
    final token = storage.read('token');
    if (token == null || token.isEmpty) {
      Get.snackbar('Error', 'Token is missing. Please log in again.');
      Get.offAllNamed('/first');
      return;
    }
    try {
      isLoading(true);
      var response = await ServiceConf.fetchProductDetails(productId, token);
      product.value = response;
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }
}
