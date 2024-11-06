// import 'package:flutter/material.dart';
// import 'package:flutter_application_task/config/service.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:get_storage/get_storage.dart';

// // class CategoriesController extends GetxController {
// //   var categories = <Map<String, dynamic>>[].obs; // قائمة الفئات (مراقبة)
// //   final storage = GetStorage();  // لتخزين واسترجاع التوكن

// //   @override
// //   void onInit() {
// //     super.onInit();
// //     fetchCategories();  // استدعاء جلب الفئات عند بدء الـ Controller
// //   }

// //   Future<void> fetchCategories() async {
// //   final token = storage.read('token');  // قراءة التوكن من التخزين

// //   // تحقق من وجود التوكن
// //   if (token == null || token.isEmpty) {
// //     Get.snackbar('Error', 'Token is missing. Please log in again.');
// //     Get.offAllNamed('/first'); // العودة إلى صفحة تسجيل الدخول إذا لم يوجد التوكن
// //     return;
// //   }

// //   final url = Uri.parse('${ServiceConf.domainNameServer}${ServiceConf.categories}');

// //   try {
// //     // إرسال الطلب مع التوكن في الهيدر
// //     final response = await http.get(
// //       url,
// //       headers: {
// //         'Content-Type': 'application/json',
// //         'Authorization': 'Bearer $token',
// //       },
// //     );

// //     // طباعة الاستجابة لمعرفة ما يعيده الخادم
// //     print("Response status: ${response.statusCode}");
// //     print("Response body: ${response.body}");

// //     if (response.statusCode == 200) {
// //       // إذا كان الطلب ناجحًا، تحليل البيانات
// //       var jsonResponse = json.decode(response.body);

// //       // إذا كان `jsonResponse` قائمة وتحتوي على بيانات
// //       if (jsonResponse is List && jsonResponse.isNotEmpty) {
// //         categories.value = jsonResponse.map((category) {
// //           return {
// //             'id': category['id'] ?? 0,
// //             'name': category['name'] ?? 'Unknown',
// //             'image_path': category['image_path'] != '0' 
// //                 ? category['image_path'] 
// //                 : 'assets/images/default_category_image.png', 
// //           };
// //         }).toList();
// //       } else {
// //         Get.snackbar('Warning', 'No categories found.');
// //       }
// //     } else {
// //       // في حالة فشل الطلب، طباعة التفاصيل
// //       var errorDetails = jsonDecode(response.body);
// //       print("Error details: $errorDetails");
// //       Get.snackbar('Error', 'Failed to load categories: $errorDetails');
// //     }
// //   } catch (error) {
// //     // طباعة رسالة الخطأ لمزيد من التفاصيل
// //     print("Exception: $error");
// //     Get.snackbar('Error', 'Failed to load categories: $error');
// //   }
// // }
// // }
// class CategoriesController extends GetxController {
//   var categories = <Map<String, dynamic>>[].obs;
//   final storage = GetStorage();

//   @override
//   void onInit() {
//     super.onInit();
//     fetchCategories();
//   }

//   Future<void> fetchCategories() async {
//     final token = storage.read('token');
//     if (token == null || token.isEmpty) {
//       Get.snackbar('Error', 'Token is missing. Please log in again.');
//       Get.offAllNamed('/first');
//       return;
//     }

//     final url = Uri.parse('${ServiceConf.domainNameServer}${ServiceConf.categories}');

//     try {
//       final response = await http.get(
//         url,
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//       );

//       if (response.statusCode == 200) {
//         var jsonResponse = json.decode(response.body);
//         if (jsonResponse is List && jsonResponse.isNotEmpty) {
//           categories.value = jsonResponse.map((category) {
//             return {
//               'id': category['id'] ?? 0,
//               'name': category['name'] ?? 'Unknown',
//               'image_path': category['image_path'] != '0'
//                   ? category['image_path']
//                   : 'assets/images/default_category_image.png',
//             };
//           }).toList();
//         } else {
//           Get.snackbar('Warning', 'No categories found.');
//         }
//       } else {
//         var errorDetails = jsonDecode(response.body);
//         Get.snackbar('Error', 'Failed to load categories: $errorDetails');
//       }
//     } catch (error) {
//       Get.snackbar('Error', 'Failed to load categories: $error');
//     }
//   }
// }
import 'dart:convert';
import 'package:flutter_application_task/config/service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class CategoriesController extends GetxController {
  var categories = <Map<String, dynamic>>[].obs;
  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    final token = storage.read('token');
    if (token == null || token.isEmpty) {
      Get.snackbar('Error', 'Token is missing. Please log in again.');
      Get.offAllNamed('/first');
      return;
    }

    final url = Uri.parse('${ServiceConf.domainNameServer}${ServiceConf.categories}');
    try {
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
          categories.value = jsonResponse.map((category) {
            return {
              'id': category['id'] ?? 0,
              'name': category['name'] ?? 'Unknown',
              'image_path': category['image_path'] != '0' ? category['image_path'] : 'assets/images/default_category_image.png',
            };
          }).toList();
        } else {
          Get.snackbar('Warning', 'No categories found.');
        }
      } else {
        var errorDetails = jsonDecode(response.body);
        Get.snackbar('Error', 'Failed to load categories: ${errorDetails['message'] ?? 'Unknown error'}');
      }
    } catch (error) {
      Get.snackbar('Error', 'Failed to load categories: $error');
    }
  }
}

