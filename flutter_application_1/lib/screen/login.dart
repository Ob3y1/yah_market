import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/cubit/user_cubit.dart';
import 'package:flutter_application_1/cubit/user_state.dart';
import 'package:flutter_application_1/screen/sign.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(listener: (context, state) {
      if (state is SignInSuccess) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Success!")));
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => AnimatedBackgroundPage(),
          ),
          (route) => false,
        );
      } else if (state is SignInFailuer) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.errMessage)));
      }
    }, builder: (context, state) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            "Login",
            style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                wordSpacing: 4,
                color: Colors.purple),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 400,
                    ),
                    const Text("Please Login To Continue With Your Account:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          wordSpacing: 4,
                          color: Colors.purple
                        )),
                    const SizedBox(
                      height: 50,
                    ),
                    component1(Icons.email, 'Your Email...', false,
                        context.read<UserCubit>().signInEmail),
                    const SizedBox(
                      height: 20,
                    ),
                    component1(Icons.lock_outline, 'Password...', true,
                        context.read<UserCubit>().signInPassword),
                    const SizedBox(
                      height: 50,
                    ),
                    state is SignInloading
                        ? const CircularProgressIndicator()
                        : component2(
                            'Login',
                            2,
                            () {
                              if (context
                                      .read<UserCubit>()
                                      .signInEmail
                                      .text
                                      .isEmpty ||
                                  context
                                      .read<UserCubit>()
                                      .signInPassword
                                      .text
                                      .isEmpty) {
                                var snackBar = const SnackBar(
                                    content: Text('يرجى ملئ الحقول'));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else {
                                if (context
                                        .read<UserCubit>()
                                        .signInPassword
                                        .text
                                        .length <
                                    4) {
                                  var snackBar = const SnackBar(
                                      content: Text(
                                          'يرجى كتابة كلمة السر بطول ال 4 على الاقل '));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                } else {
                                  context.read<UserCubit>().login();
                                }
                              }
                            },
                          ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpPage(),
                          ),
                          (route) => false,
                        );
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

Widget component1(IconData icon, String hintText, bool isPassword,
    TextEditingController? controller) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(15),
    child: Container(
      height: 50,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255).withOpacity(.3),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(
            color: const Color.fromARGB(255, 0, 0, 0).withOpacity(.8),
            fontWeight: FontWeight.bold),
        cursorColor: Color.fromARGB(255, 255, 255, 255),
        obscureText: isPassword,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.purple.withOpacity(.7),
          ),
          border: InputBorder.none,
          hintMaxLines: 1,
          hintText: hintText,
          hintStyle: TextStyle(
              fontSize: 14,
              color: Color.fromARGB(255, 255, 255, 255).withOpacity(.5)),
        ),
      ),
    ),
  );
}

Widget component2(
  String string,
  double width,
  VoidCallback voidCallback,
) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(15),
    child: InkWell(
      highlightColor: const Color.fromARGB(0, 255, 255, 255),
      splashColor: const Color.fromARGB(0, 255, 253, 253),
      onTap: voidCallback,
      child: Container(
        height: 40,
        width: 200,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          string,
          style: const TextStyle(color: Colors.purple),
        ),
      ),
    ),
  );
}
