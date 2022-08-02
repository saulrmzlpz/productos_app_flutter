import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:productos_app_flutter/models/models.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier {
  final String _baseUrl = 'flutter-lvl1-udemy-default-rtdb.firebaseio.com';
  final List<Product> products = [];
  Product? selectedProduct;
  bool isLoading = true;

  ProductsService() {
    loadProducts();
  }

  Future<List<Product>> loadProducts() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.get(url);
    log(resp.body);
    final Map<String, dynamic> productsMap = json.decode(resp.body);
    productsMap.forEach((key, value) {
      final tempProduct = Product.fromJson(value);
      tempProduct.id = key;
      products.add(tempProduct);
    });
    isLoading = false;
    notifyListeners();
    return products;
  }
}
