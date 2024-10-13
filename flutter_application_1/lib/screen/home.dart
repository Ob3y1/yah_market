import 'package:flutter/material.dart';
import 'package:animated_background/animated_background.dart';
import 'package:flutter_application_1/cubit/user_cubit.dart';
import 'package:flutter_application_1/cubit/user_state.dart';
import 'package:flutter_application_1/screen/edit.dart';
import 'package:flutter_application_1/screen/login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimatedBackgroundPage(), // استدعاء الصفحة دون تمرير قيم
    );
  }
}

class AnimatedBackgroundPage extends StatefulWidget {
  @override
  _AnimatedBackgroundPageState createState() => _AnimatedBackgroundPageState();
}

class _AnimatedBackgroundPageState extends State<AnimatedBackgroundPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is Logoutloading) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Successfully logged out")),
          );
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
            (route) => false,
          );
        } else if (state is LogoutFailuer) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errMessage)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('خلفية حية'),
            actions: <Widget>[
              PopupMenuButton<String>(
                onSelected: (String result) {
                  if (result == 'logout') {
                    context
                        .read<UserCubit>()
                        .logout(); // استدعاء عملية تسجيل الخروج
                  } else if (result == 'edit_profile') {
                    // الانتقال إلى صفحة تعديل المعلومات
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditInfoScreen(),
                      ),
                    );
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'edit_profile',
                    child: Text('Edit Profile'), // زر تعديل المعلومات
                  ),
                  const PopupMenuItem<String>(
                    value: 'logout',
                    child: Text('Logout'), // زر تسجيل الخروج
                  ),
                ],
              ),
            ],
          ),
          body: Stack(
            children: <Widget>[
              AnimatedBackground(
                behaviour: RandomParticleBehaviour(),
                vsync: this,
                child: Center(
                  child: Text(
                    'مرحباً في الخلفية الحية!',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
