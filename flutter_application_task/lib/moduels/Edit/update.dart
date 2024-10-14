import 'package:flutter/material.dart';
import 'package:flutter_application_task/Components/custom_button.dart';
import 'package:flutter_application_task/Components/custom_textField.dart';
import 'package:flutter_application_task/moduels/Edit/update_controller.dart';
import 'package:get/get.dart';

class UpdateProfilePage extends StatelessWidget {
  final UpdateController controller = Get.find();
  String? _selectedGender;
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextfield(
              onChanged: (value) {
                controller.name = value;
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
                controller.gender = value!;
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
                  controller.birthDate = pickedDate;
                }
              },
              child: Text(
                _selectedDate == null
                    ? "Select Birth Date"
                    : "Birth Date: ${_selectedDate!.toLocal()}".split(' ')[0],
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
              buttonName: "Update",
              onTap: () async {
                await controller.updateUser();
                Get.toNamed('/home');
              },
            ),
            ElevatedButton(
              onPressed: () async {
                await controller.logout();
                Get.offAllNamed('/first');
              },
              child: Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}