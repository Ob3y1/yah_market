// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_application_task/Components/custom_button.dart';
import 'package:flutter_application_task/Components/custom_textField.dart';
import 'package:flutter_application_task/moduels/login/login_controller.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class Sigin extends StatelessWidget {
  LoginController controller = Get.find();
  Sigin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isPasswordVisible = false;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 48, 45, 45),
                  Color.fromARGB(255, 226, 226, 226),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 60, left: 20),
              child: Text(
                "Sigin In",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(243, 255, 255, 255),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 250),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromARGB(235, 185, 184, 184),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),
              child: Padding(
                
                padding:EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextfield(
                      onChanged: (value) {
                        controller.email = value;
                      },
                      labelText: "Email",
                      keyboard: TextInputType.emailAddress,
                      textColor: Colors.black,
                    ),
                    SizedBox(height: 10),
                    CustomTextfield(
                      keyboard: TextInputType.visiblePassword,
                      onChanged: (value) {
                        controller.password = value;
                      },
                      textColor: Colors.black,
                      labelText: "Password",
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              // ignore: dead_code
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          _isPasswordVisible = !_isPasswordVisible;
                        },
                      ),
                    ),
                    SizedBox(height: 12),
                    SizedBox(height: 50),
                    CustomButton(
                      width: 350,
                      fontColor: Colors.white,
                      fontSize: 25,
                      ButtonColor: Color.fromARGB(232, 84, 83, 83),
                      height: 50,
                      onTap: () {
                        onClickRegister1();
                      },
                      buttonName: "Sign IN",
                    ),
                    SizedBox(height: 100),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Column(
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              onClickRegister1();
                            },
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                "Sign in",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
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
  }

 void onClickRegister1() async {
  print("Register button clicked");
  EasyLoading.show(status: "loading");

  await controller.loginOnClick();

  if (controller.loginStatus) {
    EasyLoading.showSuccess("Login successful", dismissOnTap: true);
    Get.offAllNamed('/first1'); // تأكد أن الصفحة /first1 جاهزة للعمل بدون بيانات ناقصة
  } else {
    EasyLoading.showError(controller.message, duration: Duration(seconds: 10), dismissOnTap: true);
    Get.snackbar("Error", "Login failed. Please check your credentials and try again.");
  }
}
}
