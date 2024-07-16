// product_repository.dart
import 'dart:convert';
import 'package:c_route_task/data/models/Products.dart';
import 'package:http/http.dart' as http;

class ProductRepository {
  final String apiUrl = "https://dummyjson.com/products";

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body)['products'];
      return body.map((dynamic item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<Product>> searchProducts(String query) async {
    final response = await http.get(Uri.parse('$apiUrl/search?q=$query'));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body)['products'];
      return body.map((dynamic item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to search products');
    }
  }
}
