
abstract class ApiConsumer {
 Future<dynamic> get(
    String path,{
      Object? data,
      Map<String,dynamic>?quetyParameters, required Map<String, String> headers
    }
  );
 Future<dynamic> post(   String path,{
      Object? data,
      Map<String,dynamic>?quetyParameters,
      bool isFormData = false,
    });
 Future<dynamic> patch(   String path,{
      Object? data,
      Map<String,dynamic>?quetyParameters
    });
  Future<dynamic> delete(   String path,{
      Object? data,
      Map<String,dynamic>?quetyParameters
    });
      Future<dynamic> put(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
    Map<String, dynamic>? headers,
  });
}
