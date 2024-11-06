import 'package:flutter/material.dart';
import 'package:flutter_application_task/getx_bainding/ProductDetails_binding.dart';
import 'package:flutter_application_task/getx_bainding/Product_binding.dart';
import 'package:flutter_application_task/getx_bainding/categories_binding.dart';
import 'package:flutter_application_task/getx_bainding/edit_binding.dart';
import 'package:flutter_application_task/getx_bainding/home_page_binding.dart';
import 'package:flutter_application_task/getx_bainding/login_binding.dart';
import 'package:flutter_application_task/getx_bainding/siginUp_binding.dart';
import 'package:flutter_application_task/getx_bainding/welcome_binding.dart';
import 'package:flutter_application_task/moduels/Edit/update.dart';
import 'package:flutter_application_task/moduels/home_page/home_page.dart';
import 'package:flutter_application_task/moduels/landing/Welcome.dart';
import 'package:flutter_application_task/moduels/login/Sigin.dart';
import 'package:flutter_application_task/moduels/register/Sigin%20up.dart';
import 'package:flutter_application_task/pages/ProductDetailsPage%20.dart';

import 'package:flutter_application_task/pages/home1.dart';

import 'package:flutter_application_task/pages/product.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init(); // تهيئة GetStorage
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/first',
      getPages: [
        GetPage(name: '/first', page: () => Sigin(), binding: LoginBinding()),
        GetPage(name: '/fir', page: () => Welcome(), binding: WelcomeBinding()),
        GetPage(name: '/SECOND', page: () => Login(), binding: SiginupBinding()),
        GetPage(name: '/first1', page: () => Homepage(), binding: CategoriesBinding(),),
        GetPage(name: '/products', page: () => ProductsPage(), binding: ProductBinding()),
        GetPage(name: '/productDetails', page: () => ProductDetailsPage(), binding: ProductdetailsBinding()),
      ],
      builder: EasyLoading.init(),
    ),
  );
}
