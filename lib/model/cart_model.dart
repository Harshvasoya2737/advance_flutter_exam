import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'product_model.dart';

class CartModel extends ChangeNotifier {
  double charge=30.00;
  final List<Product> _products = [];

  CartModel() {
    _loadCart();
  }

  List<Product> get products => _products;

  void addProduct(Product product) {
    _products.add(product);
    _saveCart();
    notifyListeners();
  }

  void removeProduct(Product product) {
    _products.remove(product);
    _saveCart();
    notifyListeners();
  }

  double get totalPrice => _products.fold(0, (total, current) => total + current.price + charge);


  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = jsonEncode(_products.map((product) => product.toJson()).toList());
    await prefs.setString('cart', cartData);
  }

  Future<void> _loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getString('cart');
    if (cartData != null) {
      final List<dynamic> decodedData = jsonDecode(cartData);
      _products.addAll(decodedData.map((item) => Product.fromJson(item)).toList());
      notifyListeners();
    }
  }
}
