import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'product_model.dart';

class CartModel extends ChangeNotifier {
  final Map<Product, int> _products = {};

  CartModel() {
    _loadCart();
  }

  List<Product> get products => _products.keys.toList();

  void addProduct(Product product) {
    if (_products.containsKey(product)) {
      _products[product] = _products[product]! + 1;
    } else {
      _products[product] = 1;
    }
    _saveCart();
    notifyListeners();
  }

  void removeProduct(Product product) {
      _products.remove(product);
    _saveCart();
    notifyListeners();
  }

  void incrementQuantity(Product product) {
    if (_products.containsKey(product)) {
      _products[product] = _products[product]! + 1;
      _saveCart();
      notifyListeners();
    }
  }

  void decrementQuantity(Product product) {
    if (_products.containsKey(product) && _products[product]! > 1) {
      _products[product] = _products[product]! - 1;
      _saveCart();
      notifyListeners();
    }
  }

  double get totalPrice => _products.entries
      .fold(0, (total, current) => total + (current.key.price * current.value));

  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = jsonEncode(_products.entries
        .map((entry) => {'product': entry.key.toJson(), 'quantity': entry.value})
        .toList());
    await prefs.setString('cart', cartData);
  }

  Future<void> _loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = prefs.getString('cart');
    if (cartData != null) {
      final List<dynamic> decodedData = jsonDecode(cartData);
      _products.clear();
      decodedData.forEach((item) {
        final product = Product.fromJson(item['product']);
        final quantity = item['quantity'];
        _products[product] = quantity;
      });
      notifyListeners();
    }
  }

  int getQuantity(Product product) {
    return _products[product] ?? 0;
  }
}
