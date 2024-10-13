import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/api/api_consumer.dart';
import 'package:flutter_application_1/core/api/end_points.dart';
import 'package:flutter_application_1/core/errors/exceptions.dart';
import 'package:flutter_application_1/cubit/user_state.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/model/login_model.dart';
import 'package:flutter_application_1/model/user_model.dart';
import 'package:flutter_application_1/screen/edit.dart';
import 'package:flutter_application_1/screen/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.api) : super(UserInitial());
  final ApiConsumer api;
  //sign in Form Key
  var dio = Dio();
  // GlobalKey<FormState> signInFormKey = GlobalKey();
  final TextEditingController editnameController = TextEditingController(
    text: prefs.getString("name"),
  );
  final TextEditingController editemailController = TextEditingController(
    text: prefs.getString("email"),
  );

  final TextEditingController editbirthDateController = TextEditingController(
    text: prefs.getString("birth_date"),
  );

  String? editselectedGender;
// sign in email
  final TextEditingController signInEmail = TextEditingController();
// sign in password
  final TextEditingController signInPassword = TextEditingController();
// sign up Form Key
  GlobalKey<FormState> signUpFormKey = GlobalKey();
// sign up name
  final TextEditingController signUpName = TextEditingController();
// sign up phone number
  final TextEditingController signUpPhone = TextEditingController();
// sign up email
  final TextEditingController signUpEmail = TextEditingController();
// sign up password
  final TextEditingController signUpPassword = TextEditingController();
  //confirmpassword
  final TextEditingController signUpconfirmPassword = TextEditingController();
  //birthday
  final TextEditingController date = TextEditingController();
  //gender
  String? country = "";
  LoginModel? user;
  UserShow users = UserShow();
  void showError(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: const Color.fromARGB(255, 115, 115, 115),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void login() async {
    emit(SignInloading());
    var url = EndPoints.basUrl + EndPoints.login;

    var body = {"email": signInEmail.text, "password": signInPassword.text};

    try {
      var response = await dio.post(
        url,
        data: body,
      );
      user = LoginModel.fromJson(response.data);
      prefs.setString("token", user!.token.toString());
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        print(response.data);

        emit(SignInSuccess()); // بيانات الاستجابة
        await show();
      } else {
        print('Error: ${response.statusMessage}');
        emit(SignInFailuer(errMessage: "Error")); // رسالة الخطأ
      }
    } on DioError catch (e) {
      // معالجة أخطاء Dio (مثل مشاكل الشبكة أو انتهاء المهلة أو غيرها)
      if (e.type == DioErrorType.connectionTimeout) {
        print('Connection Timeout Error');
        emit(SignInFailuer(errMessage: "Connection Timeout"));
      } else if (e.type == DioErrorType.receiveTimeout) {
        print('Receive Timeout Error');
        emit(SignInFailuer(errMessage: "Receive Timeout"));
      } else if (e.type == DioErrorType.badResponse) {
        // معالجة أخطاء الاستجابة من السيرفر
        print(
            'Server Error: ${e.response?.statusCode} - ${e.response?.statusMessage}');
        emit(SignInFailuer(errMessage: "يوجد  خطا في الاتصال"));
        //emit(SignInFailuer(errMessage: "Server Error: ${e.response?.statusMessage}"));
      } else {
        print('Unexpected Error: ${e.message}');
        emit(SignInFailuer(errMessage: "Unexpected Error"));
      }
    } catch (e) {
      // معالجة أي استثناءات أخرى
      print('Unknown Error: $e');
      emit(SignInFailuer(errMessage: "Unknown Error"));
    }
  }

  signUp() async {
    var body = {
      "name": signUpName.text,
      "email": signUpEmail.text,
      "birth_date": date.text,
      "gender": country,
      "password": signUpPassword.text
    };

    var url = EndPoints.basUrl + EndPoints.register;
    try {
      emit(SignUploading());
      Response response = await dio.post(
        url,
        data: body,
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        print(response.data);
        emit(SignUpSuccess());
      } else {
        print(response.statusMessage);
      }
    } on ServerException catch (e) {
      emit(SignUpFailuer(errMessage: e.errorModel.error));
      print('Error: $e');
    }
  }

  logout() async {
    print(prefs.getString("token"));
    String url = EndPoints.basUrl + EndPoints.logout;
    var headers = {
      'Authorization': "Bearer ${prefs.getString("token")}",
    };

    emit(Logoutloading());
    var response = await dio.get(
      url,
      options: Options(headers: headers),
    );

    print(response.statusCode);
    // Checking if the request was successful
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      print(response.data);
      emit(LogoutSuccess());
    } else {
      print(response.statusMessage);
    }
  }

  Future show() async {
    var url = EndPoints.basUrl + EndPoints.showProfile;

    var headers = {
      'Authorization': "Bearer ${prefs.getString("token")}",
    };

    try {
      Response response = await dio.get(
        'http://localhost:8000/api/user',
        options: Options(headers: headers),
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        Map<String, dynamic> userData = response.data;

        // استخراج البيانات
        await prefs.setString("id", userData['id'].toString());
        await prefs.setString("name", userData['name']);
        await prefs.setString("email", userData['email']);
        await prefs.setString("birth_date", userData['birth_date']);
        await prefs.setString("gender", userData['gender']);
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print(e);
    }
  }

  updateUser(BuildContext con) async {
    emit(GetUserLoading());
    var url = EndPoints.basUrl + EndPoints.update;

    var headers = {
      'Authorization': "Bearer ${prefs.getString("token")}",
      'Content-Type': 'application/json',
    };

    var body = {
      "name": editnameController.text,
      "email": editemailController.text,
      "birth_date": editbirthDateController.text,
      "gender": editselectedGender,
      "deleted_at": null
    };

    print('Body: $body'); // طباعة الجسم قبل الطلب

    try {
      Response response = await dio.put(
        url,
        options: Options(headers: headers),
        data: json.encode(body), // تمرير البيانات في body
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        print('Response Data: ${response.data}');
        emit(GetUserSuccess());
        Navigator.pushAndRemoveUntil(
          con,
          MaterialPageRoute(
            builder: (context) => AnimatedBackgroundPage(),
          ),
          (route) => false,
        );
      } else {
        print('Error: ${response.statusMessage}');
        emit(GetUserFailure(
            errMessage: response.statusMessage ?? 'Unknown error'));
      }
    } catch (e) {
      print('Caught an exception: $e'); // طباعة الاستثناء
      emit(GetUserFailure(
          errMessage: e.toString())); // إصدار حالة الفشل مع رسالة الخطأ
    }
  }
}
