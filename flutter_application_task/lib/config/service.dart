import 'dart:convert';
import 'package:http/http.dart' as http;

class ServiceConf {
  static const domainNameServer = 'http://localhost:8000';
  static const register = '/api/register';
  static const login = '/api/login';
  static const update = '/api/user';
  static const showUserInfo = '/api/user';
  static const logout = '/api/logout';
  static const categories = '/api/categories';
  static const proudct = '/api/categories/{id}/products';
  static const productinfo = '/api/products/{id}';

  // Fetch products based on category ID
  static Future<List<dynamic>> fetchProducts(int categoryId, String token) async {
    final response = await http.get(
      Uri.parse(ServiceConf.domainNameServer + ServiceConf.proudct.replaceFirst('{id}', categoryId.toString())),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body); // أعد البيانات في شكل قائمة
    } else {
      print('Failed to load products: ${response.body}');
      throw Exception('Failed to load products');
    }
  }

  // Fetch product details
  static Future<dynamic> fetchProductDetails(int productId, String token) async {
    final response = await http.get(
      Uri.parse(ServiceConf.domainNameServer + ServiceConf.productinfo.replaceFirst('{id}', productId.toString())),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body); // أعد البيانات
    } else {
      print('Failed to load product details: ${response.body}');
      throw Exception('Failed to load product details');
    }
  }
}
