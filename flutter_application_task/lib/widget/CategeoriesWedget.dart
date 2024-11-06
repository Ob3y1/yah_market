// import 'package:flutter/material.dart';
// import 'package:flutter_application_task/controller/CategoriesController%20.dart';

// import 'package:get/get.dart';

// class CategeoriesWidget extends StatelessWidget {
//   final CategoriesController categoriesController = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       if (categoriesController.categories.isEmpty) {
//         return Center(child: CircularProgressIndicator());
//       }
//       return SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Row(
//           children: categoriesController.categories.map((category) {
//             return Container(
//               margin: EdgeInsets.symmetric(horizontal: 10),
//               padding: EdgeInsets.symmetric(vertical: 10),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Image.network(
//                     category['image_path'].isNotEmpty
//                         ? category['image_path']
//                         : 'assets/images/default_category_image.png', // صورة افتراضية
//                     width: 40,
//                     height: 40,
//                   ),
//                   SizedBox(width: 10),
//                   Text(
//                     category['name'] ?? 'Unnamed',  // استخدام 'Unnamed' إذا كان الاسم فارغاً
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Color(0xFF4C53A5),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }).toList(),
//         ),
//       );
//     });
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_application_task/controller/CategoriesController%20.dart';
import 'package:get/get.dart';

class CategeoriesWidget extends StatelessWidget {
  final CategoriesController categoriesController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (categoriesController.categories.isEmpty) {
        return Center(child: CircularProgressIndicator());
      }
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: categoriesController.categories.map((category) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    category['image_path'].isNotEmpty
                        ? category['image_path']
                        : 'assets/images/default_category_image.png', // صورة افتراضية
                    width: 40,
                    height: 40,
                  ),
                  SizedBox(width: 10),
                  Text(
                    category['name'] ?? 'Unnamed',  // استخدام 'Unnamed' إذا كان الاسم فارغاً
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4C53A5),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      );
    });
  }
}
