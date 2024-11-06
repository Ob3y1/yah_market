// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_task/controller/CategoriesController%20.dart';
import 'package:flutter_application_task/widget/homeAppBar.dart';
import 'package:get/get.dart';

class Homepage extends StatelessWidget {
  final CategoriesController categoriesController = Get.put(CategoriesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Homeappbar(),
          Container(
            padding: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
              color: Color(0xFFEDECF2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
            child: Column(
              children: [
                Obx(() {
                  // التحقق من وجود الفئات
                  if (categoriesController.categories.isEmpty) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: categoriesController.categories.map((category) {
                          return InkWell(
                            onTap: () {
                              Get.toNamed('/products', arguments: category['id']);
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // إضافة صورة مع التحقق من وجودها
                                  Image.network(
                                    category['image_path'],
                                    width: 40,
                                    height: 40,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(Icons.error, size: 40); // أيقونة عند وجود خطأ في تحميل الصورة
                                    },
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    category['name'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF4C53A5),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  }
                }),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Color(0xFF4C53A5),
        backgroundColor: Colors.transparent,
        height: 60,
        items: [
          Icon(Icons.home, size: 28, color: Colors.white),
          Icon(CupertinoIcons.cart_fill, size: 28, color: Colors.white),
          Icon(Icons.list, size: 28, color: Colors.white),
        ],
      ),
    );
  }
}
