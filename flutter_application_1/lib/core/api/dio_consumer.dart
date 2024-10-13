import 'package:dio/dio.dart';
import 'package:flutter_application_1/core/api/api_consumer.dart';
import 'package:flutter_application_1/core/api/api_interceptors.dart';
import 'package:flutter_application_1/core/api/end_points.dart';
import 'package:flutter_application_1/core/errors/exceptions.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;
  DioConsumer({required this.dio}) {
    dio.options.baseUrl = EndPoints.basUrl;
    dio.interceptors.add(ApiInterceptors());
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      error: true,
    ));
  }
  @override
  Future delete(String path,
      {dynamic data,
      Map<String, dynamic>? quetyParameters,
      bool isFormData = false}) async {
    try {
      final response = await dio.delete(path,
          data: isFormData ? FormData.fromMap(data) : data,
          queryParameters: quetyParameters);
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future get(
    String path,
      {
        dynamic data,
      Map<String, dynamic>? quetyParameters,
        Map<String, dynamic>? headers,
      bool isFormData = false}) async {
    try {
      final response = await dio.get(path,
          data: isFormData ? FormData.fromMap(data) : data,
          queryParameters: quetyParameters);
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future patch(String path,
      {dynamic data,
      Map<String, dynamic>? quetyParameters,
      bool isFormData = false}) async {
    try {
      final response = await dio.patch(path,
          data: isFormData ? FormData.fromMap(data) : data,
          queryParameters: quetyParameters);
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future post(String path,
      {dynamic data,
      Map<String, dynamic>? quetyParameters,
      bool isFormData = false}) async {
    try {
      final response = await dio.post(path,
          data: isFormData ? FormData.fromMap(data) : data,
          queryParameters: quetyParameters);
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }
  @override
  Future put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool isFromData = false,
  }) async {
    try {
      final response = await dio.put(path,
          data: isFromData ? FormData.fromMap(data) : data,
        
          queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }
}
