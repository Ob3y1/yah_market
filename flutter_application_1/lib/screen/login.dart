import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubit/user_cubit.dart';
import 'package:flutter_application_1/cubit/user_state.dart';
import 'package:flutter_application_1/screen/edit.dart';
import 'package:flutter_application_1/screen/form.dart';
import 'package:flutter_application_1/screen/home.dart';
import 'package:flutter_application_1/screen/sign.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _backgroundColor;
  GlobalKey<FormState> signInFormKey = GlobalKey();
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _backgroundColor = ColorTween(
      begin: Colors.greenAccent,
      end: Colors.yellowAccent,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  // Navigate to Sign Up page
  void _navigateToSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignUpPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is SignInSuccess) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("success")));
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
      },
      builder: (context, state) {
        return AnimatedBuilder(
          animation: _backgroundColor,
          builder: (context, child) {
            return Scaffold(
              body: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _backgroundColor.value ?? Colors.green,
                      Colors.yellowAccent.shade100,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: signInFormKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                'Welcome Back!',
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  letterSpacing: 1.5,
                                  shadows: [
                                    Shadow(
                                      offset: Offset(0, 3),
                                      blurRadius: 5.0,
                                      color: Colors.black38,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 50),
                              LoginForm(),
                              const SizedBox(height: 50),
                              // زر تسجيل الدخول
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.greenAccent,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 50,
                                    vertical: 15,
                                  ),
                                  textStyle: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  elevation: 10,
                                  shadowColor: Colors.yellowAccent,
                                ),
                                onPressed: () {
                                  context.read<UserCubit>().login();
                                },
                                child: state is SignInloading
                                    ? const CircularProgressIndicator()
                                    : const Text('Login'),
                              ),
                              const SizedBox(height: 20),

                              // زر إنشاء الحساب
                              TextButton(
                                onPressed: _navigateToSignUp,
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.black,
                                  textStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                child: const Text('Create Account'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
