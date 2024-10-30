import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/screen/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/cubit/user_cubit.dart';
import 'package:flutter_application_1/cubit/user_state.dart';


class EditInfoScreen extends StatefulWidget {
  const EditInfoScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EditInfoScreenState createState() => _EditInfoScreenState();
}

class _EditInfoScreenState extends State<EditInfoScreen>
    with TickerProviderStateMixin {
       DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Colors.white,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.black,
        title: const Text(
          "Edit Your Information:",
          style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              wordSpacing: 1,
              color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
            ),
            component1(
                Icons.account_circle_outlined,
                'User Name...',
                false,
                context.read<UserCubit>().editnameController,
                TextInputType.text),
            const SizedBox(
              height: 30,
            ),
            component1(
                Icons.email,
                'Email...',
                false,
                context.read<UserCubit>().editemailController,
                TextInputType.text),
            const SizedBox(
              height: 30,
            ),

            RadioListTile(
                activeColor: Colors.purple,
                title: const Text("male"),
                value: "male",
                groupValue: context.read<UserCubit>().editselectedGender,
                onChanged: (val) {
                  setState(() {
                    context.read<UserCubit>().editselectedGender = val;
                  });
                }),
            RadioListTile(
                activeColor: Colors.purple,
                title: const Text("female"),
                value: "female",
                groupValue: context.read<UserCubit>().editselectedGender,
                onChanged: (val) {
                  setState(() {
                    context.read<UserCubit>().editselectedGender = val;
                  });
                }),

              Text(
                            '${date.day}/${date.month}/${date.year}',
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          ElevatedButton(
                            iconAlignment: IconAlignment.start,
                            child: const Text(
                              'Select a date:',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.purple),
                            ),
                            onPressed: () async {
                              DateTime? newDate = await showDatePicker(
                                  context: context,
                                  initialDate: date,
                                  firstDate: DateTime(1500),
                                  lastDate: DateTime(2500));
                              if (newDate == null) return;
                              setState(() {
                                date = newDate;
                                context.read<UserCubit>().editbirthDateController.text =
                                    newDate.toString();
                              });
                            },
                          ),

            const SizedBox(
              height: 70,
            ),

            component2(
              'Edit',
              2,
              () {
                if (context
                        .read<UserCubit>()
                        .editnameController
                        .text
                        .isNotEmpty &&
                    context.read<UserCubit>().editselectedGender != "") {
                  if (context.read<UserCubit>().editnameController.text.length <
                      0) {
                    var snackBar = const SnackBar(
                        content:
                            Text('يرجى كتابة كلمة السر بطول ال 8 على الاقل '));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    var snackBar = const SnackBar(content: Text('succsses'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    context.read<UserCubit>().updateUser(context);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AnimatedBackgroundPage(),
                      ),
                      (route) => false,
                    );
                  }
                } else {
                  var snackBar =
                      const SnackBar(content: Text('يرجى ملئ الحقول'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
            ),
          ],
        ),
      )),
    ));
  }
}

Widget component1(
  IconData icon,
  String hintText,
  bool isSecurePassword,
  TextEditingController? controller,
  TextInputType keyboardType,
) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(15),
    child: Container(
      height: 50,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 0, 0, 0).withOpacity(.3),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        style: TextStyle(
            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(.8),
            fontWeight: FontWeight.bold),
        cursorColor: const Color.fromARGB(255, 0, 0, 0),
        obscureText: isSecurePassword,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(.7),
          ),
          border: InputBorder.none,
          hintMaxLines: 1,
          hintText: hintText,
          hintStyle: TextStyle(
              fontSize: 14,
              color: const Color.fromARGB(255, 0, 0, 0).withOpacity(.5)),
        ),
      ),
    ),
  );
}

Widget component2(String string, double width, VoidCallback voidCallback) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(15),
    child: InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: voidCallback,
      child: Container(
        height: 40,
        width: 200,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          string,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
}
