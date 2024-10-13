import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubit/user_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final emailController = context.read<UserCubit>().signInEmail;
    final passwordController = context.read<UserCubit>().signInPassword;

    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: 'Enter your email',
              hintStyle: const TextStyle(color: Colors.black45),
              filled: true,
              fillColor: Colors.white.withOpacity(0.9),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 20,
              ),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              // يمكنك إضافة تحقق من صحة البريد الإلكتروني هنا إذا رغبت
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(
              hintText: 'Enter your password',
              hintStyle: const TextStyle(color: Colors.black45),
              filled: true,
              fillColor: Colors.white.withOpacity(0.9),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 20,
              ),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
