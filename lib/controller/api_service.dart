import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/product_model.dart';

class ApiService {
  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(
        'https://fakestoreapi.com/products?_gl=1*1oi9nv6*_ga*MTE1ODU5MjU5My4xNzExNjM3MTM4*_ga_ZCYG64C7PL*MTcxODg1NjQwOC4xNC4xLjE3MTg4NTcwMDguMC4wLjA.'));

    if (response.statusCode == 200) {
      List<dynamic> productJson = json.decode(response.body);
      List<Product> products =
          productJson.map((json) => Product.fromJson(json)).toList();
      return products;
    } else {
      return[];
    }
  }
}
