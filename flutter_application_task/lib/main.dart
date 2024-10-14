import 'package:flutter/material.dart';
import 'package:flutter_application_task/getx_bainding/edit_binding.dart';
import 'package:flutter_application_task/getx_bainding/home_page_binding.dart';
import 'package:flutter_application_task/getx_bainding/login_binding.dart';
import 'package:flutter_application_task/getx_bainding/siginUp_binding.dart';
import 'package:flutter_application_task/getx_bainding/welcome_binding.dart';
import 'package:flutter_application_task/moduels/Edit/update.dart';
import 'package:flutter_application_task/moduels/home_page/home_page.dart';
// ignore: unused_import

import 'package:flutter_application_task/moduels/landing/Welcome.dart';
import 'package:flutter_application_task/moduels/login/Sigin.dart';

import 'package:flutter_application_task/moduels/register/Sigin%20up.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';
void main() {
  runApp(
GetMaterialApp(
      debugShowCheckedModeBanner: false,
initialRoute: '/SECOND',
getPages: [
 GetPage(name: '/first', page: ()=>Sigin(), binding: LoginBinding()),
  GetPage(name: '/fir', page: ()=>Welcome(), binding: WelcomeBinding()),
  GetPage(name: '/SECOND', page: ()=>Login(), binding: SiginupBinding()),
   GetPage(name: '/home', page: ()=>HomePage(), binding: HomePageBinding()),
   GetPage(name: '/update_profile', page: ()=>UpdateProfilePage(), binding: EditBinding()),

  // '/fiet':(context) => const Welcome(),
   // '/second':(context) => const Login(),

],
  builder: EasyLoading.init(),
    ),

  );
}



  // This widget is the root of your application.

