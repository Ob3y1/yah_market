import 'package:flutter/material.dart';
import 'package:flutter_application_task/controller/ProductDetailsController%20.dart';

import 'package:get/get.dart';

class ProductDetailsPage extends StatelessWidget {
  final ProductDetailsController productDetailsController = Get.put(ProductDetailsController());

  @override
  Widget build(BuildContext context) {
    final int productId = Get.arguments;
    productDetailsController.fetchProductDetails(productId);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF4C53A5)),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'Product Details',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4C53A5),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border, color: Colors.red),
            onPressed: () {},
          ),
        ],
      ),
      body: Obx(() {
        if (productDetailsController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (productDetailsController.product.isEmpty) {
          return Center(child: Text('Product not found'));
        }
        var product = productDetailsController.product;
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.network(
                    product['image_path'] != '0'
                        ? product['image_path']
                        : 'assets/images/default_product_image.png',
                    height: 250,
                    width: 250,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  product['name'] ?? 'Unnamed Product',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4C53A5),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "\$${product['price']}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4C53A5),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  product['description'] ?? 'No description available',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // قم بإضافة المنتج إلى السلة هنا
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "Add to Cart",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.favorite, color: Colors.red),
                      onPressed: () {
                        // قم بإضافة المنتج إلى المفضلة هنا
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
