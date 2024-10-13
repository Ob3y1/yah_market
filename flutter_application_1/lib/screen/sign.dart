import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/api/end_points.dart';
import 'package:flutter_application_1/cubit/user_cubit.dart';
import 'package:flutter_application_1/cubit/user_state.dart';
import 'package:flutter_application_1/screen/login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>
    with SingleTickerProviderStateMixin {
  
  DateTime date = DateTime.now();

  String? country = "";
  late AnimationController _controller;
  late Animation<Color?> _backgroundColor;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _backgroundColor = ColorTween(
      begin: Colors.yellow,
      end: Colors.green,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocConsumer<UserCubit, UserState>(listener: (context, state) {
      if (state is SignUpSuccess) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("success")));
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
          (route) => false,
        );
      } else if (state is SignUpFailuer) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.errMessage)));
      }
    }, builder: (context, state) {
      return AnimatedBuilder(
        animation: _backgroundColor,
        builder: (context, child) {
          return Scaffold(
            body: AnimatedContainer(
              duration: const Duration(seconds: 3),
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
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: context.read<UserCubit>().signUpFormKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'Create Account',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 30),

                          // حقل الاسم
                          _buildTextField(
                            controller: context.read<UserCubit>().signUpName,
                            labelText: 'Name',
                            icon: Icons.person,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // حقل البريد الإلكتروني
                          _buildTextField(
                            controller: context.read<UserCubit>().signUpEmail,
                            labelText: 'Email',
                            icon: Icons.email,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                  .hasMatch(value)) {
                                return 'Enter a valid email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // حقل كلمة المرور
                          _buildTextField(
                            controller:
                                context.read<UserCubit>().signUpPassword,
                            labelText: 'Password',
                            icon: Icons.lock,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              } else if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // تأكيد كلمة المرور
                          _buildTextField(
                            controller:
                                context.read<UserCubit>().signUpconfirmPassword,
                            labelText: 'Confirm Password',
                            icon: Icons.lock_outline,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm your password';
                                // ignore: unrelated_type_equality_checks
                              } else if (value !=
                                  context
                                      .read<UserCubit>()
                                      .signUpconfirmPassword) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // تحديد الجنس
                          RadioListTile(
                              activeColor: Colors.purple,
                              title: const Text("male"),
                              value: "male",
                              groupValue: country,
                              onChanged: (val) {
                                setState(() {
                                  country = val;
                                  context.read<UserCubit>().country = val;
                                });
                              }),
                          RadioListTile(
                              activeColor: Colors.purple,
                              title: const Text("female"),
                              value: "female",
                              groupValue: country,
                              onChanged: (val) {
                                setState(() {
                                  country = val;
                                  context.read<UserCubit>().country = val;
                                });
                              }),
                          const SizedBox(height: 16),

                          // تاريخ الميلاد
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
                                context.read<UserCubit>().date.text =
                                    newDate.toString();
                              });
                            },
                          ),
                          const SizedBox(height: 32),

                          // زر التسجيل
                          ElevatedButton(
                            onPressed: () {
                              context.read<UserCubit>().signUp();
                            },
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
                            child: state is SignUploading
                                ? const CircularProgressIndicator()
                                : const Text('Sign Up'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    }));
  }

  InputDecoration _buildInputDecoration(String labelText, IconData icon) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(color: Colors.black),
      filled: true,
      fillColor: Colors.white,
      prefixIcon: Icon(icon, color: Colors.black),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: _buildInputDecoration(labelText, icon),
      validator: validator,
    );
  }
}
