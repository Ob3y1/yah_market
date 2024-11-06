import 'package:flutter/material.dart';
import 'package:flutter_application_task/controller/ProductDetailsController%20.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:clippy_flutter/arc.dart';
import '../widget/itemsAppBar.dart';

class Itemspage extends StatelessWidget {
  final ProductDetailsController productDetailsController = Get.put(ProductDetailsController());

  @override
  Widget build(BuildContext context) {
    final int productId = Get.arguments;
    productDetailsController.fetchProductDetails(productId);
    return Obx(() {
      if (productDetailsController.isLoading.value) {
        return Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }
      if (productDetailsController.product.isEmpty) {
        return Scaffold(
          body: Center(child: Text('Product not found')),
        );
      }
      var product = productDetailsController.product;
      return Scaffold(
        backgroundColor: Color(0xFFEDECF2),
        body: ListView(
          children: [
            Itemsappbar(),
            Padding(
              padding: EdgeInsets.all(19),
              child: Image.network(
                product['image_path'] != '0'
                    ? product['image_path']
                    : 'assets/images/default_product_image.png',
                height: 300,
              ),
            ),
            Arc(
              arcType: ArcType.CONVEX,
              height: 30,
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 45, bottom: 18),
                        child: Row(
                          children: [
                            Text(
                              product['name'] ?? 'Unnamed Product',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4C53A5),
                              ),
                            ),
                          ],
                        ),
                      ),
                      RatingBar.builder(
                        initialRating: 4,
                        minRating: 1,
                        direction: Axis.horizontal,
                        itemCount: 5,
                        itemSize: 20,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4),
                        itemBuilder: (context, _) => Icon(
                          Icons.favorite,
                          color: Color(0xFF4C53A5),
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 11),
                        child: Text(
                          product['description'] ?? 'No description available.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4C53A5),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 11),
                        child: Text(
                          "\$${product['price']}",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4C53A5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
