import 'package:flutter/material.dart';
import 'package:flutter_application_task/controller/ProductsController%20.dart';

import 'package:get/get.dart';

class ItemsWidget extends StatelessWidget {
  final ProductsController productsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (productsController.products.isEmpty) {
        return Center(child: CircularProgressIndicator());
      }
      return GridView.builder(
        itemCount: productsController.products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.68,
        ),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          var product = productsController.products[index];
          return Container(
            padding: EdgeInsets.all(13),
            margin: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Get.toNamed('/product-details', arguments: product['id']);
                  },
                  child: Image.network(
                    product['image_path'] != '0'
                        ? product['image_path']
                        : 'assets/images/images (1).jpg',
                    height: 107,
                    width: 107,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.error); // عرض أيقونة عند فشل تحميل الصورة
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 7),
                  alignment: Alignment.center,
                  child: Text(
                    product['name'] ?? 'Unnamed',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4C53A5),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${product['price']}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4C53A5),
                        ),
                      ),
                      Icon(
                        Icons.shopping_cart_checkout,
                        color: Color(0xFF4C53A5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
