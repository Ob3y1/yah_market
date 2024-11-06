import 'package:flutter_application_task/config/service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductsController extends GetxController {
  var products = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;
  final storage = GetStorage();

  Future<void> fetchProducts(int categoryId) async {
    final token = storage.read('token');
    if (token == null || token.isEmpty) {
      Get.snackbar('Error', 'Token is missing. Please log in again.');
      Get.offAllNamed('/first');
      return;
    }

    final url = Uri.parse(ServiceConf.domainNameServer + ServiceConf.proudct.replaceFirst('{id}', categoryId.toString()));
    try {
      isLoading(true);
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        if (jsonResponse is List && jsonResponse.isNotEmpty) {
          products.value = jsonResponse.map((product) {
            return {
              'id': product['id'] ?? 0,
              'name': product['name'] ?? 'Unknown',
              'description': product['description'] ?? '',
              'price': product['price'] ?? '0.00',
              'image_path': product['image_path'] != '0' ? product['image_path'] : 'assets/images/default_product_image.png',
            };
          }).toList();
        } else {
          Get.snackbar('Warning', 'No products found.');
        }
      } else {
        var errorDetails = jsonDecode(response.body);
        Get.snackbar('Error', 'Failed to load products: $errorDetails');
      }
    } catch (error) {
      Get.snackbar('Error', 'Failed to load products: $error');
    } finally {
      isLoading(false);
    }
  }
}
