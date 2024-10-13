import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/cache/cache_helper.dart';
import 'package:flutter_application_1/core/api/dio_consumer.dart';
import 'package:flutter_application_1/cubit/user_cubit.dart';
import 'package:flutter_application_1/screen/home.dart';
import 'package:flutter_application_1/screen/login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;
void main() async {
  CacheHelper().init();
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  runApp(
    BlocProvider(
        create: (context) => UserCubit(DioConsumer(dio: Dio())),
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: prefs.getString("token") == null
          ? const LoginScreen()
          : AnimatedBackgroundPage(),
    );
  }
}
