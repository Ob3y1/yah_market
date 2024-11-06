import 'package:flutter/material.dart';
import 'package:flutter_application_task/controller/ProductsController%20.dart';

import 'package:get/get.dart';

class ProductsPage extends StatelessWidget {
  final ProductsController productsController = Get.put(ProductsController());

  @override
  Widget build(BuildContext context) {
    final int categoryId = Get.arguments;
    // تأكد من أن الجلب يتم مرة واحدة فقط
    if (productsController.products.isEmpty) {
      productsController.fetchProducts(categoryId);
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4C53A5),
        title: Text('Products'),
      ),
      body: Obx(() {
        if (productsController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (productsController.products.isEmpty) {
          return Center(child: Text('No products available.'));
        }
        return GridView.builder(
          itemCount: productsController.products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.68,
          ),
          itemBuilder: (context, index) {
            var product = productsController.products[index];
            return GestureDetector(
              onTap: () {
                Get.toNamed('/productDetails', arguments: product['id']);
              },
              child: Card(
                elevation: 5,
                child: Column(
                  children: [
                    Image.network(
                      product['image_path'] != '0'
                          ? product['image_path']
                          : 'assets/images/default_product_image.png',
                      height: 100,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.error); // عرض أيقونة عند فشل تحميل الصورة
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        product['name'] ?? 'Unnamed',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4C53A5),
                        ),
                      ),
                    ),
                    Text(
                      "\$${product['price']}",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4C53A5),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
