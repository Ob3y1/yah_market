import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Itemsappbar extends StatelessWidget {
  const Itemsappbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(24),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
              size: 28,
              color: Color(0xFF4C53A5),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 18),
            child: Text(
              "Product Details",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 21,
                color: Color(0xFF4C53A5),
              ),
            ),
          ),
          Spacer(),
          Icon(
            Icons.favorite_border,
            size: 28,
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
