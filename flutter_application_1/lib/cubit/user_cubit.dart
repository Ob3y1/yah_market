import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/api/api_consumer.dart';
import 'package:flutter_application_1/core/api/end_points.dart';
import 'package:flutter_application_1/core/errors/exceptions.dart';
import 'package:flutter_application_1/cubit/user_state.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/model/login_model.dart';
import 'package:flutter_application_1/model/user_model.dart';
import 'package:flutter_application_1/screen/home.dart';
import 'package:flutter_application_1/screen/login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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

  late final TextEditingController editbirthDateController =
      TextEditingController(
    text: prefs.getString("birth_date"),
  );
  String? editselectedGender = prefs.getString("gender");
// sign in email
  final TextEditingController signInEmail = TextEditingController();
// sign in password
  final TextEditingController signInPassword = TextEditingController();
  //sign in conf
  final TextEditingController signInconPassword = TextEditingController();
// sign up Form Key
  GlobalKey<FormState> signUpFormKey = GlobalKey();
// sign up name
  final TextEditingController signUpName = TextEditingController();
// sign up email
  final TextEditingController signUpEmail = TextEditingController();
// sign up password
  final TextEditingController signUpPassword = TextEditingController();
  //confirmpassword
  final TextEditingController signUpconfirmPassword = TextEditingController();
  DateTime selectedDate = DateTime.now(); // القيمة الافتراضية

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
        emit(SignInFailuer(errMessage: "يوجد خطأ في ادخال المعلومات"));
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

  signUp(BuildContext context) async {
    emit(SignInloading());

    // جمع البيانات في خريطة
    final data = {
      "name": signUpName.text,
      "email": signUpEmail.text,
      "birth_date": DateFormat('yyyy-MM-dd').format(selectedDate),
      "gender": country,
      "password": signUpPassword.text,
    };
    print(data);
    try {
      final response = await dio.post(
        'http://localhost:8000/api/register',
        data: data,
      );

      if (response.statusCode == 200) {
        print(response.data);
        print(data);
      } else {
        emit(SignUpSuccess());
        // الانتقال إلى صفحة تسجيل الدخول بعد نجاح التسجيل
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false, // إزالة جميع الصفحات من مكدس التنقل
        );
      }
    } catch (e) {
      if (e is DioError) {
        print('Error: ${e.response?.data}');
      }
      emit(SignUpFailuer(errMessage: "The email has already been taken"));
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
        url,
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
      "gender": editselectedGender
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

  categories() async {
    emit(CategoriesLoading());
    var url = EndPoints.basUrl + EndPoints.categories;
    var headers = {
      'Authorization': "Bearer ${prefs.getString("token")}",
    };

    var response = await dio.request(
      url,
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
      emit(CategoriesSuccess(response.data));
    } else {
      print(response.statusMessage);
    }
  }

  // ignore: non_constant_identifier_names
  Categoryprod(int id) async {
    emit(ProductsLoading());

    var url = "${EndPoints.basUrl}categories/$id/products";
    var headers = {
      'Authorization': "Bearer ${prefs.getString("token")}",
    };

    var response = await dio.request(
      url,
      options: Options(
        method: 'GET',
        headers: headers,
      ),
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
      emit(ProductsSuccess(response.data));
      // Emit the categories list
    } else {
      print(response.statusMessage);
    }
  }

  Future<Product> productsinfo(int id1) async {
    var url = "${EndPoints.basUrl}products/$id1";
    var headers = {'Authorization': "Bearer ${prefs.getString("token")}"};

    var response = await dio.get(url, options: Options(headers: headers));

    if (response.statusCode == 200) {
      return Product.fromJson(
          response.data); // تأكد من تحويل البيانات إلى كائن Product
    } else {
      throw Exception('Failed to load product'); // تفعيل الاستثناء عند الفشل
    }
  }
}
