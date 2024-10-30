import 'package:flutter/material.dart';
import 'package:flutter_application_1/cubit/user_cubit.dart';
import 'package:flutter_application_1/cubit/user_state.dart';
import 'package:flutter_application_1/screen/login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _HomePageState();
}

class _HomePageState extends State<SignUpPage> {
  //confirmpassword
  final TextEditingController signUpconfirmPassword = TextEditingController();

  // متغيرات لإظهار أو إخفاء كلمة المرور
  bool _isPasswordObscured = true;
  bool _isConfigPasswordObscured = true;

  DateTime date = DateTime.now();

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
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            "Sign Up",
            style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                wordSpacing: 4,
                color: Colors.purpleAccent),
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
                context.read<UserCubit>().signUpName,
              ),
              const SizedBox(
                height: 30,
              ),
              component1(
                Icons.email,
                'Email...',
                false,
                context.read<UserCubit>().signUpEmail,
              ),
              const SizedBox(
                height: 30,
              ),
              component1(
                Icons.lock_outline,
                'Password...',
                _isPasswordObscured,
                context.read<UserCubit>().signUpPassword,
                suffixIcon: IconButton(
                  icon: Icon(_isPasswordObscured
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _isPasswordObscured = !_isPasswordObscured;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              component1(
                Icons.lock_outline,
                'Re-enter Password...',
                _isConfigPasswordObscured,
                signUpconfirmPassword,
                suffixIcon: IconButton(
                  icon: Icon(_isConfigPasswordObscured
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _isConfigPasswordObscured = !_isConfigPasswordObscured;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              RadioListTile(
                  activeColor: Colors.purple,
                  title: const Text("male"),
                  value: "male",
                  groupValue: context.read<UserCubit>().country,
                  onChanged: (val) {
                    setState(() {
                      context.read<UserCubit>().country = val;
                    });
                  }),
              RadioListTile(
                  activeColor: Colors.purple,
                  title: const Text("female"),
                  value: "female",
                  groupValue: context.read<UserCubit>().country,
                  onChanged: (val) {
                    setState(() {
                      context.read<UserCubit>().country = val;
                    });
                  }),
              Text(
                '${date.day}/${date.month}/${date.year}',
                style: const TextStyle(fontSize: 15, color: Colors.white),
              ),
              ElevatedButton(
                iconAlignment: IconAlignment.start,
                child: const Text(
                  'Select a date:',
                  style: TextStyle(fontSize: 20, color: Colors.purple),
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
                  });
                },
              ),
              const SizedBox(
                height: 70,
              ),
              state is SignUploading
                  ? const CircularProgressIndicator()
                  : component2('Continue', 2, () {
                      if (context.read<UserCubit>().signUpName.text.isEmpty ||
                          context.read<UserCubit>().signUpEmail.text.isEmpty ||
                          context
                              .read<UserCubit>()
                              .signUpPassword
                              .text
                              .isEmpty ||
                          signUpconfirmPassword.text.isEmpty ||
                          context.read<UserCubit>().country == null) {
                        // عرض رسالة الخطأ إذا كانت هناك حقول فارغة
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('يرجى ملئ الحقول')),
                        );
                      } else if (context
                              .read<UserCubit>()
                              .signUpPassword
                              .text !=
                          signUpconfirmPassword.text) {
                        // عرض رسالة الخطأ إذا كانت كلمات المرور لا تتطابق
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('كلمات المرور غير متطابقة')),
                        );
                      } else if (context
                              .read<UserCubit>()
                              .signUpPassword
                              .text
                              .length <
                          4) {
                        // عرض رسالة الخطأ إذا كانت كلمة المرور قصيرة
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'يرجى كتابة كلمة السر بطول ال 4 على الاقل')),
                        );
                      } else {
                        // استدعاء دالة signUp من cubit
                        context.read<UserCubit>().signUp(context);
                      }
                    }),
            ],
          ),
        )),
      );
    }));
  }
}

Widget component1(
  IconData icon,
  String hintText,
  bool isPassword,
  TextEditingController? controller, {
  Widget? suffixIcon,
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(15),
    child: Container(
      height: 50,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255).withOpacity(.3),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        style: TextStyle(
          color: Color.fromARGB(255, 255, 255, 255).withOpacity(.8),
          fontWeight: FontWeight.bold,
        ),
        cursorColor: Color.fromARGB(255, 255, 255, 255),
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.purpleAccent.withOpacity(.7),
          ),
          border: InputBorder.none,
          hintMaxLines: 1,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14,
            color: Color.fromARGB(255, 255, 255, 255).withOpacity(.5),
          ),
          suffixIcon: suffixIcon,
        ),
      ),
    ),
  );
}
