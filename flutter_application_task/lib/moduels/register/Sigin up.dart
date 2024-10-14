// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_application_task/Components/custom_button.dart';
import 'package:flutter_application_task/Components/custom_textField.dart';
import 'package:flutter_application_task/moduels/register/register_Controler.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  RegisterController controller = Get.find();
  bool _isPasswordVisible = false;
  String? _selectedGender;
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.only(top: 60.0, left: 22),
              child: Text(
                'Create Your\nAccount',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18),
                child: ListView(children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      CustomTextfield(
                        onChanged: (value) {
                          controller.fullName = value;
                        },
                        labelText: "User Name",
                        keyboard: TextInputType.name,
                        textColor: Colors.black,
                      ),
                      SizedBox(height: 10),
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
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            _isPasswordVisible = !_isPasswordVisible;
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      // Gender Dropdown
                      DropdownButtonFormField<String>(
                        value: _selectedGender,
                        hint: Text("Select Gender"),
                        items: <String>['Male', 'Female', 'Other']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          _selectedGender = value;
                          controller.gender =
                              value!; 
                        },
                      ),

                      SizedBox(height: 10),

             
                      TextButton(
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                          );
                          if (pickedDate != null) {
                            _selectedDate = pickedDate;
                            controller.birthDate =
                                pickedDate; 
                          }
                        },
                        child: Text(
                          _selectedDate == null
                              ? "Select Birth Date"
                              : "Birth Date: ${_selectedDate!.toLocal()}"
                                  .split(' ')[0],
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 70),

                      CustomButton(
                        width: 350,
                        fontColor: Colors.white,
                        fontSize: 25,
                        ButtonColor: Color.fromARGB(232, 84, 83, 83),
                        height: 50,
                        onTap: () {
                          onClickRegister();
                        },
                        buttonName: "Sign Up",
                      ),

                      SizedBox(height: 80),

                      Align(
                        alignment: Alignment.bottomRight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed('/first');
                              },
                              child: Text(
                                "Sign in",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }


  void onClickRegister() async {
    print("Register button clicked");
    EasyLoading.show(
      status: "loading",
    );
    await controller.RegisterOnClick();

    if (controller.siginUpStatus) {
      EasyLoading.showSuccess( 'Loading...');
      Get.offNamed('/update_profile');
    } else {
      EasyLoading.showError(controller.message,duration: Duration(seconds: 10),dismissOnTap: true);
      

      Get.snackbar(  "error",
          "Registration failed. Please check your details and try again.");
    }
  }
}
